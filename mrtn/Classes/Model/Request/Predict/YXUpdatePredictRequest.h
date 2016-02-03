//
//  更新预计上门时间
//
//  Created by Mac on 16/2/3.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXRequest.h"

@interface YXUpdatePredictRequest : YXRequest

/**
 *  任务单编号
 */
@property (nonatomic, strong) NSString *taskId;
/**
 *  上门时间
 */
@property (nonatomic, strong) NSString *date;
/**
 *  任务单类型
 */
@property (nonatomic, strong) NSString *type;

/**
 *  初始化方法
 *
 *  @param taskId 任务单编号
 *  @param date   时间
 *
 *  @return 请求
 */
+ (instancetype)requestWithId:(NSString *)taskId date:(NSString *)date;

@end
