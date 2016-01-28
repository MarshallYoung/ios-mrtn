//
//  导航控制器
//
//  Created by Mac on 15/11/23.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXNavigationController.h"
#import "YXLoginController.h"

@implementation YXNavigationController

// 第一次使用类时候调用
+ (void)initialize {
    
    [self setNavigationTheme];
    [self setBarItemTheme];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 让NavigationController的子视图布局时直接从导航栏下面开始,而不是导航栏顶部
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor blackColor];// 设置背景颜色
    
}

// 场景切换执行动画
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        // 子视图控制器的数目大于0说明不是根视图控制器,在新视图控制器隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

// 设置导航栏主题
+ (void)setNavigationTheme {
    
    UINavigationBar *appearance = [UINavigationBar appearance];// 得到当前主题
    [appearance setTintColor:[UIColor whiteColor]];// 返回箭头为白色
    [appearance setBackgroundImage:[UIImage imageNamed:@"The headline1"] forBarMetrics:UIBarMetricsDefault];// 导航栏背景
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];// 导航栏文字为白色
    [appearance setTitleTextAttributes:textAttr];
    
}

// 设置导航按钮主题
+ (void)setBarItemTheme {
    
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];// 导航栏文字颜色
    [appearance setTitleTextAttributes:textAttr forState:UIControlStateNormal];

}

// 设置状态栏风格
-(UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;// 返回白色状态栏
    
}


@end
