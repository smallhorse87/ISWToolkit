//
//  NSDateFormatter+ChSample.m
//  youngcity
//
//  Created by zhitian on 2016/11/28.
//  Copyright © 2016年 Zhitian Network Tech. All rights reserved.
//

#import "NSDateFormatter+ISWAdd.h"

@implementation NSDateFormatter (ISWAdd)

- (void)isw_setChinaSample
{
    //通过标识创建自定义本地化信息
    NSLocale *userLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [self setLocale:userLocale];
    
    //日历格式
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [self setCalendar:calendar];
}

@end
