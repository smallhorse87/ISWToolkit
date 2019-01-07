//
//  UUDatePicker.m
//  1111
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUDatePicker.h"
#import "UUDatePicker_DateModel.h"

#import "ISWToolkit.h"

#define UUPICKER_MAXYEAR 2050
#define UUPICKER_MINYEAR 1900

#define UUPICKER_MONTH 12

#define UU_GRAY [UIColor redColor];
#define UU_BLACK [UIColor blackColor];

@interface UUDatePicker ()
{
    UIView       *backGroundView;
    UIPickerView *myPickerView;
    UIToolbar    *myToolbar;
    
    //日期存储数组
    NSMutableArray *genderArray;
    NSMutableArray *yearArray;
    NSMutableArray *monthArray;
    NSMutableArray *dayArray;
    
    //限制model
    UUDatePicker_DateModel *maxDateModel;
    UUDatePicker_DateModel *minDateModel;
    
    //记录位置
    NSInteger genderIndex;
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;

    NSString *scrollToGender;
    
    BOOL show;
}

@end

@implementation UUDatePicker

-(id)initWithframe:(CGRect)frame curGender:(NSString *)gender Delegate:(id<UUDatePickerDelegate>)delegate
{
    self.datePickerStyle = UUDateStyle_Gender;
    scrollToGender = gender;
    self.delegate = delegate;
    return [self initWithFrame:frame];
}

-(id)initWithframe:(CGRect)frame DatePickerStyle:(DateStyle)uuDateStyle Delegate:(id<UUDatePickerDelegate>)delegate
{
    self.datePickerStyle = uuDateStyle;
    self.delegate = delegate;
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
    }
    return self;
}

#pragma mark - 初始化赋值操作
- (NSMutableArray *)ishave:(id)mutableArray
{
    if (mutableArray)
        [mutableArray removeAllObjects];
    else
        mutableArray = [NSMutableArray array];
    return mutableArray;
}

//进行初始化
- (void)initForDatePicker
{
    yearArray   = [self ishave:yearArray];
    monthArray  = [self ishave:monthArray];
    dayArray    = [self ishave:dayArray];

    //赋值
    for (int i=1; i<=UUPICKER_MONTH; i++) {
        NSString *num = [NSString stringWithFormat:@"%02d",i];
        [monthArray addObject:num];
    }

    for (int i=UUPICKER_MINYEAR; i<UUPICKER_MAXYEAR; i++) {
        NSString *num = [NSString stringWithFormat:@"%d",i];
        [yearArray addObject:num];
    }

    //最大限制
    self.maxLimitDate = [NSDate date];
    maxDateModel = [[UUDatePicker_DateModel alloc]initWithDate:self.maxLimitDate];

    //最小限制
    if (self.minLimitDate) {
        minDateModel = [[UUDatePicker_DateModel alloc]initWithDate:self.minLimitDate];
    }else{
        self.minLimitDate = [NSString isw_dateFromString:@"190001010000" withFormat:@"yyyyMMddHHmm"];
        minDateModel = [[UUDatePicker_DateModel alloc]initWithDate:self.minLimitDate];
    }

}

- (void)initForGenderPicker
{
    genderArray = [self ishave:genderArray];

    [genderArray addObject:@"男"];
    [genderArray addObject:@"女"];

}

- (void)showPicker:(UIView*)superView
{
    [superView addSubview:self];
}

