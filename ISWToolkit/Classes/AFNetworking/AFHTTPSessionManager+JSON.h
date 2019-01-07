//
//  AFHTTPSessionManager+JSON.h
//  博地商户端
//
//  Created by yabei on 16/6/7.
//  Copyright © 2016年 com.bodi.merchant. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFHTTPSessionManager (JSON)

+ (instancetype)GETAFURLSessionWithRequest:(NSString *)urlstring param:(NSDictionary *)params success:(void (^)(id JSON))success failure:(void (^)(NSError *error))failure;

+ (instancetype)POSTAFURLSessionWithRequest:(NSString *)urlstring param:(NSDictionary *)params success:(void (^)(id JSON))success failure:(void (^)(NSError *error))failure;

+(NSTimeInterval)offsetTimeInSecondBetweenServerAndLocal;

@end
