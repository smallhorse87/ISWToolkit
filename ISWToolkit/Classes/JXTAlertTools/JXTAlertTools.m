//
//  JXTAlertTools.m
//  JXTAlertTools
//
//  Created by JXT on 16/1/27.
//  Copyright © 2016年 JXT. All rights reserved.
//
//  ***
//  *   GitHub:https://github.com/kukumaluCN/JXTAlertTools
//  *   博客:http://www.jianshu.com/users/c8f8558a4b1d/latest_articles
//  *   邮箱:1145049339@qq.com
//  ***
//

#import "JXTAlertTools.h"

#import "UIColor+ISWAdd.h"

#pragma mark - 接口
@interface JXTAlertTools () 

@end


@implementation JXTAlertTools

#pragma mark - alert 简易提示窗 一个按钮或者无按钮
+ (void)showTipAlertViewWith:(UIViewController *)viewController
                       title:(NSString *)title
                     message:(NSString *)message
                 buttonTitle:(NSString *)btnTitle
                 buttonStyle:(JXTAlertActionStyle)btnStyle
{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        //添加按钮
        if (btnTitle) {
            
            UIAlertAction *singleAction = nil;
            switch (btnStyle) {
                case JXTAlertActionStyleDefault:
                    singleAction = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                    }];
                    [alertController addAction:singleAction];
                    break;
                case JXTAlertActionStyleCancel:
                    singleAction = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                        
                    }];
                    [alertController addAction:singleAction];
                    break;
                case JXTAlertActionStyleDestructive:
                    singleAction = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                        
                    }];
                    [alertController addAction:singleAction];
                    break;
                    
                default://默认的
                    singleAction = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                    }];
                    [alertController addAction:singleAction];
                    break;
            }
        }
        
        [viewController presentViewController:alertController animated:YES completion:nil];
        
        //如果没有按钮，自动延迟消失
        if (btnTitle == nil) {
            //此时self指本类
            [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:AlertViewShowTime];
        }

}

#pragma mark - actionSheet 底部简易提示窗 无按钮
+ (void)showBottomTipViewWith:(UIViewController *)viewController
                        title:(NSString *)title
                      message:(NSString *)message
{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        [viewController presentViewController:alertController animated:YES completion:nil];
        
        //如果没有按钮，自动延迟消失
        [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:AlertViewShowTime];
}

#pragma mark - 普通alert初始化 兼容适配
+ (void)showAlertWith:(UIViewController *)viewController
                title:(NSString *)title
              message:(NSString *)message
        callbackBlock:(CallBackBlock)block
    cancelButtonTitle:(NSString *)cancelBtnTitle
destructiveButtonTitle:(NSString *)destructiveBtnTitle
    otherButtonTitles:(NSString *)otherButtonTitles, ...
{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

        //添加按钮
        if (cancelBtnTitle) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                block(0);
            }];
            [alertController addAction:cancelAction];
        }
        if (destructiveBtnTitle) {
            UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveBtnTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                if (cancelBtnTitle) {block(1);}
                else {block(0);}
            }];
            [alertController addAction:destructiveAction];
        }
        if (otherButtonTitles)
        {
            UIAlertAction *otherActions = [UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if (!cancelBtnTitle && !destructiveBtnTitle) {block(0);}
                else if ((cancelBtnTitle && !destructiveBtnTitle) || (!cancelBtnTitle && destructiveBtnTitle)) {block(1);}
                else if (cancelBtnTitle && destructiveBtnTitle) {block(2);}
            }];
            [alertController addAction:otherActions];

            va_list args;//定义一个指向个数可变的参数列表指针;
            va_start(args, otherButtonTitles);//va_start 得到第一个可变参数地址
            NSString *title = nil;
            
            int count = 2;
            if (!cancelBtnTitle && !destructiveBtnTitle) {count = 0;}
            else if ((cancelBtnTitle && !destructiveBtnTitle) || (!cancelBtnTitle && destructiveBtnTitle)) {count = 1;}
            else if (cancelBtnTitle && destructiveBtnTitle) {count = 2;}
            
            while ((title = va_arg(args, NSString *)))//指向下一个参数地址
            {
                count ++;

                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    block(count);
                }];
                [alertController addAction:otherAction];
            }
            va_end(args);//置空指针
        }

        [viewController presentViewController:alertController animated:YES completion:nil];

        //如果没有按钮，自动延迟消失
        if (cancelBtnTitle == nil && destructiveBtnTitle == nil && otherButtonTitles == nil) {
            //此时self指本类
            [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:AlertViewShowTime];
        }
}


