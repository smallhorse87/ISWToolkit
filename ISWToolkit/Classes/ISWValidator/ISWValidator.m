//
//  ISWValidator.m
//  youngcity
//
//  Created by chenxiaosong on 2018/1/22.
//  Copyright © 2018年 Zhitian Network Tech. All rights reserved.
//

#import "ISWValidator.h"

@interface ISWValidator ()
{
    NSMutableArray *arrRegx;
}
@end

@implementation ISWValidator


- (instancetype)init
{
    self = [super init];
    if (self) {
        arrRegx = [[NSMutableArray alloc] init];
    }
    return self;
}


-(void)addRegx:(NSString *)strRegx withMsg:(NSString *)msg{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:strRegx,@"regx",msg,@"msg", nil];
    [arrRegx addObject:dic];
}

-(BOOL)validateOn:(NSString*)str err:(NSError**)err
{
    *err = nil;

    for (int i=0; i<[arrRegx count]; i++) {
        NSDictionary *dic=[arrRegx objectAtIndex:i];
        if(![[dic objectForKey:@"regx"] isEqualToString:@""] && ![self validateString:str withRegex:[dic objectForKey:@"regx"]]){
            *err = [NSError errorWithDomain:[dic objectForKey:@"msg"] code:i userInfo:0];
            return NO;
        }
    }

    return YES;
}

#pragma mark - Internal Methods
- (BOOL)validateString:(NSString*)stringToSearch withRegex:(NSString*)regexString {
    
    stringToSearch = [stringToSearch stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    return [regex evaluateWithObject:stringToSearch];
}

@end
