//
//  任务单详情
//
//  Created by Mac on 15/12/29.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXViewController.h"
#import "YXTaskOrderInfo.h"

@interface YXOrderDetailController : YXViewController

@property (nonatomic, strong) YXTaskOrderInfo *taskOrderInfo;// 任务单信息
@property (nonatomic, strong) UIImage         *signImage;// 签名
/**
 *  初始化方法
 *
 *  @param taskOrderInfo 任务单信息
 *
 *  @return 视图管理器
 */
+ (instancetype)initWithTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo;

@end
