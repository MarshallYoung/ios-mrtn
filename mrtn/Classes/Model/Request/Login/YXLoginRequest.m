//
//  登录请求
//
//  Created by Mac on 16/2/1.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXLoginRequest.h"

@implementation YXLoginRequest

/**
 *  得到登录请求
 *
 *  @param name 用户名
 *  @param pwd  密码(加密前)
 *
 *  @return 登录请求
 */
+ (instancetype)requestWithName:(NSString *)name password:(NSString *)pwd {
  
    YXLoginRequest *request = [[YXLoginRequest alloc] init];
    request.name = name;
    request.pwd  = pwd;
    return request;
    
}


@end