- (void)hidePicker
{
    [UIView animateWithDuration:0.2 animations:^{
        backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    } completion:^(BOOL finished) {
        [backGroundView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)backgroundTapped:(UITapGestureRecognizer *)paramSender
{
    [self hidePicker];
}

- (void)drawRect:(CGRect)rect
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;

    //创建frame
    if (self.frame.size.height<216 || screenSize.width<320)
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 320, 216);

    self.frame = CGRectMake(self.frame.origin.x, screenSize.height - self.frame.size.height, screenSize.width, 216);


    //创建背景
    //background init and tapped
    backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    backGroundView.opaque = NO;
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    [backGroundView addGestureRecognizer:gesture];

    [self.superview addSubview:backGroundView];

    [UIView animateWithDuration:0.2 animations:^{
        backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    }];

    //创建toolbar
    myToolbar = [[UIToolbar alloc] init];
    myToolbar.frame = CGRectMake(0, 0, self.window.frame.size.width, 44);
    // set style
    [myToolbar setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem *previousBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonIsClicked)];

    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonIsClicked)];

    NSArray *barButtonItems = @[previousBarButton, flexBarButton, doneBarButton];
    
    myToolbar.items = barButtonItems;
    
    [self addSubview:myToolbar];

    //创建数据
    if (self.datePickerStyle == UUDateStyle_Gender)
    {
        [self initForGenderPicker];
    }
    else
    {
        [self initForDatePicker];
    }

    //创建picker
    if (!myPickerView) {
        myPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height-44)];
        myPickerView.showsSelectionIndicator = YES;
        myPickerView.backgroundColor = [UIColor clearColor];
        myPickerView.delegate = self;
        myPickerView.dataSource = self;
        [self addSubview:myPickerView];
    }
    
    [self.superview addSubview:self];

    
    //设置初始位置
    if (self.datePickerStyle == UUDateStyle_Gender)
    {
        for (NSString *item in genderArray) {
            if ([item isEqualToString:scrollToGender]) {
                genderIndex = [genderArray indexOfObject:item];
                [myPickerView selectRow:genderIndex inComponent:0 animated:NO];
                break;
            }
        }
    }
    else
    {
        //获取当前日期，储存当前时间位置
        NSArray *indexArray = [self getNowDate:self.ScrollToDate];

        //调整为现在的时间
        for (int i=0; i<indexArray.count; i++) {
            [myPickerView selectRow:[indexArray[i] integerValue] inComponent:i animated:NO];
        }
    }
    
    [myPickerView reloadAllComponents];
}

//加上背景，加上出现和消失

#pragma mark - 确认键
- (void) cancelButtonIsClicked
{
    [self hidePicker];
}

- (void) doneButtonIsClicked
{
    [self playTheDelegate];
    [self hidePicker];
}

#pragma mark - 调整颜色

