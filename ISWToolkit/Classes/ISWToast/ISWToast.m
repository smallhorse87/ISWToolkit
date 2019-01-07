//
//  ISWToastUtilities.m
//  youngcity
//
//  Created by zhitian on 2018/1/3.
//  Copyright © 2018年 Zhitian Network Tech. All rights reserved.
//

#import "ISWToast.h"

#import "MBProgressHUD.h"

//todo：example

@implementation ISWToast

+ (void)showToastDisconnection
{
    [self showFailToast:@"网络未连接"];
}

+ (void)showToastConnectionTimeout
{
    [self showFailToast:@"网络连接超时"];
}

+ (void)showLoadingToast
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow
                                                  animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
    });
}

+ (void)showSuccToast:(NSString*)msg
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hub = [self p_buildMBPHUDWithType:MBProgressHUDModeText ToastMsg:msg];
        [hub hideAnimated:YES afterDelay:1.0f];
    });
}

+ (void)showInfoToast:(NSString*)msg
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hub = [self p_buildMBPHUDWithType:MBProgressHUDModeText ToastMsg:msg];
        [hub hideAnimated:YES afterDelay:1.0f];
    });
}

+ (void)showFailToast:(NSString*)msg
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hub = [self p_buildMBPHUDWithType:MBProgressHUDModeText ToastMsg:msg];
        [hub hideAnimated:YES afterDelay:1.0f];
    });
}

+ (void)dismissToast
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow
                             animated:YES];
    });
}

+ (void)showHubProgress:(CGFloat)progress
{
    dispatch_async(dispatch_get_main_queue(), ^{
        static MBProgressHUD *progressHud = nil;
        
        if (progress >= 1.0 && progressHud != nil) {
            [progressHud hideAnimated:YES afterDelay:0.5];
            progressHud = nil;
        } else if(progress<1.0){
            if(progressHud==nil) {
                progressHud = [self p_buildMBPHUDWithType:MBProgressHUDModeAnnularDeterminate ToastMsg:nil];
                progressHud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
            }
            progressHud.progress = progress;
        }
    });
}

+ (MBProgressHUD *)p_buildMBPHUDWithType: (MBProgressHUDMode)mode ToastMsg: (NSString*)msg
{
    UIView *baseView = [UIApplication sharedApplication].keyWindow;
    
    [MBProgressHUD hideHUDForView:baseView animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:baseView animated:YES];
    hud.mode = mode;
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabel.text = msg;
    hud.detailsLabel.font = [UIFont systemFontOfSize:15.0f];
    return hud;
}


@end
