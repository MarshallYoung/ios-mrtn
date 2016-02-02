//
//  查询任务单列表响应
//
//  Created by Mac on 15/12/22.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"
#import "YXOrderListInfo.h"

@interface YXOrderListResponse : JSONModel

@property (nonatomic,assign) BOOL     success;// 是否查询成功
@property (nonatomic,strong) NSString<Optional> *msg;// 消息提示
@property (nonatomic,strong)NSMutableArray<YXOrderListInfo,Optional> *data;// 结果

@end
