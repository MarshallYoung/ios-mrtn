//
//  机具信息的相应
//
//  Created by Mac on 15/12/21.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"
#import "YXMachineInfo.h"

@interface YXQueryMachineResponse : JSONModel

@property (nonatomic,assign)BOOL success;// 是否查询成功
@property (nonatomic,strong)NSString<Optional> *msg;// 消息提示
@property (nonatomic,strong)NSMutableArray<YXMachineInfo,Optional> *data;// 查询结果,非必须

@end
