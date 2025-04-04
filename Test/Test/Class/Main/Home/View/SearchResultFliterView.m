//
//  SearchResultFliterView.m
//  Test
//
//  Created by eims on 2018/11/2.
//  Copyright © 2018 Monster. All rights reserved.
//

#import "SearchResultFliterView.h"
#import "RHNetAPIManager.h"
#import "RHNetAPIManager+Request.h"
#import "FilterModel.h"

#define COLOR_MAIN_Btn  (AppDelegateInstance.userType == 1 ? RGBCOLOR(75, 179, 240) : RGBCOLOR(254, 207, 35))
@interface SearchResultFliterView(){
    
    UIView *_verLine;
}
@property (nonatomic, strong) FilterModel *model;

@property (nonatomic, strong) NSMutableArray *eduArr;
@property (nonatomic, strong) NSMutableArray *salaArr;
@property (nonatomic, strong) NSMutableArray *workArr;

@property (nonatomic, strong) NSMutableArray<UIButton *> *tradeBtnArr;
@property (nonatomic, strong) NSMutableArray<UIButton *> *cityBtnArr;
@property (nonatomic, strong) NSMutableArray<UIButton *> *educationBtnArr;
@property (nonatomic, strong) NSMutableArray<UIButton *> *yearBtnArr;
@property (nonatomic, strong) NSMutableArray<UIButton *> *payBtnArr;

@end

