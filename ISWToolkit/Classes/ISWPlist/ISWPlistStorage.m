//
//  PtSettingUtil.m
//  Besides
//
//  Created by 陈小松 on 14-1-4.
//  Copyright (c) 2014年 Stony Chen. All rights reserved.
//

#import "ISWPlistStorage.h"

@interface ISWPlistStorage()
{
    NSString *filePath;
}
@end

@implementation ISWPlistStorage

- (instancetype)initWithFileName:(NSString*)fileName
{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    }
    return self;
    
}

-(id)readWithKey:(NSString *)key
{
    NSMutableDictionary *valuesDic = [self readPlistFile:filePath];
    
    if(!valuesDic)
        return nil;
    
    return [valuesDic objectForKey:key];
}

-(void)removeWithKey:(NSString*)key
{
    NSMutableDictionary *valuesDic = [self readPlistFile:filePath];
    
    [valuesDic removeObjectForKey:key];

    [self savePlistFile:filePath content:valuesDic];
}

-(void) save:(NSString *)value forKey:(NSString *)key
{
    NSAssert([value isKindOfClass:[NSString class]], @"just accept nsstring as value");
    
    NSMutableDictionary *valuesDic = [self readPlistFile:filePath];
    
    if(valuesDic == nil)
        valuesDic = [[NSMutableDictionary alloc] init];
    
    [valuesDic setObject:value forKey:key];
    
    [self savePlistFile:filePath content:valuesDic];
}

#pragma mark - private
-(NSMutableDictionary*)readPlistFile:(NSString*)filePath
{
    NSMutableDictionary *valuesDic = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    
    if(valuesDic == nil) {
        [valuesDic setObject:@"dummy" forKey:@"dummy"];
    }

    return valuesDic;
}

-(BOOL)savePlistFile:(NSString*)filePath content:(NSDictionary*)valuesDic
{
    BOOL rlt = [valuesDic writeToFile:filePath atomically:YES];
    
    return rlt;
}


@end
