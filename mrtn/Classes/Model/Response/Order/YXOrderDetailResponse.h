//
//  任务单详情响应
//
//  Created by Mac on 15/12/29.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"
#import "YXTaskOrderInfo.h"

@interface YXOrderDetailResponse : JSONModel

@property (nonatomic, assign) BOOL     success;// 是否查询成功
@property (nonatomic, strong) NSString<Optional> *msg;// 消息
@property (nonatomic, strong) NSString<Optional> *flag;
@property (nonatomic, strong) YXTaskOrderInfo<Optional> *data;// 结果

@end
