//
//  UIFont+CXSAdd.m
//  youngcity
//
//  Created by chenxiaosong on 2017/2/21.
//  Copyright © 2017年 Zhitian Network Tech. All rights reserved.
//

#import "UIFont+ISWAdd.h"

@implementation UIFont (ISWAdd)

+ (UIFont*)isw_Pingfang:(CGFloat)size
{
    return [UIFont isw_Pingfang:size weight:UIFontWeightRegular];
}

+ (UIFont*)isw_Pingfang:(CGFloat)size weight:(CGFloat)weigth
{
    NSString *fontName = nil;
    
    if(weigth == UIFontWeightUltraLight) {
        fontName = @"PingFangSC-Ultralight";
    } else if (weigth == UIFontWeightThin) {
        fontName = @"PingFangSC-Thin";
    } else if (weigth == UIFontWeightLight) {
        fontName = @"PingFangSC-Light";
    } else if (weigth == UIFontWeightRegular) {
        fontName = @"PingFangSC-Regular";
    } else if (weigth == UIFontWeightMedium) {
        fontName = @"PingFangSC-Medium";
    } else if (weigth == UIFontWeightSemibold) {
        fontName = @"PingFangSC-Semibold";
    }

    NSAssert(fontName!=nil, @"non-supported font");
    
    return [UIFont fontWithName:fontName size:size];
}

@end
