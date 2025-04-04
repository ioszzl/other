//
//  LoginViewController.m
//  TestDemo
//
//  Created by eims on 2018/6/21.
//  Copyright © 2018年 Monster. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "ForgetPasswordViewController.h"
#import "LoginModel.h"
#import "BindPhoneNumberViewController.h"
#import "MainTabBarController.h"
#import "UserModel.h"

#import <UMShare/UMSocialManager.h>
#import <UMShare/UMSocialResponse.h>
#import "AppDelegate+ThirdConfig.h"
#import "AFNetworking.h"

#define WIDTHRADIUS                                   kScreenWidth/414.0
//#define HEIGHTRADIUS                                  SCREEN_HEIGHT/736.0
#define WIDTHRADIU                                    kScreenWidth/375.0
//#define HEIGHTRADIUS                                  SCREEN_HEIGHT/667.0

@interface LoginViewController ()<UITextFieldDelegate>
{
    NSString *_headImgUrl;
}
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *psdTF;
@property (nonatomic, strong) UIImageView *headImgV;

@property (nonatomic, strong) NSDictionary *thirdBindDic;

@property (nonatomic, strong) LoginModel *loginModel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    // 重置 变为不透明
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
   
}


-(void)initUI{
    self.view.backgroundColor = RGBCOLOR(255, 255, 255);
    UIScrollView *bgScrollV = [[UIScrollView alloc]init];
    [self.view addSubview:bgScrollV];
    if (@available(iOS 11.0, *)) {
        bgScrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    bgScrollV.showsVerticalScrollIndicator = NO;
    [bgScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_offset(0);
    }];
    
    NSString *imageName;
    if (AppDelegateInstance.userType == 1) {
        imageName = @"Theloginbackground1";
    } else {
        imageName = @"Theloginbackground";
    }
    UIImageView *topImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    topImgV.contentMode = UIViewContentModeScaleToFill;
    [bgScrollV addSubview:topImgV];
    [topImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kNavBarHeight+Size(328/2));
    }];
    
    _headImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"头像"]];
    _headImgV.layer.cornerRadius = Size(204/4);
    _headImgV.clipsToBounds = YES;
    [bgScrollV addSubview:_headImgV];
    [_headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgScrollV);
        make.height.width.mas_equalTo(Size(204/2));
        make.top.mas_offset(kNavBarHeight + Size(22/2));
    }];
    
//手机号
    UIView * phoneBgV = [UIView new];
    phoneBgV.layer.borderColor = RGBACOLOR(153, 153, 153, 0.75).CGColor;
    phoneBgV.layer.borderWidth = 0.5;
    [bgScrollV addSubview:phoneBgV];
    [phoneBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImgV.mas_bottom).mas_offset(Size(40));
        make.left.mas_offset(Size(67/2));
        make.height.mas_equalTo(Size(88/2));
        make.width.mas_equalTo(Size(616/2));
    }];
    
    UIImageView *phoneIconV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Mobilephonenumber"]];
    phoneIconV.contentMode = UIViewContentModeScaleAspectFit;
    [phoneBgV addSubview:phoneIconV];
    [phoneIconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneBgV);
        make.height.mas_equalTo(Size(38/2));
        make.width.mas_equalTo(Size(28/2));
        make.left.mas_offset(Size(26/2));
    }];
    
    UIView *phoneLine = [UIView new];
    phoneLine.backgroundColor = RGBACOLOR(153, 153, 153, 0.75);
    [phoneBgV addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.5);
        make.centerY.equalTo(phoneBgV);
        make.height.mas_equalTo(Size(54/2));
        make.left.equalTo(phoneIconV.mas_right).mas_offset(Size(10));
    }];
    
    self.phoneTF = [UITextField ym_textFieldWithFrame:CGRectZero placeholder:@"手机号码" font:Size(15) textColor:COLOR_RGB_51 tag:0];
    self.phoneTF.delegate = self;
    [phoneBgV addSubview:self.phoneTF];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLine.mas_right).mas_offset(Size(11));
        make.top.bottom.right.mas_offset(0);
    }];
    [self.phoneTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
//密码
    UIView * psdBgV = [UIView new];
    psdBgV.layer.borderColor = RGBACOLOR(153, 153, 153, 0.75).CGColor;
    psdBgV.layer.borderWidth = 0.5;
    [bgScrollV addSubview:psdBgV];
    [psdBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneBgV.mas_bottom).mas_offset(Size(15));
        make.left.mas_offset(Size(67/2));
        make.height.mas_equalTo(Size(88/2));
        make.width.mas_equalTo(Size(616/2));
    }];
    
    UIImageView *psdIconV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Pleaseenterpassword"]];
    psdIconV.contentMode = UIViewContentModeScaleAspectFit;
    [psdBgV addSubview:psdIconV];
    [psdIconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(psdBgV);
        make.height.mas_equalTo(Size(38/2));
        make.width.mas_equalTo(Size(28/2));
        make.left.mas_offset(Size(26/2));
    }];
    
    UIView *psdLine = [UIView new];
    psdLine.backgroundColor = RGBACOLOR(153, 153, 153, 0.75);
    [psdBgV addSubview:psdLine];
    [psdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.5);
        make.centerY.equalTo(psdBgV);
        make.height.mas_equalTo(Size(54/2));
        make.left.equalTo(psdIconV.mas_right).mas_offset(Size(10));
    }];
    
    self.psdTF = [UITextField ym_textFieldWithFrame:CGRectZero placeholder:@"请输入密码" font:Size(15) textColor:COLOR_RGB_51 tag:0];
    self.psdTF.secureTextEntry = YES;
    self.psdTF.delegate = self;
    [psdBgV addSubview:self.psdTF];
    [self.psdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psdLine.mas_right).mas_offset(Size(11));
        make.top.bottom.right.mas_offset(0);
    }];
    
    UIButton *forgetBtn = [UIButton ym_ButtonWithFrame:CGRectZero title:@"忘记密码?" backgroundColor:nil titleColor:COLOR_MAIN titleSize:Size(14)];
    [bgScrollV addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-Size(66/2));
        make.top.equalTo(psdBgV.mas_bottom).mas_offset(Size(35/2));
    }];
    [forgetBtn addTarget:self action:@selector(doForgetBtn) forControlEvents:UIControlEventTouchUpInside];
    
