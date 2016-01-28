//
//  登录
//
//  Created by Mac on 15/11/11.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXLoginController.h"
#import "AppDelegate.h"
#import "YXTabBarController.h"
#import "YXEncryptHelper.h" // 加密工具
#import "YXURLHelper.h"
#import "MBProgressHUD+Extension.h"
#import "YXLoginResponse.h"

@interface YXLoginController ()<UITextFieldDelegate,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameF;// 用户名
@property (weak, nonatomic) IBOutlet UITextField *pwdF;// 密码
- (IBAction)login:(id)sender;// 登录

@end


@implementation YXLoginController{

    MBProgressHUD *progress;// 提示
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商户云服务";
    
}

// 登录
- (IBAction)login:(id)sender {
    
    [self.view endEditing:YES];// 关闭虚拟键盘
    NSString *name = self.nameF.text;
    NSString *pwd = self.pwdF.text;
    if ([name isEmpty]) { // 用户名为空
        [MBProgressHUD showFail:@"请输入用户名"];
        return;
    }
    if ([pwd isEmpty]) { // 密码为空
        [MBProgressHUD showFail:@"请输入密码"];
        return;
    }
    // 显示读取框
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];;
    progress.delegate = self;// 设置代理,用于移除
    progress.labelText = @"登录中...";// 设置文本
    [self.view addSubview:progress];// 显示
    // 发送请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;// 设置超时时间
    NSDictionary *parameters = @{@"name":name ,@"pwd":[YXEncryptHelper md5HexDigest:pwd]};// 设置参数
    [manager POST:URL_LOGIN parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [progress hide:YES];// 隐藏读取框
        YXLoginResponse *rsp = [[YXLoginResponse alloc] initWithDictionary:responseObject error:nil];
        if (rsp.success) {// 登录成功
            [self enterWithInfo:rsp.data];
        }else {// 登录失败
            [MBProgressHUD showFail:rsp.msg];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD showFail:@"服务器无响应,请联系服务人员"];
    }];
    
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

//  清空用户名密码,进入主界面
- (void) enterWithInfo:(YXLoginInfo *)loginInfo {
    
    YXTabBarController *controller = [YXTabBarController initWithLoginInfo:loginInfo];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.window.rootViewController = controller;
    
}


@end
