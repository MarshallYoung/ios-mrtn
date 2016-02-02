//
//  任务单详细信息,用于YXOrderDetailController
//
//  Created by Mac on 15/12/29.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"
#import "YXTaskOrderInfo.h"

@interface YXQueryOrderDetailResponse : JSONModel

@property (nonatomic,assign)BOOL success;// 是否查询成功
@property (nonatomic,strong)NSString<Optional> *flag;
@property (nonatomic,strong)NSString<Optional> *msg;// 消息提示
@property (nonatomic,strong)YXTaskOrderInfo<Optional> *data;// 查询结果,非必须

@end
