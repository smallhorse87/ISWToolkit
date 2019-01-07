//
//  UIScreen+ISWAdd.m
//  ISWCategory
//
//  Created by chenxiaosong on 2018/1/16.
//  Copyright © 2018年 zhitian. All rights reserved.
//

#import "UIScreen+ISWAdd.h"

@implementation UIScreen (ISWAdd)

+ (CGFloat)isw_width
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)isw_height
{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)isw_scale
{
    return [UIScreen mainScreen].scale;
}

+ (CGFloat)isw_pixel
{
    return 1.0f/[UIScreen mainScreen].scale;
}

+ (CGFloat)isw_point
{
    return 1.0f;
}

+ (CGRect)isw_size
{
    return [UIScreen mainScreen].bounds;
}

@end
