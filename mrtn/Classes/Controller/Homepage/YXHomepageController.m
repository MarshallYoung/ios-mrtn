//
//  主页
//
//  Created by Mac on 15/11/27.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXHomepageController.h"
#import "YXTabBarController.h"
#import "YXMerchantListController.h"
#import "YXScanViewController.h"
#import "YXOrderListController.h"
#import "YXControllerInfo.h"
#import "YXPredictController.h"
#import "YXLoginInfo.h"

#import "YXTestController.h"

@interface YXHomepageController ()

@property (strong, nonatomic) IBOutlet UILabel *userNameL;// 用户名
@property (strong, nonatomic) IBOutlet UILabel *instNameL;// 机构名称
- (IBAction)pushToQuery:(id)sender;// 打开查询界面
- (IBAction)pushToScan:(id)sender;// 打开扫描界面
- (IBAction)pushToBacklog:(id)sender;// 打开待办事项
- (IBAction)pushToProcessed:(id)sender;// 打开办结
- (IBAction)pushToPredict:(id)sender;// 预计上门时间
- (IBAction)test:(id)sender;// 测试
@property (strong, nonatomic) IBOutlet UIButton *testBtn;

@end


@implementation YXHomepageController {
    
    YXLoginInfo *loginInfo;// 登录信息
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = @"商户云服务";
    YXTabBarController *root = (YXTabBarController *)self.tabBarController;
    loginInfo = root.loginInfo;
    self.testBtn.hidden = YES;
    [self displayData];
    
}

// 显示数据
- (void)displayData {
    
    if (loginInfo) {
        YXLog(@"%@",loginInfo);
//        self.userNameL.text = loginInfo.userName;
//        self.instNameL.text = loginInfo.instName;
    }
    
}

- (IBAction)pushToQuery:(id)sender {
    
    YXMerchantListController *controller = [[YXMerchantListController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)pushToScan:(id)sender {
    
    YXScanViewController *controller = [[YXScanViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)pushToBacklog:(id)sender {
    
    YXOrderListController *controller = [[YXOrderListController alloc] init];
    controller.controllerInfo = [[YXControllerInfo alloc] init];
    controller.controllerInfo.mode = ORDER_BACKLOG;
    [self.navigationController pushViewController:controller animated:YES];
    
}
- (IBAction)pushToProcessed:(id)sender {
    
    YXOrderListController *controller = [[YXOrderListController alloc] init];
    controller.controllerInfo = [[YXControllerInfo alloc] init];
    controller.controllerInfo.mode = ORDER_PROCESSED;
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)pushToPredict:(id)sender {
    
    YXPredictController *controller = [[YXPredictController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
}

/**
 *  测试
 *
 *  @param sender 按钮
 */
- (IBAction)test:(id)sender {
    
    YXTestController *controller = [[YXTestController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
}


@end