#pragma mark - 普通 actionSheet 兼容适配
+ (void)showActionSheetWith:(UIViewController *)viewController
                      title:(NSString *)title
                    message:(NSString *)message
              callbackBlock:(CallBackBlock)block
     destructiveButtonTitle:(NSString *)destructiveBtnTitle
          cancelButtonTitle:(NSString *)cancelBtnTitle
          otherButtonTitles:(NSString *)otherButtonTitles, ...
{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        //添加按钮
        if (destructiveBtnTitle) {
            UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveBtnTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                block(0);
            }];
            [alertController addAction:destructiveAction];
        }
        if (cancelBtnTitle) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                if (destructiveBtnTitle) {block(1);}
                else {block(0);}
            }];
            [alertController addAction:cancelAction];
        }
        if (otherButtonTitles)
        {
            UIAlertAction *otherActions = [UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if (!cancelBtnTitle && !destructiveBtnTitle) {block(0);}
                else if ((cancelBtnTitle && !destructiveBtnTitle) || (!cancelBtnTitle && destructiveBtnTitle)) {block(1);}
                else if (cancelBtnTitle && destructiveBtnTitle) {block(2);}
            }];
            [alertController addAction:otherActions];
            
            va_list args;//定义一个指向个数可变的参数列表指针;
            va_start(args, otherButtonTitles);//va_start 得到第一个可变参数地址
            NSString *title = nil;
            
            int count = 2;
            if (!cancelBtnTitle && !destructiveBtnTitle) {count = 0;}
            else if ((cancelBtnTitle && !destructiveBtnTitle) || (!cancelBtnTitle && destructiveBtnTitle)) {count = 1;}
            else if (cancelBtnTitle && destructiveBtnTitle) {count = 2;}
            
            while ((title = va_arg(args, NSString *)))//指向下一个参数地址
            {
                count ++;
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    block(count);
                }];
                [alertController addAction:otherAction];
            }
            va_end(args);//置空指针
        }
        
        [viewController presentViewController:alertController animated:YES completion:nil];
        
        //如果没有按钮，自动延迟消失
        if (cancelBtnTitle == nil && destructiveBtnTitle == nil && otherButtonTitles == nil) {
            //此时self指本类
            [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:AlertViewShowTime];
        }
    
}


#pragma mark - 多按钮列表数组排布alert初始化 兼容适配
+ (void)showArrayAlertWith:(UIViewController *)viewController
                     title:(NSString *)title
                   message:(NSString *)message
             callbackBlock:(CallBackBlock)block
         cancelButtonTitle:(NSString *)cancelBtnTitle
     otherButtonTitleArray:(NSArray *)otherBtnTitleArray
     otherButtonStyleArray:(NSArray *)otherBtnStyleArray
{

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        //添加按钮
        if (cancelBtnTitle) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                block(0);
            }];
            [alertController addAction:cancelAction];
        }
        if (otherBtnTitleArray && otherBtnTitleArray.count)
        {
            int count = 0;
            if (cancelBtnTitle) {count = 1;}
            else {count = 0;}
            
            for (int i = 0; i < otherBtnTitleArray.count; i ++) {
                
                NSNumber * styleNum = otherBtnStyleArray[i];
                UIAlertActionStyle actionStyle =  styleNum.integerValue;
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherBtnTitleArray[i] style:actionStyle handler:^(UIAlertAction *action) {
                    block(count);
                }];
                [alertController addAction:otherAction];
                
                count ++;
            }
        }
        
        [viewController presentViewController:alertController animated:YES completion:nil];
        
        //如果没有按钮，自动延迟消失
        if (cancelBtnTitle == nil && (otherBtnStyleArray == nil || otherBtnStyleArray.count == 0)) {
            //此时self指本类
            [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:AlertViewShowTime];
        }
}

