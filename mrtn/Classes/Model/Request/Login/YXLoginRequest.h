//
//  登录请求
//
//  Created by Mac on 16/2/1.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

@interface YXLoginRequest : NSObject

/**
 *  用户名
 */
@property (strong, nonatomic) NSString  *name;
/**
 *  密码(加密前)
 */
@property (strong, nonatomic) NSString  *pwd;
/**
 *  得到登录请求
 *
 *  @param name 用户名
 *  @param pwd  密码(加密前)
 *
 *  @return 登录请求
 */
+ (instancetype)requestWithName:(NSString *)name password:(NSString *)pwd;

@end
