//
//  CityFilterView.m
//  Test
//
//  Created by eims on 2018/11/16.
//  Copyright © 2018 Monster. All rights reserved.
//

#import "CityFilterView.h"
#import "MineInfoTableViewCell.h"
#import "AddressModel.h"
@interface CityFilterView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSArray *dataSource;
@property(nonatomic,strong)NSDictionary *pickerDic;

@property (nonatomic, assign) NSUInteger provinceId;
@property (nonatomic, assign) NSUInteger cityId;
@property (nonatomic, assign) NSUInteger areaId;

@property(nonatomic,strong)AddressModel        * model;
@end

@implementation CityFilterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.backgroundColor = COLOR_BG;
    
    UIButton *provinceBtn = [UIButton ym_ButtonWithFrame:CGRectZero title:@"省份" backgroundColor:nil titleColor:COLOR_RGB_51 titleSize:Size(13)];
    [provinceBtn setTitleColor:COLOR_MAIN forState:UIControlStateSelected];
    [self addSubview:provinceBtn];
    [provinceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(Size(15));
        make.height.mas_equalTo(Size(72/2));
        make.width.mas_equalTo(Size(140/2));
    }];
    provinceBtn.selected = YES;
    
    UIButton *cityBtn = [UIButton ym_ButtonWithFrame:CGRectZero title:@"城市" backgroundColor:nil titleColor:COLOR_RGB_51 titleSize:Size(13)];
    [cityBtn setTitleColor:COLOR_MAIN forState:UIControlStateSelected];
    [self addSubview:cityBtn];
    [cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_equalTo(provinceBtn.mas_right);
        make.height.mas_equalTo(Size(72/2));
        make.width.mas_equalTo(Size(140/2));
    }];
    
    UIButton *areaBtn = [UIButton ym_ButtonWithFrame:CGRectZero title:@"区县" backgroundColor:nil titleColor:COLOR_RGB_51 titleSize:Size(13)];
    [areaBtn setTitleColor:COLOR_MAIN forState:UIControlStateSelected];
    [self addSubview:areaBtn];
    [areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_equalTo(cityBtn.mas_right);
        make.height.mas_equalTo(Size(72/2));
        make.width.mas_equalTo(Size(140/2));
    }];
    
    UIButton *allBtn = [UIButton ym_ButtonWithFrame:CGRectZero title:@"重置" backgroundColor:nil titleColor:COLOR_RGB_51 titleSize:Size(13)];
    [allBtn setTitleColor:COLOR_MAIN forState:UIControlStateSelected];
    [self addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_equalTo(Size(72/2));
        make.width.mas_equalTo(Size(140/2));
    }];
    
    self.btnArr = @[provinceBtn,cityBtn,areaBtn,allBtn];
    [provinceBtn addTarget:self action:@selector(doCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cityBtn addTarget:self action:@selector(doCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    [areaBtn addTarget:self action:@selector(doCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [allBtn addTarget:self action:@selector(doCityBtn:) forControlEvents:UIControlEventTouchUpInside];
   
    _tableV = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableV.tableFooterView = [UIView new];
    _tableV.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableV.showsVerticalScrollIndicator = NO;
    _tableV.showsHorizontalScrollIndicator = NO;
    _tableV.backgroundColor = COLOR_BG;
    _tableV.dataSource = self;
    _tableV.delegate = self;
    [self addSubview:_tableV];
    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(Size(72/2));
        make.left.right.bottom.mas_offset(0);
    }];
    
    [self getPickerData];
}

- (void)setInitCityId:(NSInteger)initCityId{
    _initCityId = initCityId;
    if (initCityId == -1){
        self.btnArr[3].selected = YES;
    }
    else if (initCityId == 0) {
        //self.btnArr[3].selected = YES;
        self.provinceId = 100000;
        [self doCityBtn:self.btnArr[0]];
        
    }else{
        NSLog(@"%ld",initCityId/10000 * 10000) ;
        
        self.provinceId = initCityId/10000 * 10000;
        [self doCityBtn:self.btnArr[0]];
    }

    
}
-(void)setDefautCityStr:(NSString *)defautCityStr{
    _defautCityStr = defautCityStr;
    NSDate *data = [NSDate date];

    for (ProvinceData *p in self.model.data) {
        if ([p.name isEqualToString:defautCityStr]) {
            self.initCityId = p.ID;
            break;
        }else{
            for (CityData *c in p.data) {
                if ([c.name isEqualToString: defautCityStr]) {
                    self.initCityId = c.ID;
                    break;
                }else{
                    for (AreaData *a in c.data) {
                        if ([a.name isEqualToString: defautCityStr]) {
                            self.initCityId = a.ID;
                            break;
                        }
                    }
                }
            }
        }
    }
    NSDate *d = [NSDate date];
//    NSLog(@"%ld ----- %ld : %ld",[data timeIntervalSince1970], [d timeIntervalSince1970], [d timeIntervalSince1970] - [data timeIntervalSince1970]);
}

-(void)show{
//    self.hidden = NO;
//    self.provinceId = self.model.data[0].ID;
//    [self doCityBtn:self.btnArr[0]];
}
#pragma mark - get data
- (void)getPickerData
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CJAddress" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    self.model = [AddressModel mj_objectWithKeyValues:self.pickerDic];
    
    [self.tableV reloadData];
}
#pragma mark - action
-(void)doCityBtn:(UIButton *)btn{
    for (UIButton *btt in self.btnArr) {
        btt.selected = NO;
    }
    btn.selected = YES;
    
    if ([btn.titleLabel.text isEqualToString:@"省份"]) {
        self.dataSource = self.model.data;
        
        //if (self.provinceId) {
            [self scrollVisibArr:self.dataSource ID:self.provinceId];
        //}
        
        
        //self.tableV scrollRectToVisible:<#(CGRect)#> animated:<#(BOOL)#>
    }
    if ([btn.titleLabel.text isEqualToString:@"城市"]) {
        if (self.provinceId) {
            for (ProvinceData *p in self.model.data) {
                if (p.ID == self.provinceId) {
                    self.dataSource = p.data;
                    break;
                }
            }
        }else{
            self.dataSource = self.model.data[0].data;
        }
        //if (self.cityId) {
            [self scrollVisibArr:self.dataSource ID:self.cityId];
        //}
    }
    if ([btn.titleLabel.text isEqualToString:@"区县"]) {
        if (self.cityId) {
            for (ProvinceData *p in self.model.data) {
                if (p.ID == self.provinceId) {
                    for (CityData *c in p.data) {
                        if (c.ID == self.cityId) {
                            self.dataSource = c.data;
                            break;
                        }
                    }
                    break;
                }
            }
            
        }else{
            if (self.provinceId) {
                for (ProvinceData *p in self.model.data) {
                    if (p.ID == self.provinceId) {
                        self.dataSource = p.data[0].data;
                        break;
                    }
                }
            }else{
                self.dataSource = [self.model.data[0].data objectAtIndex:0].data;
            }
            
        }
        [self scrollVisibArr:self.dataSource ID:self.areaId];
    }
    
    if ([btn.titleLabel.text isEqualToString:@"重置"]) {
        self.dataSource = self.model.data;
        [self scrollVisibArr:self.dataSource ID:self.model.data.firstObject.ID];
        self.provinceId = 0;
        self.cityId = 0;
        self.areaId = 0;
        
        self.hidden = YES;
        BLOCK_EXEC(self.citySelectedBlock,@"全部",-1);
        
    }
    [self.tableV reloadData];
}
-(void)scrollVisibArr:(NSArray *)arr ID:(NSInteger)ID{
    for (int i=0; i<arr.count; i++) {
        if (ID == ((ProvinceData *)arr[i]).ID){
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新完成
                [self.tableV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            });
            
            return;
        }
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        //刷新完成
        [self.tableV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    });
}
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MineInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(Size(70/2));
            make.centerY.equalTo(cell.contentView);
        }];
        cell.titleLab.font = [UIFont systemFontOfSize:Size(13)];
        cell.arrowImgV.hidden = YES;
        cell.textF.hidden = YES;
    }
    cell.titleLab.text = ((ProvinceData *)self.dataSource[indexPath.row]).name;
    if (self.btnArr[0].selected) {
        //省份
        if (self.provinceId == ((ProvinceData *)self.dataSource[indexPath.row]).ID) {
            cell.titleLab.textColor = COLOR_MAIN;
        }else{
            cell.titleLab.textColor = COLOR_RGB_51;
        }
    }
    if (self.btnArr[1].selected) {
        //城市
        if (self.cityId == ((ProvinceData *)self.dataSource[indexPath.row]).ID) {
            cell.titleLab.textColor = COLOR_MAIN;
        }else{
            cell.titleLab.textColor = COLOR_RGB_51;
        }
    }
    if (self.btnArr[2].selected) {
        //区县
        if (self.areaId == ((ProvinceData *)self.dataSource[indexPath.row]).ID) {
            cell.titleLab.textColor = COLOR_MAIN;
        }else{
            cell.titleLab.textColor = COLOR_RGB_51;
        }
    }
    if (self.btnArr[3].selected) {
        //全部
        cell.titleLab.textColor = COLOR_RGB_51;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Size(98/2);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MineInfoTableViewCell *cell = (MineInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (self.btnArr[0].selected || self.btnArr[3].selected) {
        self.provinceId = self.model.data[indexPath.row].ID;
        self.cityId = 0;
        self.areaId = 0;
        self.dataSource = self.model.data[indexPath.row].data;
        [self doCityBtn:self.btnArr[1]];
    }else if (self.btnArr[1].selected){
        self.cityId = ((CityData *)self.dataSource[indexPath.row]).ID;
        self.areaId = 0;
        self.dataSource = ((CityData *)self.dataSource[indexPath.row]).data;
        [self doCityBtn:self.btnArr[2]];
    }else if (self.btnArr[2].selected){
        self.areaId = ((CityData *)self.dataSource[indexPath.row]).ID;
        self.hidden = YES;
    }
    
    NSInteger idStr = self.provinceId;
    if (self.areaId) {
        idStr = self.areaId;
    }else{
        if (self.cityId){
            idStr = self.cityId;
        }
    }
    
    BLOCK_EXEC(self.citySelectedBlock,cell.titleLab.text,idStr);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
