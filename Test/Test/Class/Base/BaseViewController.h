//
//  BaseViewController.h
//  TestDemo
//
//  Created by 孙若淮 on 14/03/2018.
//  Copyright © 2018 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHNetAPIManager+Request.h"
#import "RHNetAPIManager.h"
#import "YMRefreshFooter.h"
#import "YMRefreshHeader.h"

#define YM_CELLIDENTIFIER(cell)  [NSString stringWithFormat:@"%@identify",[cell class]]

#define CELL_DEFINE(CellClass, ...)     \
CellClass *cell = [tableView dequeueReusableCellWithIdentifier:YM_CELLIDENTIFIER(CellClass)];   \
if (!cell) {            \
cell = [[CellClass alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:YM_CELLIDENTIFIER(CellClass)];  \
cell.selectionStyle = UITableViewCellSelectionStyleNone;    \
__VA_ARGS__                                                 \
}

#define CELL_DEFINE_Identifier(CellClass, identifier, ...)     \
CellClass *cell = [tableView dequeueReusableCellWithIdentifier:(identifier)];   \
if (!cell) {            \
cell = [[CellClass alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];  \
cell.selectionStyle = UITableViewCellSelectionStyleNone;    \
__VA_ARGS__                                                 \
}

#define CELL_DEFINE_Identifier_Name(CellClass, identifier, name, ...)     \
CellClass *name = [tableView dequeueReusableCellWithIdentifier:(identifier)];   \
if (!name) {            \
name = [[CellClass alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];  \
name.selectionStyle = UITableViewCellSelectionStyleNone;    \
__VA_ARGS__                                                 \
}

typedef void(^SuspendedBtnBlock)(UIButton *btn);
@interface BaseViewController : UIViewController
@property (nonatomic, strong) UIButton * suspendedBtn;

-(void)showSuspendedBtn:(SuspendedBtnBlock)block;

/**
 底部分享弹窗 block 分享按钮点击block
 */
-(void)sheetShareShowWithShanreBlock:(void(^)(NSString *btntitle)) block;

/**
 跳转到选择角色页面
 */
-(void)jumpSelectRole;

/**
 跳转到登录界面
 */
-(void)jumpToLogin;
/**
 跳转到填写企业认证页面
 */
-(void)jumpCompanyVerify;


@end
