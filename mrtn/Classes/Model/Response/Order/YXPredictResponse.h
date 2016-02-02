//
//  预计上门时间响应
//
//  Created by Mac on 16/1/20.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@interface YXPredictResponse : JSONModel

@property (nonatomic,assign)BOOL success;// 是否成功
@property (nonatomic,strong)NSString<Optional> *msg;// 错误信息

@end
