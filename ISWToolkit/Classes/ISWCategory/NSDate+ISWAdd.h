//
//  NSDate+Extend.h
//  CoreCategory
//
//  Created by 成林 on 15/4/6.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ISWAdd)

/*
 *  时间戳
 */
@property (nonatomic,copy,readonly) NSString *timestamp;



/*
 *  时间成分
 */
@property (nonatomic,strong,readonly) NSDateComponents *components;




/*
 *  是否是今年
 */
@property (nonatomic,assign,readonly) BOOL isThisYear;




/*
 *  是否是今天
 */
-(BOOL)isToday:(NSDate*) date;


/*
 *  是否是昨天
 */
-(BOOL)isYesToday:(NSDate*) date;



/**
 *  两个时间比较
 *
 *  @param unit     成分单元
 *  @param fromDate 起点时间
 *  @param toDate   终点时间
 *
 *  @return 时间成分对象
 */
+(NSDateComponents *)dateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;




// 是否是今天
- (BOOL)isThisToday;

// 是否是昨天
- (BOOL)isThisYesterday;

// 获取与当前时间差值
- (NSDateComponents *)deltaWithNow;


@end
