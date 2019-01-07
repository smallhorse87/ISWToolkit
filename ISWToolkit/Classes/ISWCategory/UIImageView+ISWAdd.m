//
//  UIImageView+ISWAdd.m
//  youngcity
//
//  Created by mac on 2019/1/2.
//  Copyright © 2019 Zhitian Network Tech. All rights reserved.
//
#import "UIImageView+ISWAdd.h"

#import "UIImage+ISWAdd.h"

#import <SDWebImage/UIImageView+WebCache.h>

static NSString *placeholderImageResName;

static UIColor  *placeholderColor;

@implementation UIImageView (ISWAdd)

+ (void)configPlaceHolder:(NSString*)imgResName color:(UIColor*)color
{
    placeholderImageResName = imgResName;
    placeholderColor        = color;
}

+ (NSString *)keyOfPlaceholderImage:(CGSize)size
{
    return [NSString stringWithFormat:@"name_%@_width_%ld_height_%ld",placeholderImageResName,(long)(size.width),(long)(size.height)];
}

- (void)isw_setImageWithUrlStirng: (NSString*)url  placeholderWithSize:(CGSize)size
{
    //生成，获取占位图
    UIImage *resImg = [UIImage imageNamed:placeholderImageResName];
    NSAssert(resImg.size.width == resImg.size.height, @"must be square");
    
    UIImage *cachedImg      = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[UIImageView keyOfPlaceholderImage:size]];
    
    UIImage *placeholderImg = nil;
    
    if(size.width==size.height) {
        placeholderImg = resImg;
    } else if(cachedImg) {
        placeholderImg = cachedImg;
    } else {
        placeholderImg =[resImg isw_imageByResizeToSize:size fillColor:placeholderColor];
        [[SDImageCache sharedImageCache] storeImage:placeholderImg forKey:[UIImageView keyOfPlaceholderImage:size]];
    }
    
    //设置网络图片
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImg];
}

@end
