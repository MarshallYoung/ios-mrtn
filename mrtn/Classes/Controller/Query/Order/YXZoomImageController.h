//
//  展示大图片
//
//  Created by Mac on 16/1/27.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXViewController.h"

@interface YXZoomImageController : YXViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;// 图片
@property (strong, nonatomic) NSString *fileName;// 图片的文件名
+ (instancetype)initWithFileName:(NSString *)fileName;// 以文件名初始化

@end