#pragma mark - 多按钮列表数组排布actionSheet初始化 兼容适配
+ (void)showArrayActionSheetWith:(UIViewController *)viewController
                           title:(NSString *)title
                         message:(NSString *)message
                   callbackBlock:(CallBackBlock)block
               cancelButtonTitle:(NSString *)cancelBtnTitle
          destructiveButtonTitle:(NSString *)destructiveBtnTitle
           otherButtonTitleArray:(NSArray *)otherBtnTitleArray
           otherButtonStyleArray:(NSArray *)otherBtnStyleArray
{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        //添加按钮
        if (cancelBtnTitle) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                block(0);
            }];
            [alertController addAction:cancelAction];
        }
        if (otherBtnTitleArray && otherBtnTitleArray.count)
        {
            int count = 0;
            if (cancelBtnTitle) {count = 1;}
            else {count = 0;}
            
            for (int i = 0; i < otherBtnTitleArray.count; i ++) {
                
                NSNumber * styleNum = otherBtnStyleArray[i];
                UIAlertActionStyle actionStyle =  styleNum.integerValue;
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherBtnTitleArray[i] style:actionStyle handler:^(UIAlertAction *action) {
                    block(count);
                }];
                [alertController addAction:otherAction];
                
                count ++;
            }
        }
        
        [viewController presentViewController:alertController animated:YES completion:nil];
        
        //如果没有按钮，自动延迟消失
        if (cancelBtnTitle == nil && (otherBtnStyleArray == nil || otherBtnStyleArray.count == 0)) {
            //此时self指本类
            [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:AlertViewShowTime];
        }


}


+ (void)dismissAlertController:(UIAlertController *)alert
{
    [alert dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 是否有alert显示
+ (BOOL)isAlertShowNow
{
        UIViewController * activityVC = [self activityViewController];
        if([activityVC isKindOfClass:[UIAlertController class]]){
            return YES;
        }
        else if([activityVC isKindOfClass:[UINavigationController class]]){
            UINavigationController * nav = (UINavigationController*)activityVC;
            if([nav.visibleViewController isKindOfClass:[UIAlertController class]]){
                return YES;
            }
        }
        return NO;

}


#pragma mark - 查找当前活动窗口
+ (UIViewController *)activityViewController
{
    UIViewController* activityViewController = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}


#pragma mark - diy
+ (void)showDiyAlertWith:(UIViewController *)viewController
                   title:(NSString *)title
              titleColor:(UIColor *)titleColor
                 message:(NSString *)message
            messageColor:(UIColor *)messageColor
           callbackBlock:(CallBackBlock)block
       cancelButtonTitle:(NSString *)cancelBtnTitle
  destructiveButtonTitle:(NSString *)destructiveBtnTitle
       otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION
{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

        //自定义title
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertControllerStr addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor colorWithRGB:0x4d4d4d]
                                   range:NSMakeRange(0, title.length)];
        [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, title.length)];
        [alertController setValue:alertControllerStr forKey:@"attributedTitle"];

        //自定义message颜色
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:messageColor range:NSMakeRange(0, message.length)];
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, message.length)];
        [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
        
        //添加按钮
        if (cancelBtnTitle) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                block(0);
            }];
            
            //自定义颜色
            [cancelAction setValue:[UIColor colorWithRGB:0x989898]
                            forKey:@"titleTextColor"];
            
            [alertController addAction:cancelAction];
        }
        if (destructiveBtnTitle) {
            UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveBtnTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                if (cancelBtnTitle) {block(1);}
                else {block(0);}
            }];
            [alertController addAction:destructiveAction];
        }
        if (otherButtonTitles)
        {
            UIAlertAction *otherActions = [UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if (!cancelBtnTitle && !destructiveBtnTitle) {block(0);}
                else if ((cancelBtnTitle && !destructiveBtnTitle) || (!cancelBtnTitle && destructiveBtnTitle)) {block(1);}
                else if (cancelBtnTitle && destructiveBtnTitle) {block(2);}
            }];
            [alertController addAction:otherActions];
            
            va_list args;//定义一个指向个数可变的参数列表指针;
            va_start(args, otherButtonTitles);//va_start 得到第一个可变参数地址
            NSString *title = nil;
            
            int count = 2;
            if (!cancelBtnTitle && !destructiveBtnTitle) {count = 0;}
            else if ((cancelBtnTitle && !destructiveBtnTitle) || (!cancelBtnTitle && destructiveBtnTitle)) {count = 1;}
            else if (cancelBtnTitle && destructiveBtnTitle) {count = 2;}
            
            while ((title = va_arg(args, NSString *)))//指向下一个参数地址
            {
                count ++;
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    block(count);
                }];
                [alertController addAction:otherAction];
            }
            va_end(args);//置空指针
        }
        
        [viewController presentViewController:alertController animated:YES completion:nil];
        
        //如果没有按钮，自动延迟消失
        if (cancelBtnTitle == nil && destructiveBtnTitle == nil && otherButtonTitles == nil) {
            //此时self指本类
            [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:AlertViewShowTime];
        }


}




@end
