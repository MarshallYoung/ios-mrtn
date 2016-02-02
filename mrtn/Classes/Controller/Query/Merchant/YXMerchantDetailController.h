//
//  商户详情
//
//  Created by Mac on 15/12/8.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXMerchantInfo.h"

@interface YXMerchantDetailController : UIViewController

/**
 *  商户信息
 */
@property (nonatomic,strong)YXMerchantInfo *merchantInfo;
/**
 *  初始化方法
 *
 *  @param merchantInfo 商户信息
 *
 *  @return 视图控制器
 */
+ (instancetype)initWithMerchantInfo:(YXMerchantInfo *)merchantInfo;

@end
