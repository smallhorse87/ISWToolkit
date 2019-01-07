//
//  NSArray+ISWAdd.h
//  youngcity
//
//  Created by mac on 2019/1/1.
//  Copyright © 2019 Zhitian Network Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

#define isEmptyArray(array) ([array isKindOfClass:[NSNull class]] || (array.count <=0)  || (array == nil))

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (ISWAdd)

@end

NS_ASSUME_NONNULL_END
