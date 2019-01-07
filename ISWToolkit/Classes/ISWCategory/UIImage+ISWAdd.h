//
//  UIImage+YCAdd.h
//  youngcity
//
//  Created by stony on 15/12/28.
//  Copyright © 2015年 Zhitian Network Tech. All rights reserved.
//

#import "UIKit/UIKit.h"

@interface UIImage (ISWAdd)

+ (UIImage *)isw_imageNamedWithWHRatio:(NSString *)name;

- (NSData *)isw_imageByScalingToWithSize:(CGFloat)len;
- (UIImage *)isw_imageByScalingAndCroppingWithSize:(CGSize)targetSize;

+ (UIImage *)isw_roundImageWithRadius:(CGFloat)radius fillColor:(UIColor *)color;

+ (UIImage *)isw_roundImageWithRadius:(CGFloat)radius
                        fillColor:(UIColor *)color
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor;

+ (UIImage *)isw_imageWithColor:(UIColor *)color;
//空白背景页面
+ (UIImage*) isw_getImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

+ (UIImage *)isw_imageWithBase64Str:(NSString *)str;

- (UIImage*)isw_imageInScale:(CGFloat)scale;

+ (UIImage *)isw_animatedImageWithAnimatedGIFURL:(NSURL *)theURL;

- (UIImage *)isw_imageByResizeToSize:(CGSize)size fillColor:(UIColor*)fillcolor;

+(UIImage*) isw_imageWithQRCode:(NSString*)code width:(CGFloat)width;

@end

