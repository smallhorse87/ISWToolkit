//
//  NSString+YCAdd.m
//  youngcity
//
//  Created by chen xiaosong on 16/5/3.
//  Copyright © 2016年 Zhitian Network Tech. All rights reserved.
//

#import "NSString+ISWAdd.h"

#import <CoreText/CoreText.h>
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>
#import "NSDateFormatter+ISWAdd.h"

#import "NSDate+ISWAdd.h"

#import "UIFont+ISWAdd.h"
#import "NSMutableString+ISWAdd.h"

NSString* kWPAttributedMarkupLinkName = @"WPAttributedMarkupLinkName";

#define APP_MD5_LEN 16

#define OneMintue 60
#define OneHour   (60*60)
#define OneDay    (60*60*24)

@implementation NSString (ISWAdd)

- (BOOL)isw_isUrl
{
    NSURL *url = [NSURL URLWithString:self];
    
    if(url==nil)
        return NO;
    
    if([url.scheme isEqualToString:@"http"] || [url.scheme isEqualToString:@"https"])
        return YES;

    return NO;
}

-(NSString*)isw_encodeMD5
{
    //convert to md5 stream
    unsigned char md5Rlt[APP_MD5_LEN];
    unsigned char* charsBeforeSigned = (unsigned char*)[self UTF8String];
    NSInteger len = [self length];
    CC_MD5(charsBeforeSigned,(unsigned int)len,md5Rlt);
    
    NSString* md5PasswordStr = @"";
    for (int i=0; i<APP_MD5_LEN; i++) {
        md5PasswordStr=[md5PasswordStr stringByAppendingFormat:@"%02X",md5Rlt[i]];
    }
    
    return md5PasswordStr;
}

+ (NSString*)isw_formatWithMemorySize:(int)bytes
{
    return [NSString stringWithFormat:@"%dM", (int)bytes/(1024*1024)];
}

+ (NSString *)isw_formatWithPriceInChinese:(float)price
{
    return [NSString stringWithFormat:@"%0.2f元", price];
}

+ (NSString *)isw_shortPriceWithUnit:(float)price
{
    NSString *priceStr = [self isw_shortPrice:price];

    //加上单位
    return [NSString stringWithFormat:@"￥%@", priceStr];
}

+ (NSString *)isw_shortPrice:(float)price
{
    NSString *priceStr = [NSString stringWithFormat:@"%0.2f", price];

    //trim结尾的.00
    priceStr = [priceStr stringByReplacingOccurrencesOfString:@".00" withString:@""];
    
    //截取小数点的最后一个0
    if ([priceStr containsString:@"."] && [[priceStr isw_lastCharacter] isEqualToString:@"0"]) {
        priceStr = [priceStr substringToIndex:priceStr.length-1];
    }

    //整体加空格
    return [NSString stringWithFormat:@"%@", priceStr];
}

+ (NSString *)isw_formatWithPrice:(float)price
{
    NSString *priceStr = [NSString stringWithFormat:@"%0.2f", price];
    
    //trim结尾的.00
    priceStr = [priceStr stringByReplacingOccurrencesOfString:@".00" withString:@""];
    
    //整体加空格
    return [NSString stringWithFormat:@"%@", priceStr];
}

//按比例调节行高，可以往小里调节；设置行间距的方法只能往大里调节
-(NSAttributedString *)isw_adjustLineH:(float)ratio
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineHeightMultiple:ratio];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    
    return attributedString;
}

-(NSAttributedString *)isw_setLabelSpace:(CGFloat)linespace withFont:(UIFont*)font
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = linespace;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;

    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};

    return [[NSAttributedString alloc] initWithString:self attributes:dic];
}

-(NSAttributedString *)isw_plainTextWithLineSpace:(float)space
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [paragraphStyle setLineHeightMultiple:34.0/40.0];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    
    return attributedString;
}

-(NSAttributedString *)isw_plainTextWithHMargin
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setHeadIndent:50.0];
    [paragraphStyle setTailIndent:50.0];

    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    
    return attributedString;
}



