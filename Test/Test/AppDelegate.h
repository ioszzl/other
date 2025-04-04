//
//  AppDelegate.h
//  TestDemo
//
//  Created by 孙若淮 on 14/03/2018.
//  Copyright © 2018 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "FilterModel.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, assign) NSInteger userType;//0求职 1招聘

/**
 token,请将此token保存,后续接口若需要token参数,请带上
 */
@property (nonatomic, strong) NSString *token;//token说明:若后续调用接口返回如下参数,说明token失效或不存在,请跳转登录页面重新登录,token目前有效期为1天,每次调用需要token的接口,会在调用的时间上加1天成功token的最新失效时间,而且一个账号对应一个token,异地登录将会使原来的token失效.
@property (nonatomic, strong) UserModel *userModel;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, copy)NSString *baseImageUrl;
@property (nonatomic, copy)NSString *baseServerUrl;

@property (nonatomic, strong) FilterModel *gloableModel;//公共数据


//客服 相关字段
@property (nonatomic, assign) BOOL isPushed;
@property (nonatomic, assign) BOOL isConnecting;
@property (nonatomic, copy) NSDictionary * dictionary;

/**
 网络状态
 */
@property (nonatomic,assign)BOOL netWorkState;



#pragma mark - IM登录
-(void)loginIM;


#pragma mark - global
/**
 求职 工作经验年限
 
 @param workID 工作年限ID
 @return 工作年限
 */
-(NSString *)userWorkYearNameWithID:(NSInteger)workID;

/**
 企业 工作经验年限
 
 @param workID 工作年限ID
 @return 工作年限
 */
-(NSString *)companyWorkYearNameWithID:(NSInteger)workID;

/**
 学历
 
 @param educaID 学历ID
 @return 学历名称
 */
-(NSString *)educationNameWithID:(NSInteger)educaID;

/**
 薪资
 
 @param salaID 薪资ID
 @return 薪资
 */
-(NSString *)salaryNameWithID:(NSInteger)salaID;

/**
 公司类型
 
 @param companyTypeID 公司类型ID
 @return 公司类型
 */
-(NSString *)companyTypeNameWithID:(NSInteger)companyTypeID;

/**
 公司规模
 
 @param scaleID 公司规模ID
 @return 公司规模
 */
-(NSString *)companyScaleNameWithID:(NSInteger)scaleID;


- (void)closeAllPresentedViewControllers;
@end

