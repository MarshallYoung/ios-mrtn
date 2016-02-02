//
//  登录
//
//  Created by Mac on 15/11/11.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXLoginController.h"
#import "YXNetworkingManager.h"
#import "AppDelegate.h"
#import "YXTabBarController.h"
#import "MBProgressHUD+Extension.h"

@interface YXLoginController ()<UITextFieldDelegate,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameF;// 用户名
@property (weak, nonatomic) IBOutlet UITextField *pwdF;// 密码
- (IBAction)login:(id)sender;// 登录

@end


@implementation YXLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商户云服务";
    
}

- (IBAction)login:(id)sender {
    
    [self.view endEditing:YES];// 关闭虚拟键盘
    NSString *name = self.nameF.text;
    NSString *pwd  = self.pwdF.text;
    if ([name isEmpty]) {// 用户名为空
        [MBProgressHUD showFail:@"请输入用户名"];
        return;
    }
    if ([pwd isEmpty]) {// 密码为空
        [MBProgressHUD showFail:@"请输入密码"];
        return;
    }
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self text:@"登录中..."];;// 登录读取框
    YXLoginRequest *request = [YXLoginRequest requestWithName:name password:pwd];// 得到请求
    [YXNetworkingManager loginWithRequest:request success:^(YXLoginResponse *response) {// 请求成功
        [progress hide:YES];// 隐藏读取框
        if (response.success) {// 登录成功
            YXLoginInfo *loginInfo = response.data;// 得到登录信息
            [self enterWithInfo:loginInfo];
        } else {// 登录失败
            [MBProgressHUD showFail:response.msg];
        }
    } failure:^(void) {
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD show408];
    }];
    
}

/**
 *  进入主界面
 *
 *  @param loginInfo 登录信息
 */
- (void) enterWithInfo:(YXLoginInfo *)loginInfo {
    
    YXTabBarController *controller = [YXTabBarController initWithLoginInfo:loginInfo];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.window.rootViewController = controller;
    
}

#pragma mark TextField代理方法,点击return
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if(textField == self.nameF) {// 光标在用户名
        [self.pwdF becomeFirstResponder];// 移动到密码
    }else if(textField == self.pwdF) {// 光标在密码
        [self login:nil];
    };
    return YES;
    
}


@end
