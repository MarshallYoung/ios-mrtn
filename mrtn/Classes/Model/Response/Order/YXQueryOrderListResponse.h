//
//  查询任务单响应
//
//  Created by Mac on 15/12/22.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"
#import "YXOrderListInfo.h"

@interface YXQueryOrderListResponse : JSONModel

@property (nonatomic,assign)BOOL success;// 是否查询成功
@property (nonatomic,strong)NSString<Optional> *msg;// 消息提示
@property (nonatomic,strong)NSMutableArray<YXOrderListInfo,Optional> *data;// 查询结果,非必须

@end
