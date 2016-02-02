//
//  主试图控制器
//
//  Created by Mac on 15/11/27.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXLoginInfo.h"

@interface YXTabBarController : UITabBarController

@property (nonatomic,strong)YXLoginInfo *loginInfo;// 登录信息
/**
 *  初始化方法
 *
 *  @param loginInfo 登录信息
 *
 *  @return 选项试图控制器
 */
+ (instancetype)initWithLoginInfo:(YXLoginInfo *)loginInfo;

@end
