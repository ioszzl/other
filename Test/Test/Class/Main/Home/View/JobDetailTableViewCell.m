//
//  JobDetailTableViewCell.m
//  Test
//
//  Created by zzl on 2018/11/4.
//  Copyright © 2018 Monster. All rights reserved.
//

#import "JobDetailTableViewCell.h"

@implementation JobDetailTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = RGBCOLOR(255, 255, 255);
    _titleLab = [UILabel ym_labelWithFrame:CGRectZero font:FONT_SIZE_15 textColor:COLOR_RGB_51];
    [self.contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(Size(15));
        make.top.mas_offset(Size(17));
        
    }];
    
    _contentLab = [UILabel ym_labelWithFrame:CGRectZero font:FONT_SIZE_15 textColor:COLOR_RGB_102];
    [self.contentView addSubview:_contentLab];
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLab.mas_right).mas_offset(Size(17));
        make.right.mas_lessThanOrEqualTo(-Size(15));
        make.top.equalTo(_titleLab);
    }];
    
    _line = [UIView new];
    _line.backgroundColor = COLOR_RGB_line;
    [self.contentView addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(Size(15));
        make.right.mas_offset(-Size(15));
        make.height.mas_equalTo(0.5);
        make.bottom.mas_offset(0);
    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