@implementation SearchResultFliterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBCOLOR(255, 255, 255);
        [self initUI];
    }
    return self;
}
-(void)initUI{
    UIView *verLine = [UIView new];
    verLine.backgroundColor = RGBCOLOR(230, 230, 230);
    [self addSubview:verLine];
    [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(Size(142/2));
        make.top.bottom.mas_offset(0);
        make.width.mas_equalTo(0.5);
    }];
    _verLine = verLine;
    _verLine.hidden = YES;
    
    NSArray *itemArr = @[@"全部学历",@"全部经验",@"全部薪资",@"全部区域",@"全部行业"];
    
    for (int i=0; i<itemArr.count; i++) {
        UIButton *btn = [UIButton ym_ButtonWithFrame:CGRectZero title:itemArr[i] backgroundColor:RGBCOLOR(255, 255, 255) titleColor:COLOR_RGB_153 titleSize:Size(13)];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:Size(13)];
        btn.layer.cornerRadius = Size(5);
        btn.clipsToBounds = YES;
        btn.tag = 0;
        [btn setTitleColor:COLOR_RGB_51 forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage ym_imageWithColor:COLOR_MAIN_Btn size:CGSizeMake(Size(126/2), 48/2)] forState:UIControlStateSelected];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(Size(13) + (Size(12 + 48/2) + 0.5) * i);
            make.left.mas_offset(Size(4));
            make.width.mas_equalTo(Size(126/2));
            make.height.mas_equalTo(Size(48/2));
        }];
        if (i == 0) {
            [self.educationBtnArr addObject:btn];
            [btn addTarget:self action:@selector(doEducationBtn:) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 1){
            [self.yearBtnArr addObject:btn];
            [btn addTarget:self action:@selector(doYearBtn:) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 2){
            [self.payBtnArr addObject:btn];
            [btn addTarget:self action:@selector(doPayBtn:) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 3){
            btn.selected = YES;
            [self.cityBtnArr addObject:btn];
            [btn addTarget:self action:@selector(doCityBtn:) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 4){
            btn.selected = YES;
            [self.tradeBtnArr addObject:btn];
            [btn addTarget:self action:@selector(doTradeBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        /*
        if (i != itemArr.count-1) {
            UIView *line = [UIView new];
            line.backgroundColor = RGBCOLOR(230, 230, 230);
            [self addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btn.mas_bottom).mas_offset(Size(6));
                make.width.mas_equalTo(Size(142/2));
                make.height.mas_equalTo(0.5);
                make.left.mas_offset(0);
            }];
        }
        */
        
    }
    
    [self requestData];
}

- (void)setSelectEduIndex:(NSInteger)selectEduIndex{
    _selectEduIndex = selectEduIndex;
    
    for (UIButton *btn in self.educationBtnArr) {
        btn.selected = NO;
    }
    self.educationBtnArr[selectEduIndex].selected = YES;
}
- (void)setSelectYearIndex:(NSInteger)selectYearIndex{
    _selectYearIndex = selectYearIndex;
    
    for (UIButton *btn in self.yearBtnArr) {
        btn.selected = NO;
    }
    self.yearBtnArr[selectYearIndex].selected = YES;
}
- (void)setSelectPayIndex:(NSInteger)selectPayIndex{
    _selectPayIndex = selectPayIndex;
    
    for (UIButton *btn in self.payBtnArr) {
        btn.selected = NO;
    }
    self.payBtnArr[selectPayIndex].selected = YES;
}
-(void)setEduArr:(NSMutableArray *)eduArr{
    _eduArr = eduArr;
    
    UIScrollView *scroll = [UIScrollView new];
    scroll.showsHorizontalScrollIndicator = NO;
    [self addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_verLine.mas_right);
        make.right.mas_offset(0);
        make.height.mas_equalTo(Size(74/2));
        make.centerY.equalTo(self.educationBtnArr[0]);
    }];
    
    UIButton *tempBtn;
    for (int n=0; n < eduArr.count; n++) {
        CGFloat w = [eduArr[n] ym_getStringWidthfont:FONT_SIZE_12] + Size(18);
        UIButton *btn1 = [UIButton ym_ButtonWithFrame:CGRectZero title:eduArr[n] backgroundColor:RGBCOLOR(255, 255, 255) titleColor:COLOR_RGB_51 titleSize:Size(12)];
        btn1.layer.cornerRadius = Size(5);
        btn1.clipsToBounds = YES;
        btn1.tag = n+1;
        [btn1 setBackgroundImage:[UIImage ym_imageWithColor:COLOR_MAIN_Btn size:CGSizeMake(Size(126/2), 48/2)] forState:UIControlStateSelected];
        [scroll addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!tempBtn) {
                make.left.mas_offset(Size(6));
            }else{
               
                make.left.equalTo(tempBtn.mas_right).mas_offset(Size(16));
            }
            make.centerY.equalTo(scroll);
            make.width.mas_equalTo(w);
            make.height.mas_equalTo(Size(48/2));
        }];
        
        
        tempBtn = btn1;
        [self.educationBtnArr addObject:btn1];
        [btn1 addTarget:self action:@selector(doEducationBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        if (n == eduArr.count-1) {
            [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(btn1.mas_right).mas_offset(Size(10));
            }];
        }
    }
}

-(void)setSalaArr:(NSMutableArray *)salaArr{
    _salaArr = salaArr;
    
    UIScrollView *scroll = [UIScrollView new];
    scroll.showsHorizontalScrollIndicator = NO;
    [self addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_verLine.mas_right);
        make.right.mas_offset(0);
        make.height.mas_equalTo(Size(74/2));
        make.centerY.equalTo(self.payBtnArr[0]);
    }];
    
    UIButton *tempBtn;
    for (int n=0; n < salaArr.count; n++) {
        CGFloat w = [salaArr[n] ym_getStringWidthfont:FONT_SIZE_12] + Size(18);
        UIButton *btn1 = [UIButton ym_ButtonWithFrame:CGRectZero title:salaArr[n] backgroundColor:RGBCOLOR(255, 255, 255) titleColor:COLOR_RGB_51 titleSize:Size(12)];
        btn1.layer.cornerRadius = Size(5);
        btn1.clipsToBounds = YES;
        btn1.tag = n+1;
        [btn1 setBackgroundImage:[UIImage ym_imageWithColor:COLOR_MAIN_Btn size:CGSizeMake(Size(126/2), 48/2)] forState:UIControlStateSelected];
        [scroll addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!tempBtn) {
                make.left.mas_offset(Size(6));
            }else{
                
                make.left.equalTo(tempBtn.mas_right).mas_offset(Size(10));
            }
            make.centerY.equalTo(scroll);
            make.width.mas_equalTo(w);
            make.height.mas_equalTo(Size(48/2));
        }];
        
        
        tempBtn = btn1;
        [self.payBtnArr addObject:btn1];
        [btn1 addTarget:self action:@selector(doPayBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        if (n == salaArr.count-1) {
            [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(btn1.mas_right).mas_offset(Size(10));
            }];
        }
    }
}

