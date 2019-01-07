//
//  ISWToastUtilities.h
//  youngcity
//
//  Created by zhitian on 2018/1/3.
//  Copyright © 2018年 Zhitian Network Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  MBProgressHUD;

@interface ISWToast : NSObject

+ (void)showLoadingToast;

+ (void)showInfoToast:(NSString*)msg;
+ (void)showSuccToast:(NSString*)msg;
+ (void)showFailToast:(NSString*)msg;

+ (void)showToastDisconnection;
+ (void)showToastConnectionTimeout;

+ (void)dismissToast;

+ (void)showHubProgress:(CGFloat)progress;

@end
