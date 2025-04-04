//
//  AppDelegate+ThirdConfig.m
//  Test
//
//  Created by zhaohaohao on 2018/12/4.
//  Copyright © 2018年 Monster. All rights reserved.
//

#import "AppDelegate+ThirdConfig.h"

#import <UMCommon/UMCommon.h>
#import <UMShare/UMSocialManager.h>

#import "MainTabBarController.h"
#import "BaseNavigationController.h"


//闪验
#define cl_SDK_APPID    @"TwF8j8Gn"//@"eWWfA2KJ"
#define cl_SDK_APPKEY   @"N0tj79HS"//@"tDo3Ml2K"

//真实
static NSString *UMKey = @"5c05f174f1f5565289000078";
static NSString *WXAppKey = @"wx7056a4c61d870673";
static NSString *WXAppSecret = @"240aa225fb46bae67ba85a0ad4668a14";
static NSString *QQAppKey = @"1107838458";//@"101519893";
static NSString *QQAppSecret = @"39r4sfyoqFHXAFgh";//@"0eda41a868380aeef4d8d5ad9166cc5e";
static NSString *SinaAppKey = @"2300533974";
static NSString *SinaAppSecret = @"4be91101699d1820b0eafe91e3cc443d";



@implementation AppDelegate (ThirdConfig)



- (void)thirdConfig{
    //友盟配置
    [self configUmeng];
}
#pragma  mark --友盟相关
- (void)configUmeng{
    
    //初始化
    [UMConfigure initWithAppkey:UMKey channel:@"12"];

    //2,注册各个平台的AppKey和AppID
    /* 微信聊天 */
    BOOL WechatSession  =  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppKey appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    if (!WechatSession) {
        NSLog(@"setPlaform WechatSession  failed!");
    }
    
    /*QQ*/
    BOOL QQSession =  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppKey  appSecret:QQAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    if (!QQSession) {
        NSLog(@"setPlaform QQSession  failed!");
    }
    
    /*
     注**
     redirectURL必须要和微博设置的回调一致
     */
    /* 新浪 */
    BOOL SinaSession =  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppKey appSecret:SinaAppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    if (!SinaSession) {
        NSLog(@"setPlaform SinaSession  failed!");
    }
    
    
}







-(void)dealloc{
    
    
}

@end
