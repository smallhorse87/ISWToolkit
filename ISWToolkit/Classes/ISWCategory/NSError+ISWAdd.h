//
//  NSError+ISWAdd.h
//  youngcity
//
//  Created by mac on 2019/1/1.
//  Copyright © 2019 Zhitian Network Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FastErr(domain,errCode) [[NSError alloc] initWithDomain:domain code:errCode userInfo:nil]

NS_ASSUME_NONNULL_BEGIN

@interface NSError (ISWAdd)

@end

NS_ASSUME_NONNULL_END
