//
//  待办事项,用于YXQueryOrderListController
//
//  Created by Mac on 15/12/28.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXOrderListInfo.h"

@interface YXBacklogCell : UITableViewCell

@property (nonatomic,strong)YXOrderListInfo *orderListInfo;// 待办事项
+ (instancetype)cellWithTableView:(UITableView *)tableView;// 初始化cell

@end
