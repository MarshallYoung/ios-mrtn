//
//  待办任务单详情,用于QueryOrderListDetailController
//
//  Created by Mac on 15/12/29.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXTaskOrderInfo.h"

@interface YXTaskOrderCell : UITableViewCell

@property (nonatomic,strong)YXTaskOrderInfo *taskOrderInfo;// 任务单
+ (instancetype)cellWithTableView:(UITableView *)tableView;// 初始化cell

@end
