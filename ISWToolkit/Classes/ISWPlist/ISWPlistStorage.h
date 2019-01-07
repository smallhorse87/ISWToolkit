//
//  PtSettingUtil.h
//  Besides
//
//  Created by 陈小松 on 14-1-4.
//  Copyright (c) 2014年 Stony Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISWPlistStorage : NSObject

- (instancetype)initWithFileName:(NSString*)fileName;

- (id)  readWithKey:(NSString *)key;

- (void)removeWithKey:(NSString *)key;

- (void)save:(NSString *)value forKey:(NSString *)key;


@end
