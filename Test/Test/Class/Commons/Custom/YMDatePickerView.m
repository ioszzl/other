//
//  YMDatePickerView.m
//  Test
//
//  Created by eims on 17/6/20.
//  Copyright © 2017年 eims. All rights reserved.
//

#import "YMDatePickerView.h"
#import "NSDate+Utilities.h"

#define kPickerSize self.buttomView.frame.size
#define MAXYEAR 2070
#define MINYEAR 1970

@interface YMDatePickerView()<UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate>
{
    //日期存储数组
    NSMutableArray *_yearArray;
    NSMutableArray *_monthArray;
    NSMutableArray *_dayArray;
    NSString *_dateFormatter;
    //记录位置
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    
    NSDate *_startDate;
}

@property (nonatomic,strong) UIView *buttomView;
@property (nonatomic,strong)UIPickerView *datePicker;
@property (nonatomic,retain) NSDate *scrollToDate;//滚到指定日期
@property (nonatomic, strong) UIButton * doneBtn;
@property (nonatomic, strong) UIButton * cancelBtn;


@end

@implementation YMDatePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _dateFormatter = @"yyyy-MM-dd";
        [self defaultConfig];
    }
    return self;
}


/**
 datepicker
 
 @param x 坐标x
 @param y 坐标y
 @param width 宽度
 @param height 高度
 @return <#return value description#>
 */
-(id)initWithUI:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    self = [super init];
    if (self) {
        self.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self setBackgroundColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.3]];
        
        self.buttomView = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        self.buttomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.buttomView];
        
        //点击背景是否影藏
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        self.doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.doneBtn setFrame:CGRectMake(width-90, 0, 80, 50)];
        [self.doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.buttomView addSubview:self.doneBtn];
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelBtn setFrame:CGRectMake(10, 0, 80, 50)];
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelBtn addTarget:self action:@selector(calcelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.buttomView addSubview:self.cancelBtn];
        
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
        [self.buttomView addSubview:self.datePicker];
    }
    return self;
}

-(void)defaultConfig {
    //设置年月日时分数据
    _yearArray = [self setArray:_yearArray];
    _monthArray = [self setArray:_monthArray];
    _dayArray = [self setArray:_dayArray];
    
    for (int i=0; i<60; i++) {
        NSString *num = [NSString stringWithFormat:@"%02d",i];
        if (0<i && i<=12)
            [_monthArray addObject:num];
    }
    for (NSInteger i=MINYEAR; i<MAXYEAR; i++) {
        NSString *num = [NSString stringWithFormat:@"%ld",(long)i];
        [_yearArray addObject:num];
    }
    
}
-(void)setBeginDay:(NSString *)beginDay {
    _beginDay = beginDay;
    if (!self.endDay) {
        self.endDay = @"2100-12-31";
    }
    [_yearArray removeAllObjects];
    NSArray *array = [_beginDay componentsSeparatedByString:@"-"];
    NSArray *endArray = [self.endDay componentsSeparatedByString:@"-"];
    
    for (NSInteger i = [array.firstObject integerValue]; i <= [endArray.firstObject integerValue]; i++) {
        NSString *num = [NSString stringWithFormat:@"%ld",(long)i];
        [_yearArray addObject:num];
        
    }
    
}

- (NSMutableArray *)setArray:(id)mutableArray
{
    if (mutableArray)
        [mutableArray removeAllObjects];
    else
        mutableArray = [NSMutableArray array];
    return mutableArray;
}

#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (self.datePickerStyle) {
        case DateStyleShowYearMonthDay:
            return 3;
        case DateStyleShowYearMonth:
            return 2;
        default:
            return 0;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *numberArr = [self getNumberOfRowsInComponent];
    return [[numberArr objectAtIndex:component]integerValue];
}

