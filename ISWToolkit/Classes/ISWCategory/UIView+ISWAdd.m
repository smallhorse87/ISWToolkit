//
//  UIView+YCAdd.m
//  youngcity
//
//  Created by yzj on 16/7/29.
//  Copyright © 2016年 Zhitian Network Tech. All rights reserved.
//

#import "UIView+ISWAdd.h"

@implementation UIView (ISWAdd)

- (void)isw_outlineStyle:(CGFloat)borderWidth borderColor:(UIColor*)color
{
    [self.layer setBorderWidth:borderWidth];
    [self.layer setMasksToBounds:YES];
    self.layer.borderColor= [color CGColor];
}

- (void)isw_roundCorner:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor*)color
{
    [self.layer setCornerRadius:radius];
    [self.layer setBorderWidth:width];
    [self.layer setMasksToBounds:YES];
    self.layer.borderColor= [color CGColor];
}

- (void)isw_roundTopRightCorner:(int)radius {
    [self isw_roundCorner:UIRectCornerTopRight radius:radius];
}
- (void)isw_roundCorner:(UIRectCorner)corners radius:(int) radius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setIsw_x:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setIsw_y:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)isw_x
{
    return self.frame.origin.x;
}

- (CGFloat)isw_y
{
    return self.frame.origin.y;
}

- (void)setIsw_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setIsw_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)isw_height
{
    return self.frame.size.height;
}

- (CGFloat)isw_width
{
    return self.frame.size.width;
}

- (CGFloat)isw_left {
    return self.frame.origin.x;
}

- (void)setIsw_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)isw_top {
    return self.frame.origin.y;
}

- (void)setIsw_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)isw_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setIsw_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)isw_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setIsw_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)isw_centerX {
    return self.center.x;
}

- (void)setIsw_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)isw_centerY {
    return self.center.y;
}

- (void)setIsw_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

@end
