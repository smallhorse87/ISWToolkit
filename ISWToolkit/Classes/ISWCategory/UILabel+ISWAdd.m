//
//  UILabel+CXSAdd.m
//  youngcity
//
//  Created by chenxiaosong on 2017/2/15.
//  Copyright © 2017年 Zhitian Network Tech. All rights reserved.
//

#import "UILabel+ISWAdd.h"
#import "UIFont+ISWAdd.h"
#import "NSString+ISWAdd.h"


@implementation UILabel (ISWAdd)

- (void)isw_strikeThrought:(NSString *)txt
{
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:txt];

    [attriStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, txt.length)];

    self.attributedText = attriStr;
}

- (CGFloat)esitmatedHeight
{
    CGFloat height = [self.text isw_contentHeightWithFont:self.font withinWidth:self.frame.size.width];
    
    return height;
}


+ (instancetype)initWithLabelFont : (UIFont * ) textFont  numerofLine : (NSUInteger * ) lineNumber  textColor: (UIColor *) kColor
{
    UILabel * label = [[self alloc]init];
    
    label.font = textFont;
    
    label.numberOfLines = 0 ;
    
    label.textColor = kColor;
    
    return label;
    
}


+ (instancetype)initWithLabelFont : (UIFont * ) textFont  textColor: (UIColor *) kColor
{
    UILabel * label = [[self alloc]init];
    
    label.font = textFont;
    
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    
    label.textColor = kColor;
    
    return label;
    
}




@end
