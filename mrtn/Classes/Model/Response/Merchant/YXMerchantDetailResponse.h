//
//  商户信息详情,用于MerchantDetailController
//
//  Created by Mac on 15/12/24.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"
#import "YXMerchantDetailInfo.h"

@interface YXMerchantDetailResponse : JSONModel

@property (nonatomic,assign) BOOL     success;// 是否查询成功
@property (nonatomic,strong) NSString<Optional> *msg;// 消息
@property (nonatomic,strong) NSString<Optional> *flag;
@property (nonatomic,strong)YXMerchantDetailInfo<Optional> *data;// 结果

@end
