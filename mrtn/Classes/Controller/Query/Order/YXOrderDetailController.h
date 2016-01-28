//
//  任务单详情
//  上级是YXOrderListDetailController
//
//  Created by Mac on 15/12/29.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXViewController.h"
#import "YXTaskOrderInfo.h"

@interface YXOrderDetailController : YXViewController

@property (nonatomic,strong)YXTaskOrderInfo *taskOrderInfo;// 任务单信息
+ (instancetype)initWithTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo;// 通过任务单信息初始化
@property (strong, nonatomic) UIImage *signImage;// 签名

@end
