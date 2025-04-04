//
//  JobRequireView.h
//  Test
//
//  Created by eims on 2018/11/2.
//  Copyright © 2018 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JobRequireView : UIView
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *moneyLab;
@property (nonatomic, strong) UILabel *yearLab;
@property (nonatomic, strong) UILabel *educationLab;
@property (nonatomic, strong) UILabel *tradeLab;
@property (nonatomic, strong) UILabel *depositLab;
@property (nonatomic, strong) UILabel *payLab;

@property (nonatomic, strong) UILabel *addressLab;
@property (nonatomic, strong) UIButton *callBtn;

@property (nonatomic, strong) NSArray *markArr;
@property (nonatomic, strong) NSMutableArray<UILabel *> *tagLabArr;

@property (nonatomic, copy) void(^callBtnBlock)(void);
@property (nonatomic, copy) void(^addressTapBlock)(void);
@end

NS_ASSUME_NONNULL_END