#define kOneDay (60*60*24)

+ (NSString *)isw_showCouponComingTime:(int)timestamp serverTime:(NSInteger)serverTime
{
    int systemTime = (int) serverTime;
    
    NSDate *dateCur = [NSDate dateWithTimeIntervalSince1970:systemTime];
    
    NSDate *dateEnd = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFomater=[[NSDateFormatter alloc] init];
    [dateFomater setDateFormat:@"yyyy-MM-dd"];
    
    [dateFomater isw_setChinaSample];
    
    NSString *dateEndStr=[dateFomater stringFromDate:dateEnd];
    NSString *dateCurStr=[dateFomater stringFromDate:dateCur];
    if([dateEndStr isEqualToString:dateCurStr])
    {
        [dateFomater setDateFormat:@"今日HH:mm"];
        return [dateFomater stringFromDate:dateEnd];
    }
    
    if ([dateCur isYesToday:dateEnd]) {
        [dateFomater setDateFormat:@"明日HH:mm"];
        return [dateFomater stringFromDate:dateEnd];
    }
    
    [dateFomater setDateFormat:@"yyyy"];
    NSString *yearPostStr=[dateFomater stringFromDate:dateEnd];
    NSString *yearCurStr=[dateFomater stringFromDate:dateCur];
    if([yearPostStr isEqualToString:yearCurStr])
    {
        [dateFomater setDateFormat:@"M月d日"];
        return [dateFomater stringFromDate:dateEnd];
    }

    [dateFomater setDateFormat:@"yyyy-MM-dd"];
    return [dateFomater stringFromDate:dateEnd];
}

