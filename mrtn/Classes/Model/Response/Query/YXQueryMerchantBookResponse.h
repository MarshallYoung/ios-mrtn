//
//  商户信息列表响应,用于YXQueryMcBookController
//
//  Created by Mac on 15/12/7.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"
#import "YXMerchantInfo.h"

@interface YXQueryMerchantBookResponse : JSONModel

@property (nonatomic,assign)int currPage;// 当前页
@property (nonatomic,assign)int totalCount;// 结果总数
@property (nonatomic,assign)int pageSize;// 每页显示数量
@property (nonatomic,assign)BOOL success;// 是否查询成功
@property (nonatomic,strong)NSString<Optional> *msg;// 消息提示
@property (nonatomic,strong)NSMutableArray<YXMerchantInfo,Optional> *data;// 查询结果,非必须


@end
