//
//  UIButton+XSCAdd.h
//  搏乐管理端
//
//  Created by zhitian on 15/12/7.
//  Copyright © 2015年 song GG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ISWAdd)

- (void)isw_setStyleRound:(CGFloat)radius normalColor:(UIColor *)nColor highlightColor:(UIColor *)hColor disableColor: (UIColor *)dColor;

-(void)isw_addClickAction:(SEL)action target:(id)owner;
-(void)isw_removeClickAction;

- (void)isw_titleForAllState:(NSString *)title;
- (void)isw_imageForAllState:(UIImage*)img;
- (void)isw_titleColorForAllState:(UIColor *)color;
- (void)isw_bgImageForAllState:(UIImage*)img;

//hanli
- (void) isw_setButtonFont : (CGFloat) textSize  normalTitle : (NSString *)normalTitle
            selectedTitle :(NSString *)selectdTitle  setSelecdColor: (UIColor *)selecdColor setNormalColor : (UIColor *) NormalColor;

- (void) isw_setButtonFont : (CGFloat) textSize  title : (NSString *)title  setSelecdColor:(UIColor *) selecedColor setNormalColor : (UIColor *) normalColor;

 +(UIButton *)isw_creatButtonWithButtonName : (NSString *)buttonName  backgroundColor: (UIColor *) kcolor    buttonClick :(SEL)click target:(id)owner;

- (void)isw_imageForNormal :(UIImage *)normalImage highlighted: (UIImage *)highlightedImage;

- (void)isw_addAnimation ;

- (void)isw_setBackgroundColor:(UIColor *)color forState:(UIControlState)state;



@end
