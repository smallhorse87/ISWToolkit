//
//  PHAsset+image.m
//  博地商户端
//
//  Created by yabei on 16/7/7.
//  Copyright © 2016年 com.bodi.merchant. All rights reserved.
//

#import "PHAsset+ISWAdd.h"

@implementation PHAsset (ISWAdd)

- (UIImage *)isw_getImageFromPHAsset
{
    @autoreleasepool {
        __block UIImage *image = nil;
        
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        //同步获取图片,只会返回1张图
        options.synchronous = YES;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        CGFloat W = self.pixelWidth;
        CGFloat H = self.pixelHeight;
        
        CGSize assetSize = CGSizeMake(W, H);
        
        [[PHImageManager defaultManager] requestImageForAsset:self targetSize:assetSize contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {
            
            image = result;
            
        }];
        
        return image;
    }

}

@end
