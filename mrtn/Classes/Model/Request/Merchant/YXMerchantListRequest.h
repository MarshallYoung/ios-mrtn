//
//  查询商户列表请求
//
//  Created by Mac on 16/2/2.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXRequest.h"

@interface YXMerchantListRequest : YXRequest

/**
 *  商户编号
 */
@property (strong, nonatomic) NSString  *mcId;
/**
 *  商户名称
 */
@property (strong, nonatomic) NSString  *mcName;
/**
 *  当前页
 */
@property (strong, nonatomic) NSString  *currentPageNum;
/**
 *  每页容量
 */
@property (strong, nonatomic) NSString  *pageSize;
/**
 *  初始化方法
 *
 *  @param mcId   商户编号
 *  @param mcName 商户名称
 *
 *  @return 查询请求
 */
+ (instancetype)requestWithId:(NSString *)mcId name:(NSString *)mcName;

@end
