//
//  APP主视图控制器
//
//  Created by Mac on 15/11/27.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXTabBarController.h"
#import "YXNavigationController.h"
#import "YXHomepageController.h"
#import "YXMessageViewController.h"
#import "YXMoreViewController.h"

@implementation YXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YXHomepageController *homeVC = [[YXHomepageController alloc] initWithNibName:@"YXHomepageController" bundle:nil];// 首页
    [self addChildViewController:homeVC withTitle:@"主页" imageName:@"tabbar_home"];
    
    YXMessageViewController *msgVC = [[YXMessageViewController alloc] initWithNibName:@"YXMessageViewController" bundle:nil];// 消息
    [self addChildViewController:msgVC withTitle:@"消息" imageName:@"tabbar_message_center_os7"];
    
    YXMoreViewController *moreVC = [[YXMoreViewController alloc] initWithNibName:@"YXMoreViewController" bundle:nil];// 更多
    [self addChildViewController:moreVC withTitle:@"更多" imageName:@"tabbar_more"];
    
}

// 初始化主视图控制器的子控制器
- (void)addChildViewController:(UIViewController *)childController withTitle:(NSString *)title imageName:(NSString *)imageName {
    
    childController.title = title;// 设置Navigation和TabBar的标题
    childController.tabBarItem.image = [UIImage imageNamed:imageName];// 设置TabBar图片
    YXNavigationController *nav = [[YXNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
    
}

+ (instancetype)initWithLoginInfo:(YXLoginInfo *)loginInfo {
    
    YXTabBarController *controller = [[YXTabBarController alloc] init];
    controller.loginInfo = loginInfo;
    return controller;
    
}


@end
