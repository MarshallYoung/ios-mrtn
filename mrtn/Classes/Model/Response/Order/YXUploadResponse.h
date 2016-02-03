//
//  上传任务单响应
//
//  Created by Mac on 16/2/3.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@interface YXUploadResponse : JSONModel

@property (nonatomic, assign) BOOL     success;// 是否查询成功
@property (nonatomic, strong) NSString<Optional> *msg;// 消息

@end