//登录btn
    UIButton *loginBtn = [UIButton ym_ButtonWithFrame:CGRectZero title:@"登录" backgroundColor:COLOR_MAIN titleColor:COLOR_RGB_51 titleSize:Size(17)];
    loginBtn.layer.cornerRadius = Size(98/4);
    [bgScrollV addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(psdBgV.mas_bottom).mas_offset(Size(100/2));
        make.height.mas_equalTo(Size(98/2));
        make.width.mas_equalTo(Size(616/2));
        make.centerX.equalTo(bgScrollV);
    }];
    [loginBtn addTarget:self action:@selector(doLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *registBtn = [UIButton ym_ButtonWithFrame:CGRectZero title:@"注册账号" backgroundColor:nil titleColor:COLOR_MAIN titleSize:Size(14)];
    [bgScrollV addSubview:registBtn];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).mas_offset(Size(20));
        make.centerX.equalTo(bgScrollV);
    }];
    [registBtn addTarget:self action:@selector(doRegistBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *otherLoginLab = [UILabel ym_labelWithFrame:CGRectZero font:FONT_SIZE_12 textColor:COLOR_RGB_153];
    otherLoginLab.text = @"第三方登录";
    [bgScrollV addSubview:otherLoginLab];
    [otherLoginLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(registBtn.mas_bottom).mas_offset(Size(74/2));
        make.centerX.equalTo(bgScrollV);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = RGBACOLOR(153, 153, 153, 0.75);
    [bgScrollV addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(otherLoginLab.mas_left).mas_offset(-Size(12));
        make.height.mas_equalTo(.5);
        make.left.mas_equalTo(Size(92/2));
        make.centerY.equalTo(otherLoginLab);
    }];

    UIView *line2 = [UIView new];
    line2.backgroundColor = RGBACOLOR(153, 153, 153, 0.75);
    [bgScrollV addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(otherLoginLab.mas_right).mas_offset(Size(12));
        make.height.mas_equalTo(.5);
        make.right.mas_equalTo(-Size(92/2));
        make.centerY.equalTo(otherLoginLab);
    }];
    
    
    CGFloat leftMargin = Size(30);
    CGFloat spaceH = ( kScreenWidth - 2 * leftMargin -  4 * Size(50) ) / 3.0;
    UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wxBtn setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    wxBtn.tag = 1001;
    [bgScrollV addSubview:wxBtn];
    [wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(Size(50));
        make.top.equalTo(otherLoginLab.mas_bottom).mas_offset(Size(25));
        make.left.mas_equalTo(leftMargin);
    }];
    [wxBtn addTarget:self action:@selector(doOtherLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *wbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wbBtn setImage:[UIImage imageNamed:@"微博"] forState:UIControlStateNormal];
    wbBtn.tag = 1002;
    [bgScrollV addSubview:wbBtn];
    [wbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(Size(50));
        make.top.equalTo(otherLoginLab.mas_bottom).mas_offset(Size(25));
        make.left.equalTo(wxBtn.mas_right).mas_offset(spaceH);
    }];
    [wbBtn addTarget:self action:@selector(doOtherLogin:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqBtn setImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
    qqBtn.tag = 1003;
    [bgScrollV addSubview:qqBtn];
    [qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(Size(50));
        make.top.equalTo(otherLoginLab.mas_bottom).mas_offset(Size(25));
        make.left.equalTo(wbBtn.mas_right).mas_offset(spaceH);
    }];
    [qqBtn addTarget:self action:@selector(doOtherLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    //闪验
    UIButton *shanYanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shanYanBtn setImage:[UIImage imageNamed:@"shanyan"] forState:UIControlStateNormal];
    shanYanBtn.tag = 1004;
    [bgScrollV addSubview:shanYanBtn];
    [shanYanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(Size(50));
        make.top.equalTo(otherLoginLab.mas_bottom).mas_offset(Size(25));
        make.left.equalTo(qqBtn.mas_right).mas_offset(spaceH);
    }];
    [shanYanBtn addTarget:self action:@selector(doOtherLogin:) forControlEvents:UIControlEventTouchUpInside];

    
    
    [bgScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(qqBtn.mas_bottom);
        make.right.mas_offset(0);
    }];
    
