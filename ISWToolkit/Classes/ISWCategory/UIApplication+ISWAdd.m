//
//  UIApplication+YCAdd.m
//  youngcity
//
//  Created by chenxiaosong on 2017/11/1.
//  Copyright © 2017年 Zhitian Network Tech. All rights reserved.
//

#import "UIApplication+ISWAdd.h"

@implementation UIApplication (ISWAdd)

+ (NSString *)isw_appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}


@end
