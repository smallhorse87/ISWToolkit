//
//  UITableView+ISWRefresh.h
//  ISWCategory
//
//  Created by chenxiaosong on 2018/1/18.
//  Copyright © 2018年 zhitian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (ISWRefresh)

- (void)isw_addRefreshHeaderWithTarget:(id)target refreshingAction:(SEL)action;
- (void)isw_addRefreshFooterWithTarget:(id)target refreshingAction:(SEL)action;
- (void)isw_addRefreshHeaderWithRefreshingBlock:(void(^)(void))block;

- (void)isw_endHeaderRefreshing;
- (void)isw_endFooterRefreshing;
- (void)isw_hideHeaderStateLabel;
- (void)isw_endFooterRefreshingWithNoMoreData;

@end