//    self.phoneTF.text = @"13149939733";
//    self.psdTF.text = @"123456";
//    self.phoneTF.text = @"13632386061";
//    self.psdTF.text = @"123456abc";
}
#pragma mark - action
-(void)doLoginBtn{
    [self.view endEditing:YES];
    
    if (self.phoneTF.text.length == 0) {
        [HUD showHUDError:nil title:@"请输入手机号"];
        return;
    }
    if (![NSString ym_validateMobile:self.phoneTF.text]){
        [HUD showHUDError:nil title:@"请输入正确手机号"];
        return;
    }
    if (self.psdTF.text.length == 0) {
        [HUD showHUDError:nil title:@"请输入密码"];
        return;
    }
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:self.phoneTF.text forKey:@"phone"];
    [dataDic setValue:self.psdTF.text forKey:@"pwd"];
    
    [dataDic setValue:@"0" forKey:@"type"];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:[dataDic mj_JSONString] forKey:@"data"];
    
    [[RHNetAPIManager sharedManager]appLoginOPT:paramDic].start(^(id data, NSString *msg, NSInteger code, NSError *error) {
        if (data) {
            
            [self jobhHunterLoginSaveData:data];
        }
    });
        
        
    

    
    
}

//求职者登录保存信息
- (void)jobhHunterLoginSaveData:(NSDictionary *)data{
    
    AppDelegateInstance.token = [data[@"data"] objectForKey:@"token"];
    DefaultsSetObject([data[@"data"] objectForKey:@"token"], KEY_TOKEN);
    DefaultsSetInteger(0, KEY_USER_TYPE);
    
    UserModel *userM = [[UserModel alloc]init];
    userM.phone = self.phoneTF.text;
    userM.userId = [[data[@"data"] objectForKey:@"userId"] stringValue];
    AppDelegateInstance.userModel = userM;
    DefaultsSetObject([userM mj_JSONString], KEY_USER_DATA);
    
    if ([AppDelegateInstance.window.rootViewController isKindOfClass:[MainTabBarController class]]) {
        [self dismissViewControllerAnimated:NO completion:^{
            MainTabBarController *vc = [MainTabBarController new];
            AppDelegateInstance.window.rootViewController = vc;
        }];
    }else{
        
        MainTabBarController *vc = [MainTabBarController new];
        AppDelegateInstance.window.rootViewController = vc;
    }
    
    //IM登录
    [AppDelegateInstance loginIM];
    
        //MainTabBarController *oldVc = (MainTabBarController *)AppDelegateInstance.window.rootViewController;
        
        //                MainTabBarController *vc = [MainTabBarController new];
        //                AppDelegateInstance.window.rootViewController = vc;
        
        //oldVc = nil;
        

}
-(void)doForgetBtn{
    [self.navigationController pushViewController:[ForgetPasswordViewController new] animated:YES];
}

