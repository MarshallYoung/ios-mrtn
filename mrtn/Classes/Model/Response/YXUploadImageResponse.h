//
//  上传图片响应
//
//  Created by Mac on 16/1/13.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@interface YXUploadImageResponse : JSONModel

@property (nonatomic,strong)NSString *file_id;// 图片名
@property (nonatomic,strong)NSString *img_url;// 图片路径
@property (nonatomic,strong)NSString *success;// 结果 00是成功

@end