-(NSArray *)getNumberOfRowsInComponent {
    
    NSInteger yearNum = _yearArray.count;
    NSInteger monthNum = 0;
    if (_yearArray.count == 0) {
        return @[@0,@0,@0];
    }
    if (self.beginDay) {
        
        monthNum = [self MonthsfromYear:[_yearArray[yearIndex] integerValue]];
    }
    else {
        monthNum = _monthArray.count;
    }
    
    if (monthNum == 0) {
        return @[@0,@0,@0];
    }
    NSInteger dayNum = [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
    
    switch (self.datePickerStyle) {
        case DateStyleShowYearMonth:
            return @[@(yearNum),@(monthNum)];
            break;
        case DateStyleShowYearMonthDay:
            return @[@(yearNum),@(monthNum),@(dayNum)];
            break;
            
        default:
            return @[];
            break;
    }
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        [customLabel setFont:[UIFont systemFontOfSize:17]];
    }
    NSString *title;
    
    switch (self.datePickerStyle) {
        case DateStyleShowYearMonthDay:
            if (component==0) {
                title = _yearArray[row];
            }
            if (component==1) {
                title = _monthArray[row];
            }
            if (component==2) {
                title = _dayArray[row];
            }
            break;
        case DateStyleShowYearMonth:
            if (component==0) {
                title = _yearArray[row];
            }
            if (component==1) {
                title = _monthArray[row];
            }
            break;
        default:
            title = @"";
            break;
    }
    
    customLabel.text = title;
    customLabel.textColor = [UIColor blackColor];
    return customLabel;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (self.datePickerStyle) {
        case DateStyleShowYearMonthDay:{
            
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
                
                [self MonthsfromYear:[_yearArray[yearIndex] integerValue]];
                if (_monthArray.count-1 < monthIndex) {
                    monthIndex = _monthArray.count-1;
                }
                
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
                
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
                
                
            }
        }
            break;
            
            
        case DateStyleShowYearMonth:{
            
            if (component == 0) {
                yearIndex = row;
            }
            if (component == 1) {
                monthIndex = row;
            }
            
            [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
            
        }
            break;
            
        default:
            break;
    }
    
    [self.datePicker reloadAllComponents];
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@",_yearArray[yearIndex],_monthArray[monthIndex],_dayArray[dayIndex]];
    
    _startDate = [NSDate getCurreDate:dateStr];
    NSLog(@"scrollToDate %@",_startDate);
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if( [touch.view isDescendantOfView:self.buttomView]) {
        return NO;
    }
    return YES;
}

#pragma mark - Action

-(void)show{
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        //        [self.buttomView setFrame:CGRectMake(x, y, width , height)];
    } completion:nil];
}

/**
 消失
 */
-(void)dismiss {
    [self.buttomView setFrame:CGRectMake(0, 0, 0, 0)];
    [self removeFromSuperview];
}


/**
 点击确认按钮
 
 @param btn <#btn description#>
 */
- (void)doneAction:(UIButton *)btn {
    self.doneBlock(_startDate);
    [self dismiss];
}

/**
 取消按钮
 */
-(void)calcelAction{
    [self dismiss];
}

#pragma mark - tools
//通过当前月展示不同月数
-(NSInteger)MonthsfromYear:(NSInteger)year {
    NSInteger num_year = year;
    
    if (year == [[self.beginDay componentsSeparatedByString:@"-"].firstObject integerValue]) {
        
        if (year == [[self.endDay componentsSeparatedByString:@"-"].firstObject integerValue]) {
            [_monthArray removeAllObjects];
            for (NSInteger i = [[[self.beginDay componentsSeparatedByString:@"-"] objectAtIndex:1] integerValue]; i<= [[[self.endDay componentsSeparatedByString:@"-"] objectAtIndex:1] integerValue] ; i ++) {
                [_monthArray addObject:[NSString stringWithFormat:@"%02ld",(long)i]];
            }
            return _monthArray.count;
        }
        
        [self setMonthArray:[[[self.beginDay componentsSeparatedByString:@"-"] objectAtIndex:1] integerValue]];
        return 13 - [[[self.beginDay componentsSeparatedByString:@"-"] objectAtIndex:1] integerValue];
    }
    else if (year == [[self.endDay componentsSeparatedByString:@"-"].firstObject integerValue]) {
        [self setMonthArray:1];
        return [[[self.endDay componentsSeparatedByString:@"-"] objectAtIndex:1] integerValue];
    }
    else {
        [self setMonthArray:1];
        return 12;
    }
    return 12;
}