//获取当前时间解析及位置
- (NSArray *)getNowDate:(NSDate *)date
{
    NSDate *dateShow;
    if (date) {
        dateShow = date;
    }else{
        dateShow = [NSDate date];
    }
    
    UUDatePicker_DateModel *model = [[UUDatePicker_DateModel alloc]initWithDate:dateShow];
    
    [self DaysfromYear:[model.year integerValue] andMonth:[model.month integerValue]];
    
    yearIndex = [model.year intValue]-UUPICKER_MINYEAR;
    monthIndex = [model.month intValue]-1;
    dayIndex = [model.day intValue]-1;
    
    NSNumber *year   = [NSNumber numberWithInteger:yearIndex];
    NSNumber *month  = [NSNumber numberWithInteger:monthIndex];
    NSNumber *day    = [NSNumber numberWithInteger:dayIndex];

    if (self.datePickerStyle == UUDateStyle_YearMonthDay)
        return @[year,month,day];

    return nil;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.datePickerStyle == UUDateStyle_Gender){
        return 1;
    }

    if (self.datePickerStyle == UUDateStyle_YearMonthDay){
        return 3;
    }
    
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.datePickerStyle == UUDateStyle_Gender){
        if (component == 0) return genderArray.count;
    }
    if (self.datePickerStyle == UUDateStyle_YearMonthDay)
    {

        NSInteger cnt = 0;
        if (component == 0) cnt = UUPICKER_MAXYEAR-UUPICKER_MINYEAR;
        if (component == 1) cnt = UUPICKER_MONTH;
        if (component == 2){
            cnt =  [self DaysfromYear:[yearArray[yearIndex] integerValue] andMonth:[monthArray[monthIndex] integerValue]];
        }

        return cnt;
    }

    return 0;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (self.datePickerStyle) {
        case UUDateStyle_Gender:{
            if (component==0) return 200;
        }
            break;

        case UUDateStyle_YearMonthDay:{
            if (component==0) return 70;
            if (component==1) return 100;
            if (component==2) return 50;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (self.datePickerStyle) {
        case UUDateStyle_Gender:
            genderIndex = row;
            break;
            
        case UUDateStyle_YearMonthDay:{
            
            if (component == 0) {
                yearIndex = row;
            }
            if (component == 1) {
                monthIndex = row;
            }
            if (component == 2) {
                dayIndex = row;
            }
            if (component == 0 || component == 1){
                [self DaysfromYear:[yearArray[yearIndex] integerValue] andMonth:[monthArray[monthIndex] integerValue]];
                if (dayArray.count-1<dayIndex) {
                    dayIndex = dayArray.count-1;
                }
            }
        }
            break;
            
        default:
            break;
    }
    
    [self adjustToValidValue];

    [myPickerView reloadAllComponents];

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        [customLabel setFont:[UIFont systemFontOfSize:18]];
    }
    UIColor *textColor = [UIColor blackColor];
    NSString *title;

    switch (self.datePickerStyle) {
        case UUDateStyle_Gender:{
            if (component==0) {
                title = genderArray[row];
                textColor = [self returnYearColorRow:row];
            }
        }
            break;
            
        case UUDateStyle_YearMonthDay:{
            if (component==0) {
                title = yearArray[row];
                textColor = [self returnYearColorRow:row];
            }
            if (component==1) {
                title = monthArray[row];
                textColor = [self returnMonthColorRow:row];
            }
            if (component==2) {
                title = dayArray[row];
                textColor = [self returnDayColorRow:row];
            }
        }
            break;

        default:
            break;
    }
    customLabel.text = title;
    customLabel.textColor = textColor;
    return customLabel;
}

#pragma mark - 动态调整回归合理值
- (void)adjustToValidValue
{
    if (self.datePickerStyle == UUDateStyle_Gender)
        return;

    NSDate *date = [NSString isw_dateFromString:[NSString stringWithFormat:@"%@%@%@",yearArray[yearIndex],monthArray[monthIndex],dayArray[dayIndex]] withFormat:@"yyyyMMdd"];
    if ([date compare:self.minLimitDate] == NSOrderedAscending) {
        NSArray *array = [self getNowDate:self.minLimitDate];
        for (int i=0; i<array.count; i++) {
            [myPickerView selectRow:[array[i] integerValue] inComponent:i animated:YES];
        }
    }else if ([date compare:self.maxLimitDate] == NSOrderedDescending){
        NSArray *array = [self getNowDate:self.maxLimitDate];
        for (int i=0; i<array.count; i++) {
            [myPickerView selectRow:[array[i] integerValue] inComponent:i animated:YES];
        }
    }
}


#pragma mark - 代理回调方法
- (void)playTheDelegate
{

    //代理回调
    if (self.datePickerStyle == UUDateStyle_Gender)
    {
        [self.delegate uuDatePicker:self
                               gender:genderArray[genderIndex]];
    }
    else
    {
        [self.delegate uuDatePicker:self
                               year:yearArray[yearIndex]
                              month:monthArray[monthIndex]
                                day:dayArray[dayIndex]
                               hour:nil
                             minute:nil
                            weekDay:nil];
    }
}

#pragma mark - 数据处理


//通过年月求每月天数
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_year  = year;
    NSInteger num_month = month;

    BOOL isrunNian = num_year%4==0 ? (num_year%100==0? (num_year%400==0?YES:NO):YES):NO;
    switch (num_month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:{
            [self setdayArray:31];
            return 31;
        }
            break;
        case 4:
        case 6:
        case 9:
        case 11:{
            [self setdayArray:30];
            return 30;
        }
            break;
        case 2:{
            if (isrunNian) {
                [self setdayArray:29];
                return 29;
            }else{
                [self setdayArray:28];
                return 28;
            }
        }
            break;
        default:
            break;
    }
    return 0;
}

