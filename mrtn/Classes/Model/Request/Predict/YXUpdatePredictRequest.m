//
//  YXUpdatePredictRequest.m
//  mrtn
//
//  Created by Mac on 16/2/3.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXUpdatePredictRequest.h"

@implementation YXUpdatePredictRequest

/**
 *  初始化方法
 *
 *  @param taskId 任务单编号
 *  @param date   时间
 *
 *  @return 请求
 */
+ (instancetype)requestWithId:(NSString *)taskId date:(NSString *)date {
    
    YXUpdatePredictRequest *request = [[YXUpdatePredictRequest alloc] init];
    request.taskId = taskId;
    request.date   = date;
    request.type   = @"3";
    return request;
    
}

@end
