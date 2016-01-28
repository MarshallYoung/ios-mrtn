//
//  展示大图片
//
//  Created by Mac on 16/1/27.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXZoomImageController.h"
#import "YXURLHelper.h"
#import "UIImageView+WebCache.h"

@interface YXZoomImageController ()

@end

@implementation YXZoomImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片";
    if (_fileName) {
        NSURL *url = [NSURL URLWithString:[URL_IMAGE stringByAppendingString:_fileName]];
        [_imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loading"]];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exit)];// 设置点击放大
    _imageView.userInteractionEnabled = YES;// 可以点击
    [_imageView addGestureRecognizer:tap];
    
}

+ (instancetype)initWithFileName:(NSString *)fileName {
    
    YXZoomImageController *controller = [[YXZoomImageController alloc] init];
    controller.fileName = fileName;
    return controller;
    
}

- (void)exit {
    
    
}


@end
