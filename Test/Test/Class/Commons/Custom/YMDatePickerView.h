//
//  YMDatePickerView.h
//  Test
//
//  Created by eims on 17/6/20.
//  Copyright © 2017年 eims. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    DateStyleShowYearMonth = 0,
    DateStyleShowYearMonthDay,
}YMDateStyle;

@interface YMDatePickerView : UIView
@property (nonatomic,assign)YMDateStyle datePickerStyle;//选择器的类型
@property (nonatomic,strong)UIColor *themeColor;//设置确认按钮的文字颜色
@property (nonatomic, copy) void(^doneBlock)(NSDate *date);


/**
 初始化
 
 @param x 坐标x
 @param y 坐标y
 @param width 宽度
 @param height 高度
 @return <#return value description#>
 */
-(id)initWithUI:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

/**
 弹出view
 */
-(void)show;


/**
 开始时间
 */
@property (nonatomic, copy) NSString * beginDay;

/**
 截止时间
 */
@property (nonatomic, copy) NSString * endDay;

//滚动到指定的时间位置
- (void)getNowDate:(NSDate *)date animated:(BOOL)animated;

@end
