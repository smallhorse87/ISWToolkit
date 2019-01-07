//
//  UITableView+ISWAdd.m
//  ISWCategory
//
//  Created by chenxiaosong on 2018/1/16.
//  Copyright © 2018年 zhitian. All rights reserved.
//

#import "UITableView+ISWAdd.h"

#import "UIScreen+ISWAdd.h"

@implementation UITableView (ISWAdd)

- (void)isw_noSeparator
{
    [self isw_separatorInset:[UIScreen isw_width]];
}

- (void)isw_separatorInset:(CGFloat)inset
{
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0,inset,0,0)];
    }
}

@end
