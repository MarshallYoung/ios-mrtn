//
//  YXMachineRequest.m
//  mrtn
//
//  Created by Mac on 16/2/3.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXTermRequest.h"

@implementation YXTermRequest

/**
 *  初始化方法
 *
 *  @param hostSerialNo SN号
 *
 *  @return 请求
 */
+ (instancetype)requestWithSN:(NSString *)hostSerialNo {
    
    YXTermRequest *request = [[YXTermRequest alloc] init];
    request.hostSerialNo = hostSerialNo;
    return request;
    
}

@end
