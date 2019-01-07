//
//  UIColor+ISWAdd.m
//  youngcity
//
//  Created by chenxiaosong on 2019/1/2.
//  Copyright © 2019年 Zhitian Network Tech. All rights reserved.
//

#import "UIColor+ISWAdd.h"

@implementation UIColor (ISWAdd)

+ (UIColor *)colorWithRGB:(uint32_t)rgbValue {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:1];
}

@end
