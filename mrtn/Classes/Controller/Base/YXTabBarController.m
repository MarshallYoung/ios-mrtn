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
    
    YXHomepageController *homeVC = [[YXHomepageController alloc] init];// 首页
    [self addSubController:homeVC withTitle:@"主页" imageName:@"tabbar_home"];
    
    YXMessageViewController *msgVC = [[YXMessageViewController alloc] init];// 消息
    [self addSubController:msgVC withTitle:@"消息" imageName:@"tabbar_message_center_os7"];
    
    YXMoreViewController *moreVC = [[YXMoreViewController alloc] init];// 更多
    [self addSubController:moreVC withTitle:@"更多" imageName:@"tabbar_more"];
    
}

/**
 *  初始化子控制器
 *
 *  @param childController 子控制器
 *  @param title           子控制器标题
 *  @param imageName       选项图片
 */
- (void)addSubController:(UIViewController *)controller withTitle:(NSString *)title imageName:(NSString *)imageName {
    
    controller.title = title;// 设置Navigation和TabBar的标题
    controller.tabBarItem.image = [UIImage imageNamed:imageName];// 设置TabBar图片
    YXNavigationController *nav = [[YXNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];
    
}

/**
 *  初始化方法
 *
 *  @param loginInfo 登录信息
 *
 *  @return 选项试图控制器
 */
+ (instancetype)initWithLoginInfo:(YXLoginInfo *)loginInfo {
    
    YXTabBarController *controller = [[YXTabBarController alloc] init];
    controller.loginInfo = loginInfo;
    return controller;
    
}


@end
