//
//  绑定机具信息响应
//
//  Created by Mac on 16/1/14.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@interface YXUploadScanResponse : JSONModel

@property (nonatomic,strong)NSString *success;// 是否成功
@property (nonatomic,strong)NSString<Optional> *msg;// 错误信息

@end