-(void)setWorkArr:(NSMutableArray *)workArr{
    _workArr = workArr;
    
    UIScrollView *scroll = [UIScrollView new];
    scroll.showsHorizontalScrollIndicator = NO;
    [self addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_verLine.mas_right);
        make.right.mas_offset(0);
        make.height.mas_equalTo(Size(74/2));
        make.centerY.equalTo(self.yearBtnArr[0]);
    }];
    
    UIButton *tempBtn;
    for (int n=0; n < workArr.count; n++) {
        CGFloat w = [workArr[n] ym_getStringWidthfont:FONT_SIZE_12] + Size(18);
        UIButton *btn1 = [UIButton ym_ButtonWithFrame:CGRectZero title:workArr[n] backgroundColor:RGBCOLOR(255, 255, 255) titleColor:COLOR_RGB_51 titleSize:Size(12)];
        btn1.layer.cornerRadius = Size(5);
        btn1.clipsToBounds = YES;
        btn1.tag = n+1;
        [btn1 setBackgroundImage:[UIImage ym_imageWithColor:COLOR_MAIN_Btn size:CGSizeMake(Size(126/2), 48/2)] forState:UIControlStateSelected];
        [scroll addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!tempBtn) {
                make.left.mas_offset(Size(6));
            }else{
                
                make.left.equalTo(tempBtn.mas_right).mas_offset(Size(14));
            }
            make.centerY.equalTo(scroll);
            make.width.mas_equalTo(w);
            make.height.mas_equalTo(Size(48/2));
        }];
        
        
        tempBtn = btn1;
        [self.yearBtnArr addObject:btn1];
        [btn1 addTarget:self action:@selector(doYearBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        if (n == workArr.count-1) {
            [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(btn1.mas_right).mas_offset(Size(10));
            }];
        }
    }
}

-(void)setTradeArr:(NSArray *)tradeArr{
    _tradeArr = tradeArr;
    if (tradeArr.count == 0) {
        self.tradeBtnArr[0].selected = YES;
    }else{
        self.tradeBtnArr[0].selected = NO;
    }
    if ([self viewWithTag:1000]) {
        [self.tradeBtnArr removeObjectsInRange:NSMakeRange(1, self.tradeBtnArr.count-1)];
        [[self viewWithTag:1000]removeFromSuperview];
    }
    UIScrollView *scroll = [UIScrollView new];
    scroll.tag = 1000;
    scroll.showsHorizontalScrollIndicator = NO;
    [self addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_verLine.mas_right);
        make.right.mas_offset(0);
        make.height.mas_equalTo(Size(74/2));
        make.centerY.equalTo(self.tradeBtnArr[0]);
    }];
    
    UIButton *tempBtn;
    for (int n=0; n < tradeArr.count; n++) {
        CGFloat w = [tradeArr[n] ym_getStringWidthfont:FONT_SIZE_12] + Size(18);
        UIButton *btn1 = [UIButton ym_ButtonWithFrame:CGRectZero title:tradeArr[n] backgroundColor:RGBCOLOR(255, 255, 255) titleColor:COLOR_RGB_51 titleSize:Size(12)];
        btn1.layer.cornerRadius = Size(5);
        btn1.clipsToBounds = YES;
        [btn1 setBackgroundImage:[UIImage ym_imageWithColor:COLOR_MAIN_Btn size:CGSizeMake(Size(126/2), 48/2)] forState:UIControlStateSelected];
        [scroll addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!tempBtn) {
                make.left.mas_offset(Size(6));
            }else{
                
                make.left.equalTo(tempBtn.mas_right).mas_offset(Size(23));
            }
            make.centerY.equalTo(scroll);
            make.width.mas_equalTo(w);
            make.height.mas_equalTo(Size(48/2));
        }];
        
        
        tempBtn = btn1;
        btn1.selected = YES;
        [self.tradeBtnArr addObject:btn1];
