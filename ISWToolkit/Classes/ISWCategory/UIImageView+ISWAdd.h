//
//  UIImageView+ISWAdd.h
//  youngcity
//
//  Created by mac on 2019/1/2.
//  Copyright © 2019 Zhitian Network Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (ISWAdd)

- (void)isw_setImageWithUrlStirng: (NSString*)url  placeholderWithSize:(CGSize)size;

+ (void)configPlaceHolder:(NSString*)imgResName color:(UIColor*)color;

@end

NS_ASSUME_NONNULL_END
