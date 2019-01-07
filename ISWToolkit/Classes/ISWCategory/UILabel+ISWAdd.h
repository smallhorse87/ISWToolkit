//
//  UILabel+CXSAdd.h
//  youngcity
//
//  Created by chenxiaosong on 2017/2/15.
//  Copyright © 2017年 Zhitian Network Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ISWAdd)

- (void)isw_strikeThrought:(NSString *)txt;

+ (instancetype)initWithLabelFont : (UIFont * ) textFont  numerofLine : (NSUInteger * ) lineNumber  textColor: (UIColor *) kColor;

+ (instancetype)initWithLabelFont : (UIFont * ) textFont  textColor: (UIColor *) kColor;

@end
