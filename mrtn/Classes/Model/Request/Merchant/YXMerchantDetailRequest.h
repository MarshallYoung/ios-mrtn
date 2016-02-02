//
//  查询商户详情请求
//
//  Created by Mac on 16/2/2.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXRequest.h"

@interface YXMerchantDetailRequest : YXRequest

/**
 *  商户id
 */
@property (nonatomic, strong, getter = theId) NSString *id;
/**
 *  初始化方法
 *
 *  @param theId 商户id
 *
 *  @return 查询请求
 */
+ (instancetype)requestWithId:(NSString *)theId;

@end