//        [btn1 addTarget:self action:@selector(doTradeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        if (n == tradeArr.count-1) {
            [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(btn1.mas_right).mas_offset(Size(10));
            }];
        }
    }
}
-(void)setCityArr:(NSArray *)cityArr{
    _cityArr = cityArr;
    self.cityBtnArr[0].selected = NO;
    if ([self viewWithTag:2000]) {
        [self.cityBtnArr removeObjectsInRange:NSMakeRange(1, self.cityBtnArr.count-1)];
        [[self viewWithTag:2000]removeFromSuperview];
    }
    UIScrollView *scroll = [UIScrollView new];
    scroll.tag = 2000;
    scroll.showsHorizontalScrollIndicator = NO;
    [self addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_verLine.mas_right);
        make.right.mas_offset(0);
        make.height.mas_equalTo(Size(74/2));
        make.centerY.equalTo(self.cityBtnArr[0]);
    }];
    
    UIButton *tempBtn;
    for (int n=0; n < cityArr.count; n++) {
        CGFloat w = [cityArr[n] ym_getStringWidthfont:FONT_SIZE_12] + Size(18);
        UIButton *btn1 = [UIButton ym_ButtonWithFrame:CGRectZero title:cityArr[n] backgroundColor:RGBCOLOR(255, 255, 255) titleColor:COLOR_RGB_51 titleSize:Size(12)];
        btn1.layer.cornerRadius = Size(5);
        btn1.clipsToBounds = YES;
        [btn1 setBackgroundImage:[UIImage ym_imageWithColor:COLOR_MAIN_Btn size:CGSizeMake(Size(126/2), 48/2)] forState:UIControlStateSelected];
        [scroll addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!tempBtn) {
                make.left.mas_offset(Size(6));
            }else{
                
                make.left.equalTo(tempBtn.mas_right).mas_offset(Size(23));
            }
            make.centerY.equalTo(scroll);
            make.width.mas_equalTo(w);
            make.height.mas_equalTo(Size(48/2));
        }];
        
        
        tempBtn = btn1;
        btn1.selected = YES;
        [self.cityBtnArr addObject:btn1];
//        [btn1 addTarget:self action:@selector(doCityBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        if (n == cityArr.count-1) {
            [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(btn1.mas_right).mas_offset(Size(10));
            }];
        }
    }
}
/*
-(void)setItem{
    NSArray<NSArray *> *detailArr = @[@[@"大专",@"本科",@"硕士",@"博士"],
                                      @[@"应届生",@"1年以内",@"1-3年",@"5-10年",@"10年以上"],
                                      @[@"3K一下",@"3K-5K",@"5K-10K",@"10K-15K",@"15K-20K",@"20K-30K"],
                                      @[@"广东省深圳市宝安区"],
                                      @[@"计算机软件",@"计算机硬件",@"计算机服务"]];
    UIButton *tempBtn;
    for (int n=0; n < detailArr[i].count; n++) {
        CGFloat w = [detailArr[i][n] ym_getStringWidthfont:FONT_SIZE_12] + Size(18);
        UIButton *btn1 = [UIButton ym_ButtonWithFrame:CGRectZero title:detailArr[i][n] backgroundColor:RGBCOLOR(255, 255, 255) titleColor:COLOR_RGB_51 titleSize:Size(12)];
        btn1.layer.cornerRadius = Size(5);
        btn1.clipsToBounds = YES;
        [btn1 setBackgroundImage:[UIImage ym_imageWithColor:COLOR_MAIN_Btn size:CGSizeMake(Size(126/2), 48/2)] forState:UIControlStateSelected];
        [scroll addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!tempBtn) {
                make.left.mas_offset(Size(6));
            }else{
                if (i == 0) {
                    make.left.equalTo(tempBtn.mas_right).mas_offset(Size(16));
                }else if (i == 1){
                    make.left.equalTo(tempBtn.mas_right).mas_offset(Size(14));
                }else if (i == 2){
                    make.left.equalTo(tempBtn.mas_right).mas_offset(Size(10));
                }else{
                    make.left.equalTo(tempBtn.mas_right).mas_offset(Size(23));
                }
                
            }
            make.centerY.equalTo(scroll);
            make.width.mas_equalTo(w);
            make.height.mas_equalTo(Size(48/2));
        }];
        
        
        tempBtn = btn1;
        if (i == 0) {
            [self.educationBtnArr addObject:btn1];
            [btn1 addTarget:self action:@selector(doEducationBtn:) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 1){
            [self.yearBtnArr addObject:btn1];
            [btn1 addTarget:self action:@selector(doYearBtn:) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 2){
            [self.payBtnArr addObject:btn1];
            [btn1 addTarget:self action:@selector(doPayBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        
        if (n == detailArr[i].count-1) {
            [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(btn1.mas_right).mas_offset(Size(10));
            }];
        }
    }
}
 */
