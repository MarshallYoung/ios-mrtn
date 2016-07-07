//
//  APP代理
//
//  Created by Mac on 15/11/6.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (YXNavigationController *)newLoginController;
@property (strong, nonatomic) NSString *sid;

@end
