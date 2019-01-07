//
//  UITableViewCell+ISWAdd.m
//  ISWCategory
//
//  Created by chenxiaosong on 2018/1/16.
//  Copyright © 2018年 zhitian. All rights reserved.
//

#import "UITableViewCell+ISWAdd.h"

#import "UIScreen+ISWAdd.h"

@implementation UITableViewCell (ISWAdd)

+(UITableViewCell *) isw_groupBreakWithSeparatorInset:(CGFloat)inset backgroundColor:(UIColor*)bgColor
{
    UITableViewCell* separatorCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    separatorCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [separatorCell isw_separatorInset:inset];
    
    separatorCell.frame = CGRectMake(0, 0, [UIScreen isw_width], 10.0);
    
    separatorCell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:separatorCell.contentView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.
                                                                         constant:10];
    [separatorCell.contentView addConstraint:heightConstraint];
    
    separatorCell.backgroundColor             = bgColor;
    separatorCell.contentView.backgroundColor = bgColor;
    
    return separatorCell;
}

- (void)isw_noSeparator
{
    [self isw_separatorInset:[UIScreen isw_width]];
}

- (void)isw_separatorZeroInset
{
    [self isw_separatorInset:0.0];
}

- (void)isw_separatorInset12
{
    [self isw_separatorInset:12.0];
}

#pragma mark - utility

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
