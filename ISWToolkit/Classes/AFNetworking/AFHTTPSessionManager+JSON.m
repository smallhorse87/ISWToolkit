//
//  AFHTTPSessionManager+JSON.m
//  博地商户端
//
//  Created by yabei on 16/6/7.
//  Copyright © 2016年 com.bodi.merchant. All rights reserved.
//

#import "AFHTTPSessionManager+JSON.h"

#import "ISWToolkit.h"

#import "YCAFAppHTTPManager.h"

NSTimeInterval gDiffSecond = 0;

@implementation AFHTTPSessionManager (JSON)

+ (instancetype)GETAFURLSessionWithRequest:(NSString *)urlstring param:(NSDictionary *)params success:(void (^)(id JSON))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"INSHOW-DEVICE"];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:version forHTTPHeaderField:@"INSHOW-VERSION"];
    
    [manager.requestSerializer setValue:[OpenUDID value] forHTTPHeaderField:@"INSHOW-UUID"];
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    
    manager.responseSerializer.acceptableContentTypes = contentTypes;
    manager.requestSerializer.timeoutInterval = 30;
    
    [manager GET:urlstring parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [self calibrateLocalTime:responseObject[@"serverTime"]];
        
        if (success) {
            if ([self responeseCorrectly:responseObject]) {
                success(responseObject[@"data"]);
            } else {
                NSString  *errMsg = [responseObject objectForKey:@"msg"];
                NSInteger errCode = [[responseObject objectForKey:@"ret"] integerValue];
                NSError   *error  = [[NSError alloc] initWithDomain:errMsg code:errCode userInfo:nil];
                failure(error);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

    return manager;
}

+ (instancetype)POSTAFURLSessionWithRequest:(NSString *)urlstring param:(NSDictionary *)params success:(void (^)(id JSON))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"INSHOW-DEVICE"];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:version forHTTPHeaderField:@"INSHOW-VERSION"];
    
    [manager.requestSerializer setValue:[OpenUDID value] forHTTPHeaderField:@"INSHOW-UUID"];
    
//    // 写的单例解决AFN内存泄漏问题
//    YCAFAppHTTPManager *manager  = [YCAFAppHTTPManager shareAppManager];
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    
    manager.responseSerializer.acceptableContentTypes = contentTypes;
    manager.requestSerializer.timeoutInterval = 30;
    
    [params setValue:@"ios" forKey:@"HTTP_INSHOW_DEVICE"];
        
    [manager POST:urlstring parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            [self calibrateLocalTime:responseObject[@"serverTime"]];

            if ([self responeseCorrectly:responseObject]) {
                success(responseObject[@"data"]);
            } else {
                NSString  *errMsg = [responseObject objectForKey:@"msg"];
                NSInteger errCode = [[responseObject objectForKey:@"ret"] integerValue];
                NSError   *error  = [[NSError alloc] initWithDomain:errMsg code:errCode userInfo:nil];
                failure(error);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return manager;
}

+ (BOOL)responeseCorrectly:(NSDictionary *)responseDic
{
    int ret = [[responseDic objectForKey:@"ret"] intValue];
    
    if(ret==0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(void)calibrateLocalTime:(NSString*)serverTimeStr
{
    if(isEmptyString(serverTimeStr))
        return;

    NSTimeInterval localTime = [[NSDate alloc] init].timeIntervalSince1970;
    
    gDiffSecond = [serverTimeStr integerValue] - localTime;
}

+(NSTimeInterval)offsetTimeInSecondBetweenServerAndLocal
{
    return gDiffSecond;
}

@end
