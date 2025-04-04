//
//  TYCyclePagerViewCell.m
//  TYCyclePagerViewDemo
//
//  Created by tany on 2017/6/14.
//  Copyright © 2017年 tany. All rights reserved.
//

#import "TYCyclePagerViewCell.h"

@interface TYCyclePagerViewCell ()


@end

@implementation TYCyclePagerViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = HEXRGBCOLOR(0xf4f4f4);
        [self addUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        [self addUI];
    }
    return self;
}


- (void)addUI {
//    self.contentImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
    self.contentImage = [[UIImageView alloc] init];
    //[self.contentImage setContentMode:UIViewContentModeScaleAspectFill];

    //_contentImage.image = [UIImage imageNamed:@"xinwen"];

    [self.contentView addSubview:_contentImage];
    [self.contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
//    _titleLab = [UILabel ym_labelWithFrame:CGRectMake(0, _contentImage.bottom-Size(15), _contentImage.width-Size(25), Size(15)) font:[UIFont systemFontOfSize:Size(12)] textColor:HEXRGBCOLOR(0x000000)];
//    _titleLab.numberOfLines = 1;
//    [self.contentView addSubview:_titleLab];
    
    
//    _locationLab = [UILabel ym_labelWithFrame:CGRectMake(_titleLab.right, _titleLab.top, Size(25), Size(12.5)) font:[UIFont systemFontOfSize:Size(10)] textColor:HEXRGBCOLOR(0xffffff)];
//    [self.contentView addSubview:_locationLab];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
