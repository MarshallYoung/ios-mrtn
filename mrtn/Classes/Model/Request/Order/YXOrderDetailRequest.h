//
//  任务单详情
//
//  Created by Mac on 16/2/2.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXRequest.h"

@interface YXOrderDetailRequest : YXRequest

/**
 *  任务单编号
 */
@property (nonatomic, strong, getter = theId) NSString *id;
/**
 *  初始化方法
 *
 *  @param theId 任务单编号
 *
 *  @return 请求
 */
+ (instancetype)initWithId:(NSString *)theId;

@end