+ (NSString*)isw_showCouponEndTime:(int)timestamp
{
    NSDate *dateCur = [NSDate date];
    NSDate *dateEnd=[NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFomater=[[NSDateFormatter alloc] init];
    
    [dateFomater setDateFormat:@"yyyy-MM-dd"];
    [dateFomater isw_setChinaSample];
    
    NSString *dateEndStr=[dateFomater stringFromDate:dateEnd];
    NSString *dateCurStr=[dateFomater stringFromDate:dateCur];
    if([dateEndStr isEqualToString:dateCurStr])
    {
        [dateFomater setDateFormat:@"HH:mm"];
        return [dateFomater stringFromDate:dateEnd];
    }
    
    [dateFomater isw_setChinaSample];
    
    //NSGregorianCalendar
    
    [dateFomater setDateFormat:@"yyyy"];
    NSString *yearPostStr=[dateFomater stringFromDate:dateEnd];
    NSString *yearCurStr=[dateFomater stringFromDate:dateCur];
    if([yearPostStr isEqualToString:yearCurStr])
    {
        [dateFomater setDateFormat:@"M月d日"];
        return [dateFomater stringFromDate:dateEnd];
    }
    
    [dateFomater setDateFormat:@"yyyy-MM-dd"];
    return [dateFomater stringFromDate:dateEnd];
}

//通知页的时间显示
+ (NSString *)isw_showNotiTime:(int)timestamp
{
    
    NSDate *dateCur = [NSDate date];
    
    int timeCur = dateCur.timeIntervalSince1970;
    int timeInterval = timeCur-timestamp;
    
    NSDate *datePost=[NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFomater=[[NSDateFormatter alloc] init];
    [dateFomater setDateFormat:@"yyyy-MM-dd"];
    [dateFomater isw_setChinaSample];
    
    NSString *datePostStr=[dateFomater stringFromDate:datePost];
    NSString *dateCurStr=[dateFomater stringFromDate:dateCur];
    
    
    if([datePostStr isEqualToString:dateCurStr])
    {
        [dateFomater setDateFormat:@"HH:mm"];
        return [dateFomater stringFromDate:datePost];
    } else if (timeInterval<OneDay) {
        return @"昨天";
    }
    
    [dateFomater setDateFormat:@"yyyy"];
    NSString *yearPostStr=[dateFomater stringFromDate:datePost];
    NSString *yearCurStr=[dateFomater stringFromDate:dateCur];
    if([yearPostStr isEqualToString:yearCurStr])
    {
        [dateFomater setDateFormat:@"MM月dd日 HH:mm"];
        return [dateFomater stringFromDate:datePost];
    }
    
    [dateFomater setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFomater stringFromDate:datePost];
}


+ (NSString*)isw_showTime:(int)timestamp
{
    NSDate *dateCur = [NSDate date];
    int timeCur = dateCur.timeIntervalSince1970;
    int timeInterval = timeCur-timestamp;
    
    if(timeInterval<OneMintue)
    {
        return @"刚刚";
    }
    else if(timeInterval<OneHour)
    {
        return [NSString stringWithFormat:@"%d分钟前",timeInterval/OneMintue];
    }
    else
    {
        NSDate *datePost=[NSDate dateWithTimeIntervalSince1970:timestamp];
        
        NSDateFormatter *dateFomater=[[NSDateFormatter alloc] init];
        [dateFomater setDateFormat:@"yyyy-MM-dd"];
        [dateFomater isw_setChinaSample];
        
        NSString *datePostStr=[dateFomater stringFromDate:datePost];
        NSString *dateCurStr=[dateFomater stringFromDate:dateCur];
        if([datePostStr isEqualToString:dateCurStr])
        {
            [dateFomater setDateFormat:@"HH:mm"];
            return [dateFomater stringFromDate:datePost];
        }
        
        [dateFomater setDateFormat:@"yyyy"];
        NSString *yearPostStr=[dateFomater stringFromDate:datePost];
        NSString *yearCurStr=[dateFomater stringFromDate:dateCur];
        if([yearPostStr isEqualToString:yearCurStr])
        {
            [dateFomater setDateFormat:@"MM月dd日 HH:mm"];
            return [dateFomater stringFromDate:datePost];
        }
        
        [dateFomater setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateFomater stringFromDate:datePost];
    }
}

//根据string返回date
+ (NSDate *)isw_dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter isw_setChinaSample];
    
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

//根据date返回string
+ (NSString*)isw_stringFromTimestamp:(int)timestamp withFormat:(NSString *)format
{
    NSDate *datePost=[NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter isw_setChinaSample];
    
    [inputFormatter setDateFormat:format];
    NSString *dateStr = [inputFormatter stringFromDate:datePost];
    return dateStr;
}

+ (NSString*)isw_showTimeRange:(int)beginStamp endTime:(int)endStamp
{
    NSDate *dateBegin=[NSDate dateWithTimeIntervalSince1970:beginStamp];
    NSDate *dateEnd=[NSDate dateWithTimeIntervalSince1970:endStamp];
    
    NSDateFormatter *dateFomater=[[NSDateFormatter alloc] init];
    [dateFomater setDateFormat:@"yyyy年M月d日"];
    [dateFomater isw_setChinaSample];
    
    NSString *dateBeginStr=[dateFomater stringFromDate:dateBegin];
    NSString *dateEndStr=[dateFomater stringFromDate:dateEnd];
    
    if([dateEndStr isEqualToString:dateBeginStr])
    {
        [dateFomater setDateFormat:@"HH:mm"];
        
        NSString *dateEndHM     =[dateFomater stringFromDate:dateEnd];
        NSString *dateBeginHM   =[dateFomater stringFromDate:dateBegin];
        
        return [NSString stringWithFormat:@"%@ %@ - %@", dateEndStr, dateBeginHM, dateEndHM];
        
    }else{
        
        return [NSString stringWithFormat:@"%@ - %@", dateBeginStr, dateEndStr];
    }
    
}

+ (NSString*)isw_timeInYYYYMMDD:(int)timestamp
{
    NSDate *datePost=[NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *dateFomater=[[NSDateFormatter alloc] init];
    [dateFomater setDateFormat:@"yyyy-MM-dd"];
    [dateFomater isw_setChinaSample];
    
    return [dateFomater stringFromDate:datePost];
}

+ (NSString*)isw_timeInChinaStyle:(int)timestamp
{
    NSDate *datePost=[NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *dateFomater=[[NSDateFormatter alloc] init];
    [dateFomater setDateFormat:@"yyyy年MM月dd日"];
    [dateFomater isw_setChinaSample];
    
    return [dateFomater stringFromDate:datePost];
}

//处理支付时返回的时间段
+ (NSString *)isw_fixCarryTime:(NSString *)string
{
    NSString *str = [string substringFromIndex:6];
    
    str = [str stringByReplacingOccurrencesOfString:@"：" withString:@":"];
    
    return str;
}

- (BOOL)isw_isNotBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

- (CGFloat)isw_contentHeightWithFont:(UIFont *)font withinWidth:(CGFloat)width andHeight:(CGFloat)height
{
    
    CGFloat estimatedH = [self isw_contentHeightWithFont:font withinWidth:width];
    
    if (estimatedH > height) {
        return height;
    }

    return estimatedH;
}

- (CGFloat)isw_contentHeightWithFont:(UIFont *)font withinWidth:(CGFloat)width
{
    if (self == nil || self.length == 0)
        return 0.0;

    CGRect textRect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];

    return ceil(textRect.size.height);
}

- (NSString*) isw_trimWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString*) isw_lastCharacter
{
    NSString *lastCharacter = [self substringFromIndex:self.length - 1];

    return lastCharacter;
}

//二维码 四个字符一个空格
+ (NSString *)isw_QRcodeFormat:(NSString *)number
{
    NSString *doneTitle = @"";
    int count = 0;
    for (int i = 0; i < number.length; i++) {
        
        count++;
        doneTitle = [doneTitle stringByAppendingString:[number substringWithRange:NSMakeRange(i, 1)]];
        if (count == 4) {
            doneTitle = [NSString stringWithFormat:@"%@ ", doneTitle];
            count = 0;
        }
    }
    return doneTitle;
}

// 获取当前设备系统时间戳
+ (NSString *)isw_getSystemTimestamp
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]*1000];
    
    return timeSp;
    
   
}

