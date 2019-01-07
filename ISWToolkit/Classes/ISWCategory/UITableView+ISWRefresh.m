//
//  UITableView+ISWRefresh.m
//  ISWCategory
//
//  Created by chenxiaosong on 2018/1/18.
//  Copyright © 2018年 zhitian. All rights reserved.
//

#import "UITableView+ISWRefresh.h"

#import "MJRefresh.h"

//todo：example

@implementation UITableView (ISWRefresh)

- (void)isw_addRefreshHeaderWithRefreshingBlock:(void(^)(void))block
{
    MJRefreshNormalHeader  *header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    [self setupRefreshHeaderStyle:header];
    self.mj_header = header;
}

- (void)isw_addRefreshHeaderWithTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshNormalHeader  *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    [self setupRefreshHeaderStyle:header];
    self.mj_header = header;
}

- (void)isw_addRefreshFooterWithTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshAutoNormalFooter  *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    [self setupRefreshFooterStyle:footer];
    self.mj_footer = footer;
}

- (void)isw_hideHeaderStateLabel
{
    MJRefreshNormalHeader  *header  = (MJRefreshNormalHeader*)self.mj_header;
    header.stateLabel.hidden = YES;
}

- (void)isw_endHeaderRefreshing
{
    if (self.mj_header == nil) return;
    [self.mj_header endRefreshing];
}

- (void)isw_endFooterRefreshing
{
    if (self.mj_footer == nil) return;
    [self.mj_footer endRefreshing];
}

- (void)isw_endFooterRefreshingWithNoMoreData
{
    if (self.mj_footer == nil) return;
    [self.mj_footer endRefreshingWithNoMoreData];
}

//统一设置上下拉刷新

- (void)setupRefreshFooterStyle: (MJRefreshAutoNormalFooter *)footer
{
    [footer setTitle:@"没有了" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:15];
    footer.triggerAutomaticallyRefreshPercent = 0.0;
    footer.stateLabel.textColor = [UIColor lightGrayColor];
}

- (void)setupRefreshHeaderStyle: (MJRefreshNormalHeader *)header
{
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:15];
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.hidden = YES;
}

@end
