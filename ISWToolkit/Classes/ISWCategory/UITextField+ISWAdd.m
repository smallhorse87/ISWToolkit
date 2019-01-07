//
//  UITextField+YCAdd.m
//  youngcity
//
//  Created by yzj on 16/7/29.
//  Copyright © 2016年 Zhitian Network Tech. All rights reserved.
//

#import "UITextField+ISWAdd.h"

@implementation UITextField (ISWAdd)

- (void)isw_setLeftPadding:(CGFloat)leftPadding
{
    CGRect tfFrame = [self frame];
    tfFrame.size.width = leftPadding;
    UIView *leftview = [[UIView alloc] initWithFrame:tfFrame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
}

@end
