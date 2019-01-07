//
//  YCAFAppHTTPManager.m
//  
//
//  Created by zhitian on 2017/9/2.
//
//

#import "YCAFAppHTTPManager.h"

#import "ISWToolkit.h"

@implementation YCAFAppHTTPManager

+ (instancetype)shareAppManager
{
    static YCAFAppHTTPManager *  _manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _manager = [[YCAFAppHTTPManager alloc]init];

        [_manager.requestSerializer setValue:@"iphone" forHTTPHeaderField:@"INSHOW-DEVICE"];
        
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        [_manager.requestSerializer setValue:version forHTTPHeaderField:@"INSHOW-VERSION"];

        [_manager.requestSerializer setValue:[OpenUDID value] forHTTPHeaderField:@"INSHOW-UUID"];
    
    });
    return _manager;
}

@end

