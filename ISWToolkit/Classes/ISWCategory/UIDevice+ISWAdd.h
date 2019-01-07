//
//  UIDevice+YCAdd.h
//  youngcity
//
//  Created by yzj on 16/7/29.
//  Copyright © 2016年 Zhitian Network Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (ISWAdd)

+(BOOL) isw_isCameraAvailable;
+(BOOL) isw_isFrontCameraAvailable;
+(BOOL) isw_doesCameraSupportTakingPhotos;
+(BOOL) isw_isPhotoLibraryAvailable;
+ (BOOL)isw_isMediaAuthorized;

@end
