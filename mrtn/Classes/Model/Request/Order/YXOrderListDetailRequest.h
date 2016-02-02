//
//  任务单列表详情
//
//  Created by Mac on 16/2/2.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXRequest.h"

@interface YXOrderListDetailRequest : YXRequest

/**
 *  商户编号
 */
@property (nonatomic, strong) NSString *mcId;
/**
 *  商户名称
 */
@property (nonatomic, strong) NSString *mcName;
/**
 *  派工时间
 */
@property (nonatomic, strong) NSString *disptTime;
/**
 *  任务状态
 */
@property (nonatomic, strong) NSString *taskStatus;
/**
 *  机构编号
 */
@property (nonatomic, strong) NSString *instId;
/**
 *  用户编号
 */
@property (nonatomic, strong) NSString *UserId;

@end
