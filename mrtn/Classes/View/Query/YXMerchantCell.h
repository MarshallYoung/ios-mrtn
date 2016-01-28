//
//  商户信息cell
//
//  Created by Mac on 15/12/7.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXMerchantInfo.h"

@interface YXMerchantCell : UITableViewCell

@property (nonatomic,strong)YXMerchantInfo *merchantInfo;// 商户信息
+ (instancetype)cellWithTableView:(UITableView *)tableView;// 初始化一个cell

@end
