//
//  ISWFlexBaseCell.h
//  youngcity
//
//  Created by chenxiaosong on 2017/11/1.
//  Copyright © 2017年 Zhitian Network Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ISWFlexBaseCell;

typedef  void(^DataLoaded)(ISWFlexBaseCell *cell);

typedef  void(^CellClick) ();

@interface ISWFlexBaseCell : UITableViewCell

- (void)refreshData;

- (void)doneWithLoad;

- (void)hiddenContent:(BOOL)hide;

@property (nonatomic,assign)   CGFloat    height;

@property (nonatomic,readonly) BOOL       toshow;

@property (nonatomic,readonly) BOOL       loaded;

@property (nonatomic,strong) DataLoaded dataLoaded;

@property (nonatomic,strong) CellClick  cellClicked;

+ (CGFloat)fixedHeight;

@end
