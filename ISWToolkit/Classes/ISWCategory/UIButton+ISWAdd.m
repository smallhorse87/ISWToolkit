//
//  UIButton+XSCAdd.m
//  搏乐管理端
//
//  Created by zhitian on 15/12/7.
//  Copyright © 2015年 song GG. All rights reserved.
//

#import "UIButton+ISWAdd.h"
#import "UIImage+ISWAdd.h"
#import "UIFont+ISWAdd.h"

@implementation UIButton (ISWAdd)

- (void)isw_setStyleRound:(CGFloat)radius normalColor:(UIColor *)nColor highlightColor:(UIColor *)hColor disableColor: (UIColor *)dColor
{
    [self setBackgroundImage:[UIImage isw_roundImageWithRadius:radius fillColor:nColor]
                    forState:UIControlStateNormal];

    [self setBackgroundImage:[UIImage isw_roundImageWithRadius:radius fillColor:hColor]
                    forState:UIControlStateHighlighted];
    
    [self setBackgroundImage:[UIImage isw_roundImageWithRadius:radius fillColor:dColor]
                    forState:UIControlStateDisabled];
}

-(void)isw_addClickAction:(SEL)action target:(id)owner
{
    [self isw_removeClickAction];

    [self addTarget:owner action:action forControlEvents:UIControlEventTouchUpInside];
}

-(void)isw_removeClickAction
{
    [self removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
}

- (void)isw_bgImageForAllState:(UIImage*)img
{
    [self setBackgroundImage:img forState:UIControlStateNormal];
    [self setBackgroundImage:img forState:UIControlStateHighlighted];
    [self setBackgroundImage:img forState:UIControlStateDisabled];
    [self setBackgroundImage:img forState:UIControlStateSelected];
}

- (void)isw_imageForAllState:(UIImage*)img
{
    [self setImage:img forState:UIControlStateNormal];
    [self setImage:img forState:UIControlStateHighlighted];
    [self setImage:img forState:UIControlStateDisabled];
    [self setImage:img forState:UIControlStateSelected];
}

- (void) isw_titleColorForAllState:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateDisabled];
    [self setTitleColor:color forState:UIControlStateSelected];
}

- (void) isw_titleForAllState:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
    [self setTitle:title forState:UIControlStateDisabled];
    [self setTitle:title forState:UIControlStateSelected];
}
- (void)isw_imageForNormal :(UIImage *)normalImage highlighted: (UIImage *)highlightedImage
{
    [self setImage:normalImage forState:UIControlStateNormal];
    [self setImage:highlightedImage forState:UIControlStateHighlighted];
    
}

//hanli
- (void) isw_setButtonFont : (CGFloat) textSize  normalTitle : (NSString *)normalTitle
    selectedTitle :(NSString *)selectdTitle  setSelecdColor: (UIColor *)selecdColor setNormalColor : (UIColor *) NormalColor
{

    self.titleLabel.font = [UIFont isw_Pingfang:textSize];

    [self setTitle:normalTitle forState:UIControlStateNormal];
    
    selectdTitle? [self setTitle:selectdTitle forState:UIControlStateSelected]:0 ;
    
    [self setTitleColor: selecdColor  forState:UIControlStateSelected];
    
    [self setTitleColor:NormalColor forState:UIControlStateNormal];
}

- (void) isw_setButtonFont : (CGFloat) textSize  title : (NSString *)title  setSelecdColor:(UIColor *) selecedColor setNormalColor : (UIColor *) normalColor
{
    
    self.titleLabel.font = [UIFont isw_Pingfang:textSize];
    
    [self setTitle:title forState:UIControlStateNormal];
    
    [self setTitleColor: selecedColor forState:UIControlStateSelected];
    
    [self setTitleColor:normalColor forState:UIControlStateNormal];
    
}

+ (UIButton *)isw_creatButtonWithButtonName : (NSString *)buttonName  backgroundColor: (UIColor *) kcolor   buttonClick :(SEL)click target:(id)owner
{
    UIButton  *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button isw_titleForAllState:buttonName];
    button.backgroundColor = kcolor;
    button.alpha  = 0.5;
    [button isw_addClickAction:click target:owner];
    
    return button;
}

- (void)isw_addAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.duration = 0.5;
    animation.values = @[@0.4,@1,@0.9,@1];
    animation.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:animation forKey:@"transform.scale"];
}

- (void)isw_setBackgroundColor:(UIColor *)color forState:(UIControlState)state
{
    [self setBackgroundImage:[self imageWithColor:color] forState:state];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}




@end
