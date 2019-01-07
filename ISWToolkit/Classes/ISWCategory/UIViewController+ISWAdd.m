//
//  OmgMoreMenu+UIViewController.m
//  youngcity
//
//  Created by Apple on 15/9/15.
//  Copyright (c) 2015年 Zhitian Network Tech. All rights reserved.
//

#import "UIViewController+ISWAdd.h"

@implementation UIViewController (ISWAdd)

#pragma mark - 推出相册nav
- (void)presentVC:(UIViewController *)vc
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];

    [self presentViewController:nav animated:YES completion:nil];
}

- (void)addTapToresignFirstResponder
{
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.view endEditing:YES];
}

@end
