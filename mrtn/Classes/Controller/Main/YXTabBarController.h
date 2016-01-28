//
//  主试图控制器
//
//  Created by Mac on 15/11/27.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXLoginInfo.h"

@interface YXTabBarController : UITabBarController

@property (nonatomic,strong)YXLoginInfo *loginInfo;// 登录信息
+ (instancetype)initWithLoginInfo:(YXLoginInfo *)loginInfo;// 用登录信息初始化

@end
