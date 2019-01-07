//
//  NSObject+ISWAdd.h
//  youngcity
//
//  Created by chenxiaosong on 2018/12/29.
//  Copyright © 2018年 Zhitian Network Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ISW_WEAKSELF typeof(self) __weak weakSelf = self;
#define ISW_STRONGSELF typeof(self) __strong strongSelf = self;

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ISWAdd)

@end

NS_ASSUME_NONNULL_END
