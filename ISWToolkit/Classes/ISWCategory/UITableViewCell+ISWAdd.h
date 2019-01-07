//
//  UITableViewCell+ISWAdd.h
//  ISWCategory
//
//  Created by chenxiaosong on 2018/1/16.
//  Copyright © 2018年 zhitian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (ISWAdd)

- (void)isw_noSeparator;

- (void)isw_separatorZeroInset;

- (void)isw_separatorInset12;

- (void)isw_separatorInset:(CGFloat)inset;

+(UITableViewCell *) isw_groupBreakWithSeparatorInset:(CGFloat)inset backgroundColor:(UIColor*)bgColor;

@end
