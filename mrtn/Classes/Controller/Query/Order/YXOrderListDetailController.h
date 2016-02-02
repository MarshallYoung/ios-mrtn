//
//  任务单列表详情
//
//  Created by Mac on 15/12/23.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXOrderListInfo.h"
#import "YXControllerInfo.h"

@interface YXOrderListDetailController : UIViewController

@property (nonatomic, strong) YXControllerInfo *controllerInfo;// 视图控制器信息
@property (nonatomic, strong) YXOrderListInfo  *orderInfo;// 任务单信息
/**
 *  初始化方法
 *
 *  @param orderInfo 任务单信息
 *
 *  @return 视图控制器
 */
+ (instancetype)initWithOrderListInfo:(YXOrderListInfo *)orderInfo;


@end