-(void)doRegistBtn{
    [self.navigationController pushViewController:[RegistViewController new] animated:YES];
}
-(void)doOtherLogin:(UIButton *)btn{
    
    switch (btn.tag - 1001) {
        case 0://微信登录
        {
//            BOOL isInstall = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession];
//            if (!isInstall) {
//                [HUD showHUDError:nil title:@"请先安装微信"];
//                return ;
//            }
            [self getUserInfoFromUmengPlatform:UMSocialPlatformType_WechatSession status:@"3"];
            
        }
            break;
        case 1://新浪登录
        {
//            BOOL isInstall = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina];
//            if (!isInstall) {
//                [HUD showHUDError:nil title:@"请先安装新浪"];
//                return ;
//            }
            
            [self getUserInfoFromUmengPlatform:UMSocialPlatformType_Sina status:@"1"];
            
        }
            break;
        case 2://QQ登录
        {
//            BOOL isInstall = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ];
//            if (!isInstall) {
//                [HUD showHUDError:nil title:@"请先安装QQ"];
//                return ;
//            }
            [self getUserInfoFromUmengPlatform:UMSocialPlatformType_QQ status:@"2"];
        }
            break;
        default:
            break;
    }
}


//移动授权页 点击其他方式登录
-(void)otherLoginWayBtnClicedCMCC:(UIButton *)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController.viewControllers.lastObject dismissViewControllerAnimated:YES completion:nil];
    });
    
}

-(void)otherLoginWayBtnClicedCUCC:(UIButton *)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController.viewControllers.lastObject dismissViewControllerAnimated:YES completion:nil];
    });
    
}


#pragma  mark -- 获取新浪QQ或微信平台用户信息
- (void)getUserInfoFromUmengPlatform:(UMSocialPlatformType)platformType status:(NSString *)status{
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"----%@---",error);
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            
            [self loginWithOpenId:[NSString stringWithFormat:@"%@",resp.openid] status:status];
            
            
            self.thirdBindDic = @{@"oppenId":resp.openid,
                            @"type":NSStringFromInteger(AppDelegateInstance.userType),
                                  @"headimgurl":resp.iconurl,
                                  @"nickname":resp.name,
                                  @"status":status
                                  };
            
        }
    }];

}
- (void)loginWithOpenId:(NSString *)openId status:(NSString *)status{
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:openId forKey:@"openId"];
    [dic setValue:status forKey:@"status"];//登录标识,1:微博登录,2:qq登录,3:微信登录
    [dic setValue:NSStringFromInteger(AppDelegateInstance.userType) forKey:@"type"];//0求职端,1企业端

    [paramDic setValue:[dic mj_JSONString] forKey:@"data"];
    
    [[RHNetAPIManager sharedManager]appThirdLoginWithOPT:paramDic].start(^(id data, NSString *msg, NSInteger code, NSError *error) {
        if (data) {
            NSInteger userType = AppDelegateInstance.userType;
            
              if(userType == 0){
                  
                  [self jobhHunterLoginSaveData:data];
                  
              }
            
        }else{
            if (code == 8888) {//账号未绑定,跳转登录页绑定
                BindPhoneNumberViewController *vc = [BindPhoneNumberViewController new];
                vc.thirdBindDic = self.thirdBindDic;
                vc.bindSuccessBlock = ^(NSDictionary * _Nonnull dic, NSString * _Nonnull msg, NSInteger dcode) {
                  
                    NSInteger userType = AppDelegateInstance.userType;
                    
                    if(userType == 0){
                        
                        [self jobhHunterLoginSaveData:dic];
                        
                    }
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    });

}

#pragma mark - textField delegate
-(void)textFieldChanged:(UITextField *)textField{
    if (textField == self.phoneTF) {
        if (textField.text.length == 11) {
            if ([NSString ym_validateMobile:textField.text]){
                NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
                [dataDic setValue:textField.text forKey:@"phone"];
                
                NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
                [paramDic setValue:[dataDic mj_JSONString] forKey:@"data"];
                
                [[RHNetAPIManager sharedManager]appGetHeadPicByPhoneOPT:paramDic].start(^(id data, NSString *msg, NSInteger code, NSError *error) {
                    if (data) {
                        if (![data[@"data"] isKindOfClass:[NSNull class]]) {
                            _headImgUrl = data[@"data"];
                            
                            [self.headImgV sd_setImageWithURL:[NSURL URLWithString:data[@"data"]] placeholderImage:[UIImage imageNamed:@"头像"]];
                        }
                    }
                    
                });
            }else{
                [HUD showHUDError:nil title:@"请输入正确手机号"];
            }
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
