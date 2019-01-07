//
//  YCAFAppHTTPManager.h
//  
//
//  Created by zhitian on 2017/9/2.
//
//

#import <AFNetworking/AFNetworking.h>

@interface YCAFAppHTTPManager : AFHTTPSessionManager

+ (instancetype)shareAppManager;
   
@end