//设置每月的天数数组
- (void)setdayArray:(NSInteger)num
{
    [dayArray removeAllObjects];
    for (int i=1; i<=num; i++) {
        [dayArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
}

- (UIColor *)returnGenderColorRow:(NSInteger)row
{
    return UU_BLACK;
}

- (UIColor *)returnYearColorRow:(NSInteger)row
{
    if ([yearArray[row] intValue] < [minDateModel.year intValue] || [yearArray[row] intValue] > [maxDateModel.year intValue]) {
        return  UU_GRAY;
    }else{
        return UU_BLACK;
    }
}
- (UIColor *)returnMonthColorRow:(NSInteger)row
{
    
    if ([yearArray[yearIndex] intValue] < [minDateModel.year intValue] || [yearArray[yearIndex] intValue] > [maxDateModel.year intValue]) {
        return UU_GRAY;
    }else if([yearArray[yearIndex] intValue] > [minDateModel.year intValue] && [yearArray[yearIndex] intValue] < [maxDateModel.year intValue]){
        return UU_BLACK;
    }else if ([minDateModel.year intValue]==[maxDateModel.year intValue]){
        if ([monthArray[row] intValue] >= [minDateModel.month intValue] && [monthArray[row] intValue] <= [maxDateModel.month intValue]) {
            return UU_BLACK;
        }else {
            return UU_GRAY;
        }
    }else if ([yearArray[yearIndex] intValue] == [minDateModel.year intValue]){
        if ([monthArray[row] intValue] >= [minDateModel.month intValue]) {
            return UU_BLACK;
        }else{
            return UU_GRAY;
        }
    }else {
        if ([monthArray[row] intValue] > [maxDateModel.month intValue]) {
            return UU_GRAY;
        }else{
            return UU_BLACK;
        }
    }
}
- (UIColor *)returnDayColorRow:(NSInteger)row
{
    if ([yearArray[yearIndex] intValue] < [minDateModel.year intValue] || [yearArray[yearIndex] intValue] > [maxDateModel.year intValue]) {
        return UU_GRAY;
    }else if([yearArray[yearIndex] intValue] > [minDateModel.year intValue] && [yearArray[yearIndex] intValue] < [maxDateModel.year intValue]){
        return UU_BLACK;
    }else if ([minDateModel.year intValue]==[maxDateModel.year intValue]){
        if ([monthArray[monthIndex] intValue] > [minDateModel.month intValue] && [monthArray[monthIndex] intValue] < [maxDateModel.month intValue]) {
            return UU_BLACK;
        }else if ([minDateModel.month intValue]==[maxDateModel.month intValue]){
            if ([dayArray[row] intValue] >= [minDateModel.day intValue] && [dayArray[row] intValue] <= [maxDateModel.day intValue]) {
                return UU_BLACK;
            }else{
                return UU_GRAY;
            }
        }else {
            return UU_GRAY;
        }
    }else if ([yearArray[yearIndex] intValue] == [minDateModel.year intValue]){
        if ([monthArray[monthIndex] intValue] < [minDateModel.month intValue]) {
            return UU_GRAY;
        }else if([monthArray[monthIndex] intValue] == [minDateModel.month intValue]){
            if ([dayArray[row] intValue] >= [minDateModel.day intValue]) {
                return UU_BLACK;
            }else {
                return UU_GRAY;
            }
        }else{
            return UU_BLACK;
        }
    }else {
        if ([monthArray[monthIndex] intValue] > [maxDateModel.month intValue]) {
            return UU_GRAY;
        }else if([monthArray[monthIndex] intValue] == [maxDateModel.month intValue]){
            if ([dayArray[row] intValue] <= [maxDateModel.day intValue]) {
                return UU_BLACK;
            }else{
                return UU_GRAY;
            }
        }else{
            return UU_BLACK;
        }
    }
}

@end
