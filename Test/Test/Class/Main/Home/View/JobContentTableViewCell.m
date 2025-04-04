//
//  JobContentTableViewCell.m
//  Test
//
//  Created by zzl on 2018/11/4.
//  Copyright © 2018 Monster. All rights reserved.
//

#import "JobContentTableViewCell.h"

@implementation JobContentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return  self;
}
-(void)initUI{
    self.backgroundColor = RGBCOLOR(255, 255, 255);
    _titleLab = [UILabel ym_labelWithFrame:CGRectZero font:FONT_SIZE_15 textColor:COLOR_RGB_51];
    [self.contentView addSubview:_titleLab];
    [_titleLab setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(Size(15));
        make.top.mas_offset(Size(17));
    }];
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editBtn.hidden = YES;
    [_editBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
    [self.contentView addSubview:_editBtn];
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(Size(-15));
        make.top.mas_offset(Size(17));
    }];
    [_editBtn addTarget:self action:@selector(doEditBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _contentLab = [UILabel ym_labelWithFrame:CGRectZero font:FONT_SIZE_15 textColor:COLOR_RGB_102];
    _contentLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_contentLab];
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(Size(15));
        make.right.mas_offset(-Size(15));
        make.top.equalTo(_titleLab.mas_bottom).mas_offset(Size(17));
        //make.bottom.mas_equalTo(-Size(15));
    }];
    
    _line = [UIView new];
    _line.backgroundColor = COLOR_RGB_line;
    [self.contentView addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_offset(0);
    }];
}

-(void)doEditBtn{
    BLOCK_EXEC(self.editBtnBlock);
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
