//
//  商户详情
//
//  Created by Mac on 15/12/8.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXMerchantInfo.h"

@interface YXMerchantDetailController : UIViewController

@property (nonatomic,strong)YXMerchantInfo *merchantInfo;// 商户信息
+ (instancetype)initWithMerchantInfo:(YXMerchantInfo *)merchantInfo;// 通过商户信息初始化

@end
