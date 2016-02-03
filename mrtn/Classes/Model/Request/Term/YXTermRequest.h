//
//  机具信息请求
//
//  Created by Mac on 16/2/3.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXRequest.h"

@interface YXTermRequest : YXRequest

/**
 *  SN号
 */
@property (nonatomic, strong) NSString *hostSerialNo;

/**
 *  初始化方法
 *
 *  @param hostSerialNo SN号
 *
 *  @return 请求
 */
+ (instancetype)requestWithSN:(NSString *)hostSerialNo;

@end
