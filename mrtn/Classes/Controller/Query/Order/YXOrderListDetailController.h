//
//  任务单列表详情,上级是YXOrderListController
//
//  Created by Mac on 15/12/23.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXOrderListInfo.h"
#import "YXControllerInfo.h"

@interface YXOrderListDetailController : UIViewController

@property (nonatomic,strong)YXControllerInfo *controllerInfo;// 视图控制器信息
@property (nonatomic,strong)YXOrderListInfo *orderInfo;// 任务单信息
+ (instancetype)initWithOrderListInfo:(YXOrderListInfo *)orderInfo;// 通过任务单信息初始化

@end