//通过年月求每月天数
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_year  = year;
    NSInteger num_month = month;
    
    if (year == [[self.beginDay componentsSeparatedByString:@"-"].firstObject integerValue]) {
        NSArray<NSString *> *array = [self.beginDay componentsSeparatedByString:@"-"];
        
        if (num_year == array.firstObject.integerValue) {
            if (num_month == [array objectAtIndex:1].integerValue) {
                
                
                BOOL isrunNian = num_year%4==0 ? (num_year%100==0? (num_year%400==0?YES:NO):YES):NO;
                
                NSArray<NSString *> * endArray = [self.endDay componentsSeparatedByString:@"-"];
                if (num_year == endArray.firstObject.integerValue) {
                    if (num_month == [endArray objectAtIndex:1].integerValue) {
                        
                        [self setdayArrayBeginNum:array.lastObject.integerValue num:endArray.lastObject.integerValue];
                        return endArray.lastObject.integerValue - array.lastObject.integerValue + 1;
                    }
                }
                
                switch (num_month) {
                    case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
                        [self setdayArrayBeginNum:array.lastObject.integerValue num:31];
                        return 31 - array.lastObject.integerValue + 1;
                    }
                    case 4:case 6:case 9:case 11:{
                        [self setdayArrayBeginNum:array.lastObject.integerValue num:30];
                        return 30 - array.lastObject.integerValue + 1;
                    }
                    case 2:{
                        if (isrunNian) {
                            [self setdayArrayBeginNum:array.lastObject.integerValue num:29];
                            return 29 - array.lastObject.integerValue + 1;
                        }else{
                            [self setdayArrayBeginNum:array.lastObject.integerValue num:28];
                            return 28 - array.lastObject.integerValue + 1;
                        }
                    }
                    default:
                        break;
                }
                
                
            }
            else {
                NSArray<NSString *> *array = [self.endDay componentsSeparatedByString:@"-"];
                
                if (num_year == array.firstObject.integerValue) {
                    if (num_month == [array objectAtIndex:1].integerValue) {
                        [self setdayArrayBeginNum:1 num:array.lastObject.integerValue];
                        return array.lastObject.integerValue;
                    }
                }
                
            }
        }
    }
    else if (year == [[self.endDay componentsSeparatedByString:@"-"].firstObject integerValue]) {
        NSArray<NSString *> *array = [self.endDay componentsSeparatedByString:@"-"];
        
        if (num_year == array.firstObject.integerValue) {
            if (num_month == [array objectAtIndex:1].integerValue) {
                [self setdayArrayBeginNum:1 num:array.lastObject.integerValue];
                return array.lastObject.integerValue;
            }
        }
    }
    
    BOOL isrunNian = num_year%4==0 ? (num_year%100==0? (num_year%400==0?YES:NO):YES):NO;
    
    switch (num_month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
            [self setdayArrayBeginNum:1 num:31];
            return 31;
        }
        case 4:case 6:case 9:case 11:{
            [self setdayArrayBeginNum:1 num:30];
            return 30;
        }
        case 2:{
            if (isrunNian) {
                [self setdayArrayBeginNum:1 num:29];
                return 29;
            }else{
                [self setdayArrayBeginNum:1 num:28];
                return 28;
            }
        }
        default:
            break;
    }
    return 0;
}

//设置每月的天数数组
- (void)setdayArrayBeginNum:(NSInteger)beginNum num:(NSInteger)num
{
    [_dayArray removeAllObjects];
    _dayArray = [NSMutableArray array];
    for (NSInteger i=beginNum; i<=num; i++) {
        [_dayArray addObject:[NSString stringWithFormat:@"%02ld",i]];
    }
}
//设置每年的月数数组
-(void)setMonthArray:(NSInteger)num {
    [_monthArray removeAllObjects];
    for (NSInteger i = num; i<= 12; i ++) {
        [_monthArray addObject:[NSString stringWithFormat:@"%02ld",(long)i]];
    }
    
}

#pragma mark - getter / setter
-(UIPickerView *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, kPickerSize.width, kPickerSize.height - 50)];
        _datePicker.showsSelectionIndicator = YES;
        _datePicker.delegate = self;
        
        _datePicker.dataSource = self;
    }
    return _datePicker;
}


/**
 设置确认按钮的文字颜色
 
 @param themeColor <#themeColor description#>
 */
-(void)setThemeColor:(UIColor *)themeColor {
    _themeColor = themeColor;
    [self.doneBtn setTitleColor:themeColor forState:UIControlStateNormal];
}

-(void)setDatePickerStyle:(YMDateStyle)datePickerStyle {
    _datePickerStyle = datePickerStyle;
    _startDate = [NSDate date];
    //    [self getNowDate:_startDate animated:YES];
}

//滚动到指定的时间位置
- (void)getNowDate:(NSDate *)date animated:(BOOL)animated
{
    _startDate = date;
    if (!date) {
        date = [NSDate date];
    }
    
    [self DaysfromYear:date.year andMonth:date.month];
    
    if (self.beginDay) {
        NSInteger year = [[self.beginDay componentsSeparatedByString:@"-"].firstObject integerValue];
        yearIndex = date.year-year;
    }
    else {
        yearIndex = date.year-MINYEAR;
    }
    
    
    monthIndex = date.month-1;
    dayIndex = date.day-1;
    
    NSArray *indexArray;
    if (self.datePickerStyle == DateStyleShowYearMonth){
        indexArray = @[@(yearIndex),@(monthIndex)];
    }
    
    if (self.datePickerStyle == DateStyleShowYearMonthDay){
        indexArray = @[@(yearIndex),@(monthIndex),@(dayIndex)];
    }
    
    for (int i=0; i<indexArray.count; i++) {
        [self.datePicker selectRow:[indexArray[i] integerValue] inComponent:i animated:animated];
        
    }
    [self.datePicker reloadAllComponents];
    
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
