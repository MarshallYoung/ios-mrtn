//
//  YXPredictListRequest.m
//  mrtn
//
//  Created by Mac on 16/2/3.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXPredictListRequest.h"

@implementation YXPredictListRequest

/**
 *  初始化方法
 *
 *  @param mcName    商户名称
 *  @param disptTime 上门时间
 *
 *  @return 请求
 */
+ (instancetype)requestWithName:(NSString *)mcName time:(NSString *)disptTime {
    
    YXPredictListRequest *request = [[YXPredictListRequest alloc] init];
    request.mcId       = @"";
    request.mcName     = mcName;
    request.disptTime  = disptTime;
    request.taskStatus = @"1";
    request.type       = @"3";
    return request;
    
}

@end
