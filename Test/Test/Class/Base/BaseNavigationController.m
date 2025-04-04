//
//  BaseNavigationController.m
//  TestDemo
//
//  Created by 孙若淮 on 14/03/2018.
//  Copyright © 2018 Monster. All rights reserved.
//

#import "BaseNavigationController.h"
#import "RHNetAPIManager.h"
#import "RHNetAPIManager+Request.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 9.0, *)) {
        UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
        bar.barTintColor = COLOR_MAIN;
        bar.translucent = NO;
    } else {
        
    }
    
   
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont boldSystemFontOfSize:Size(15)],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
}

/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        
        viewController.hidesBottomBarWhenPushed = YES;
//        UIButton *btn = [UIButton ym_ButtonWithFrame:CGRectMake(0, 0, Size(40), Size(20)) title:@"" backgroundColor:nil titleColor:HEXRGBCOLOR(0xffffff) titleSize:Size(15)];
//        [btn setImage:[UIImage imageNamed:@"nav_right"] forState:UIControlStateNormal];
//        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [btn ym_layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:Size(8)];
//        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_right"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem = item;
    }
    [super pushViewController:viewController animated:animated];
    //解决iPhoneX push页面时tabbar上移问题
    if (IPHONEX) {
        
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = kScreenHeight - frame.size.height;
        self.tabBarController.tabBar.frame = frame;
    }
    
    
}
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    if (self.viewControllers.count == 1) {
        
        if (AppDelegateInstance.userType == 0) {//求职
            if (self.tabBarController.tabBar.hidden == NO){
                NSMutableDictionary *pageDic = [NSMutableDictionary dictionary];
                [pageDic setValue:@"1" forKey:@"currPage"];
                [pageDic setValue:@"10" forKey:@"pageSize"];
                
                NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
                [paramDic setValue:[pageDic mj_JSONString] forKey:@"page"];
                [paramDic setValue:AppDelegateInstance.token forKey:@"token"];
                
                [[RHNetAPIManager sharedManager]appSystemStationNewsOPT:paramDic].start(^(id data, NSString *msg, NSInteger code, NSError *error) {
                    if (data) {
                        if ([data[@"data"][@"status"] intValue] == 1) {
                            //self.tabBar.items[1].badgeValue = @"";
                            int i=0;
                            for (UIView *view in self.tabBarController.tabBar.subviews) {
                                i++;
                                //NSLog(@"%@",[view class]);
                                if (i == 3) {
                                    if (![view viewWithTag:119]) {
                                        UIView *n = [UIView new];
                                        n.backgroundColor = [UIColor redColor];
                                        n.width = 6;
                                        n.height = 6;
                                        n.top = Size(10);
                                        n.right = view.width- Size(23);
                                        n.tag = 119;
                                        n.layer.cornerRadius = 3;
                                        n.clipsToBounds = YES;
                                        [view addSubview:n];
                                    }
                                    
                                }
                            }
                            
                        }else{
                            int i=0;
                            for (UIView *view in self.tabBarController.tabBar.subviews) {
                                i++;
                                //NSLog(@"%@",[view class]);
                                if (i == 3) {
                                    if ([view viewWithTag:119]) {
                                        
                                        [[view viewWithTag:119] removeFromSuperview];
                                    }
                                    
                                }
                            }
                        }
                    }
                });
            }
        }
    }
    
    return vc;
}
- (void)back
{
    [self popViewControllerAnimated:YES];
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
