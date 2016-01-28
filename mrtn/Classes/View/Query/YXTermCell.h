//
//  绑定的机具信息Cell用于YXMerchantDetailController
//
//  Created by Mac on 15/12/28.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXTermInfo.h"

@interface YXTermCell : UIView

@property (nonatomic,strong)YXTermInfo *termInfo;// 机具信息
+ (instancetype)initWithTermInfo:(YXTermInfo *)termInfo;// 初始化cell

@end
