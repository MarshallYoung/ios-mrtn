//
//  上传图片响应
//
//  Created by Mac on 16/1/13.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@interface YXUploadImageResponse : JSONModel

/**
 *  是否上传成功(成功返回00)
 */
@property (nonatomic,strong)NSString *success;
/**
 *  图片名
 */
@property (nonatomic,strong)NSString *file_id;
/**
 *  图片网络地址
 */
@property (nonatomic,strong)NSString *img_url;

@end
