//
//  网络管理
//
//  Created by Mac on 15/12/21.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXRequest.h"
#import "YXResponse.h"
#import "YXLoginRequest.h"
#import "YXLoginResponse.h"

@interface YXNetworkingManager : NSObject

/**
 *  登录
 *
 *  @param request 登录请求
 *  @param success 登录成功执行方法
 *  @param failure 登录失败执行方法
 */
+ (void)loginWithRequest:(YXLoginRequest *)request success:(void(^)(YXLoginResponse *response))success failure:(void(^)(void))failure;
/**
 *  查询
 *
 *  @param request 查询请求
 *  @param success 查询成功执行方法
 *  @param failure 查询失败执行方法
 */
+ (void)queryWithRequest:(YXRequest *)request success:(void(^)(id responseObject))success failure:(void(^)(void))failure;

@end
