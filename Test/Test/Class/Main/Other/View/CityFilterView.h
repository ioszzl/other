//
//  CityFilterView.h
//  Test
//
//  Created by eims on 2018/11/16.
//  Copyright © 2018 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 城市筛选View
 */
@interface CityFilterView : UIView
@property (nonatomic, strong) NSArray<UIButton *> *btnArr;

@property (nonatomic, assign) NSInteger initCityId;
@property (nonatomic, copy) NSString *defautCityStr;

@property (nonatomic, copy) void(^citySelectedBlock)(NSString *cityStr, NSInteger cityId);
-(void)show;
@end

NS_ASSUME_NONNULL_END
