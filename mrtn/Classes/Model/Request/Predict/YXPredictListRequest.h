//
//  预计上门时间列表请求
//
//  Created by Mac on 16/2/3.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXRequest.h"

@interface YXPredictListRequest : YXRequest

/**
 *  商户编号
 */
@property (nonatomic, strong) NSString *mcId;
/**
 *  商户名称
 */
@property (nonatomic, strong) NSString *mcName;
/**
 *  上门时间
 */
@property (nonatomic, strong) NSString *disptTime;
/**
 *  任务单状态
 */
@property (nonatomic, strong) NSString *taskStatus;
/**
 *  任务单类型
 */
@property (nonatomic, strong) NSString *type;

/**
 *  初始化方法
 *
 *  @param mcName    商户名称
 *  @param disptTime 上门时间
 *
 *  @return 请求
 */
+ (instancetype)requestWithName:(NSString *)mcName time:(NSString *)disptTime;

@end
