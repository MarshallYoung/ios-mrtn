//
//  查询商户列表请求
//
//  Created by Mac on 16/2/2.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXMerchantListRequest.h"

@implementation YXMerchantListRequest

/**
 *  初始化方法
 *
 *  @param mcId   商户编号
 *  @param mcName 商户名称
 *
 *  @return 查询请求
 */
+(instancetype)requestWithId:(NSString *)mcId name:(NSString *)mcName {
    
    YXMerchantListRequest *request = [[YXMerchantListRequest alloc] init];
    request.currentPageNum = @"0";
    request.pageSize       = @"50";
    request.mcId           = mcId;
    request.mcName         = mcName;
    return request;
    
}


@end
