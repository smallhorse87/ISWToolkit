//
//  ISWValidator.h
//  youngcity
//
//  Created by chenxiaosong on 2018/1/22.
//  Copyright © 2018年 Zhitian Network Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISWValidator : NSObject

-(void)addRegx:(NSString *)strRegx withMsg:(NSString *)msg;

-(BOOL)validateOn:(NSString*)str err:(NSError**)err;

@end