#pragma mark - request
-(void)requestData{
    
        NSMutableArray *temp = [NSMutableArray array];
        for (Scale *s in AppDelegateInstance.gloableModel.data.eduLevel) {
            [temp addObject:s.value];
        }
        self.eduArr = temp;
    
        NSMutableArray *temp1 = [NSMutableArray array];
        for (Scale *s in AppDelegateInstance.gloableModel.data.companyWorkYear) {
            [temp1 addObject:s.value];
        }
        NSMutableArray *temp2 = [NSMutableArray array];
        for (Scale *s in AppDelegateInstance.gloableModel.data.userWorkYear) {
            [temp2 addObject:s.value];
        }
        self.workArr = AppDelegateInstance.userType == 1 ? temp1 : temp2;
    
        NSMutableArray *temp3 = [NSMutableArray array];
        for (Scale *s in AppDelegateInstance.gloableModel.data.salary) {
            [temp3 addObject:s.value];
        }
        self.salaArr = temp3;
            
    
}
#pragma mark - action
//学历
-(void)doEducationBtn:(UIButton *)btn{
    self.selectEduIndex = btn.tag;
    NSInteger eduID;
    if (btn.tag == 0) {
        eduID = -1;
    }else{
        eduID = AppDelegateInstance.gloableModel.data.eduLevel[btn.tag-1].ID;
    }
    
    BLOCK_EXEC(self.educationBtnBlock,btn,eduID);
}
//经验
-(void)doYearBtn:(UIButton *)btn{
    self.selectYearIndex = btn.tag;
    NSInteger yearID;
    if (btn.tag == 0) {
        yearID = -1;
    }else{
        if (AppDelegateInstance.userType == 1) {
            yearID = AppDelegateInstance.gloableModel.data.companyWorkYear[btn.tag-1].ID;
        }else{
            yearID = AppDelegateInstance.gloableModel.data.userWorkYear[btn.tag-1].ID;
        }
    }
    BLOCK_EXEC(self.yearBtnBlock,btn,yearID);
}
//薪资
-(void)doPayBtn:(UIButton *)btn{
    self.selectPayIndex = btn.tag;
    NSInteger payID;
    if (btn.tag == 0) {
        payID = -1;
    }else{
        payID = AppDelegateInstance.gloableModel.data.salary[btn.tag-1].ID;
    }
    BLOCK_EXEC(self.payBtnBlock,btn,payID);
}
//区域
-(void)doCityBtn:(UIButton *)btn{
    BLOCK_EXEC(self.cityBtnBlock,btn);
}
//行业
-(void)doTradeBtn:(UIButton *)btn{
    BLOCK_EXEC(self.tradeBtnBlock,btn);
}



-(void)doItemBtn:(UIButton *)btn{
    BLOCK_EXEC(self.itemBtnBlock,btn);
}

-(NSMutableArray<UIButton *> *)educationBtnArr{
    if (!_educationBtnArr) {
        _educationBtnArr = [NSMutableArray array];
    }
    return _educationBtnArr;
}
-(NSMutableArray<UIButton *> *)yearBtnArr{
    if (!_yearBtnArr) {
        _yearBtnArr = [NSMutableArray array];
    }
    return _yearBtnArr;
}
-(NSMutableArray<UIButton *> *)payBtnArr{
    if (!_payBtnArr) {
        _payBtnArr = [NSMutableArray array];
    }
    return _payBtnArr;
}
-(NSMutableArray<UIButton *> *)cityBtnArr{
    if (!_cityBtnArr) {
        _cityBtnArr = [NSMutableArray array];
    }
    return _cityBtnArr;
}
-(NSMutableArray<UIButton *> *)tradeBtnArr{
    if (!_tradeBtnArr) {
        _tradeBtnArr = [NSMutableArray array];
    }
    return _tradeBtnArr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
