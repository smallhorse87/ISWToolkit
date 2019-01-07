//
// ISWFlexBaseCell.m
//  youngcity
//
//  Created by chenxiaosong on 2017/11/1.
//  Copyright © 2017年 Zhitian Network Tech. All rights reserved.
//

#import "ISWFlexBaseCell.h"

#import "UITableViewCell+ISWAdd.h"

@interface ISWFlexBaseCell()

@property (nonatomic,assign) BOOL       loaded;

@end

@implementation ISWFlexBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)init
{
    self = [super init];

    if(self) {
        [self isw_noSeparator];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _loaded = NO;
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshData
{
    _loaded = NO;
}

- (void)doneWithLoad
{
    _loaded = YES;

    if(_dataLoaded) _dataLoaded(self);
}

- (void)setHeight:(CGFloat)height
{
    _height = height;

    [self hiddenContent:height>0?NO:YES];

}

- (BOOL)toshow
{
    if(_height>0)
        return YES;

    return NO;
}

- (void)hiddenContent:(BOOL)hide
{
    //NSAssert(NO, @"to override it");
}

+ (CGFloat)fixedHeight
{
    NSAssert(NO, @"wrong branch");
   
    return -1.0;
}

@end
