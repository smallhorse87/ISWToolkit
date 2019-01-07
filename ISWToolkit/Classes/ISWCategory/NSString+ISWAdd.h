//
//  NSString+YCAdd.h
//  youngcity
//
//  Created by chen stony on 16/5/3.
//  Copyright © 2016年 Zhitian Network Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

#define isEmptyString(string) (string == nil || string.length == 0)

@interface NSString (ISWAdd)

-(NSAttributedString *)isw_plainTextWithLineSpace:(float)space;

+ (NSDate *)isw_dateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSString*)isw_stringFromTimestamp:(int)timestamp withFormat:(NSString *)format;
+ (NSString *)isw_showCouponComingTime:(int)timestamp serverTime:(NSInteger)serverTime;

+ (NSString *)isw_showNotiTime:(int)timestamp;

+ (NSString*)isw_showTime:(int)timestamp;
+ (NSString*)isw_showCouponEndTime:(int)timestamp;
+ (NSString*)isw_showTimeRange:(int)beginStamp endTime:(int)endStamp;

+ (NSString*)isw_timeInYYYYMMDD:(int)timestamp;
+ (NSString*)isw_timeInChinaStyle:(int)timestamp;

+ (NSString *)isw_shortPriceWithUnit:(float)price;
+ (NSString *)isw_formatWithPriceInChinese:(float)price;
//YY
+ (NSString*)isw_formatWithMemorySize:(int)bytes;
+ (NSString*)isw_formatWithPrice:(float)price;
+ (NSString*)isw_shortPrice:(float)price;

-(NSString*)isw_encodeMD5;

+ (NSString *)isw_fixCarryTime:(NSString *)string;

-(NSAttributedString *)isw_plainTextWithHMargin;
-(NSAttributedString *)isw_adjustLineH:(float)ratio;

- (BOOL)isw_isNotBlank;

- (CGFloat)isw_contentHeightWithFont:(UIFont *)font withinWidth:(CGFloat)width;
- (CGFloat)isw_contentHeightWithFont:(UIFont *)font withinWidth:(CGFloat)width andHeight:(CGFloat)height;

- (NSAttributedString *)isw_setLabelSpace:(CGFloat)linespace withFont:(UIFont*)font;

- (NSString*)isw_trimWhitespace;

+ (NSString *)isw_QRcodeFormat:(NSString *)string;

// 获取当前设备系统时间戳
+ (NSString *)isw_getSystemTimestamp;

//sha1 加密
+ (NSString *) isw_sha1:(NSString *)input;

- (BOOL)isw_isUrl;

+ (NSString *)isw_arrayToJson: (NSMutableArray *)arr;

- (NSString *)isw_URLDecodedString;
- (NSString *)isw_URLEncodedString;

-(NSAttributedString*)attributedStringWithStyleBook:(NSDictionary*)fontbook;

@end