//sha1 加密
+ (NSString *) isw_sha1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

+ (NSString *)isw_arrayToJson: (NSMutableArray *)arr
{
    
    NSString *totalString = arr.firstObject;
    
    
    for (int i = 1; i < arr.count; i ++) {
        
        NSLog(@"%@",arr[i]);
        
        totalString =  [totalString stringByAppendingFormat:@",%@", arr[i]];
        
    }
    return totalString;
}

- (NSString *)isw_URLEncodedString
{
    NSString *unencodedString = self;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

- (NSString *)isw_URLDecodedString
{
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

///分割线
-(NSAttributedString*)attributedStringWithStyleBook:(NSDictionary*)fontbook
{
    // Find string ranges
    NSMutableArray* tags = [[NSMutableArray alloc] initWithCapacity:16];
    NSMutableString* ms = [self mutableCopy];
    
    [ms replaceOccurrencesOfString:@"<br>" withString:@"\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, ms.length)];
    [ms replaceOccurrencesOfString:@"<br />" withString:@"\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, ms.length)];
    
    [ms isw_replaceAllTagsIntoArray:tags];
    
    NSMutableAttributedString* as = [[NSMutableAttributedString alloc] initWithString:ms];
    
    // Setup base attributes
    [as setAttributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:NSMakeRange(0,[as length])];
    
    NSObject* bodyStyle = fontbook[@"body"];
    if (bodyStyle) {
        [self styleAttributedString:as range:NSMakeRange(0, as.length) withStyle:bodyStyle withStyleBook:fontbook];
    }
    
    for (NSDictionary* tag in tags) {
        NSString* t = tag[@"tag"];
        NSNumber* loc = tag[@"loc"];
        NSNumber* endloc = tag[@"endloc"];
        if (loc != nil && endloc != nil) {
            NSRange range = NSMakeRange([loc integerValue], [endloc integerValue] - [loc integerValue]);
            NSObject* style = fontbook[t];
            if (style) {
                [self styleAttributedString:as range:range withStyle:style withStyleBook:fontbook];
            }
        }
    }
    
    return as;
}

-(void)styleAttributedString:(NSMutableAttributedString*)as range:(NSRange)range withStyle:(NSObject*)style withStyleBook:(NSDictionary*)styleBook
{
    if ([style isKindOfClass:[NSArray class]]) {
        for (NSObject* subStyle in (NSArray*)style) {
            [self styleAttributedString:as range:range withStyle:subStyle withStyleBook:styleBook];
        }
    }
    else if ([style isKindOfClass:[NSDictionary class]]) {
        [self setStyle:(NSDictionary*)style range:range onAttributedString:as];
    }
    else if ([style isKindOfClass:[UIFont class]]) {
        [self setFont:(UIFont*)style range:range onAttributedString:as];
    }
    else if ([style isKindOfClass:[UIColor class]]) {
        [self setTextColor:(UIColor*)style range:range onAttributedString:as];
    } else if ([style isKindOfClass:[NSURL class]]) {
        [self setLink:(NSURL*)style range:range onAttributedString:as];
    } else if ([style isKindOfClass:[NSString class]]) {
        [self styleAttributedString:as range:range withStyle:styleBook[(NSString*)style] withStyleBook:styleBook];
    } else if ([style isKindOfClass:[UIImage class]]) {
        NSTextAttachment* attachment = [[NSTextAttachment alloc] init];
        attachment.image = (UIImage*)style;
        [as replaceCharactersInRange:range withAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
        //        [as insertAttributedString:imageAttrString atIndex:range.location];
    }
}


-(void)setStyle:(NSDictionary*)style range:(NSRange)range onAttributedString:(NSMutableAttributedString*)as
{
    for (NSString* key in [style allKeys]) {
        [self setTextStyle:key withValue:style[key] range:range onAttributedString:as];
    }
}

-(void)setFont:(UIFont*)font range:(NSRange)range onAttributedString:(NSMutableAttributedString*)as
{
    [self setFontName:font.fontName size:font.pointSize range:range onAttributedString:as];
}


-(void)setFontName:(NSString*)fontName size:(CGFloat)size range:(NSRange)range onAttributedString:(NSMutableAttributedString*)as
{
    // kCTFontAttributeName
    CTFontRef aFont = CTFontCreateWithName((__bridge CFStringRef)fontName, size, NULL);
    if (aFont)
    {
        [as removeAttribute:(__bridge NSString*)kCTFontAttributeName range:range]; // Work around for Apple leak
        [as addAttribute:(__bridge NSString*)kCTFontAttributeName value:(__bridge id)aFont range:range];
        CFRelease(aFont);
    }
}

-(void)setTextColor:(UIColor*)color range:(NSRange)range onAttributedString:(NSMutableAttributedString*)as
{
    // kCTForegroundColorAttributeName
    [as removeAttribute:NSForegroundColorAttributeName range:range];
    [as addAttribute:NSForegroundColorAttributeName value:color range:range];
}

-(void)setTextStyle:(NSString*)styleName withValue:(NSObject*)value range:(NSRange)range onAttributedString:(NSMutableAttributedString*)as
{
    [as removeAttribute:styleName range:range]; // Work around for Apple leak
    [as addAttribute:styleName value:value range:range];
}

-(void)setLink:(NSURL*)url range:(NSRange)range onAttributedString:(NSMutableAttributedString*)as
{
    [as removeAttribute:kWPAttributedMarkupLinkName range:range]; // Work around for Apple leak
    if (link)
    {
        [as addAttribute:kWPAttributedMarkupLinkName value:[url absoluteString] range:range];
    }
}
@end
