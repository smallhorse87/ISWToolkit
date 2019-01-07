//
//  ISWActions.h
//  youngcity
//
//  Created by chenxiaosong on 2019/1/2.
//  Copyright © 2019年 Zhitian Network Tech. All rights reserved.
//

#ifndef ISWActions_h
#define ISWActions_h

#import <UIKit/UIKit.h>

typedef void (^ClickedWithParam)(id obj);
typedef void (^Clicked)();
typedef void (^ClickedWithUnsignedInt)(NSUInteger idx);
typedef void (^ClickedWithFloat)(CGFloat value);
typedef void (^InputCompleted)  (NSString *str);
typedef void (^InputMoreCompleted) (NSString *str1,NSString *str2);
typedef void (^ClickMoreCompleted) (NSString *str1,BOOL str2);

typedef enum : NSUInteger {
    NtPhaseNone,
    NtPhaseRequesting,
    NtPhaseResponseSuc,
    NtPhaseResponseFail,
    NtPhaseNoConnection,
    NtPhaseConnectionTimeout
} NtPhaseType;

#endif /* ISWActions_h */
