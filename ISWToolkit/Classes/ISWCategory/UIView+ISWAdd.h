//
//  UIView+YCAdd.h
//  youngcity
//
//  Created by stony on 16/7/29.
//  Copyright © 2016年 Zhitian Network Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ISWAdd)

- (void)isw_outlineStyle:(CGFloat)borderWidth borderColor:(UIColor*)color;
- (void)isw_roundCorner:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor*)color;

@property (nonatomic, assign) CGFloat isw_x;
@property (nonatomic, assign) CGFloat isw_y;
@property (nonatomic, assign) CGFloat isw_width;
@property (nonatomic, assign) CGFloat isw_height;

@property (nonatomic) CGFloat isw_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat isw_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat isw_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat isw_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat isw_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat isw_centerY;     ///< Shortcut for center.y
@end
