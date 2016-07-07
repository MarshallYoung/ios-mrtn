//
//  YXTestController.m
//  mrtn
//
//  Created by Mac on 16/2/25.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXTestController.h"
#import "YXAssessController.h"

@interface YXTestController ()

- (IBAction)test1:(id)sender;
- (IBAction)test2:(id)sender;
- (IBAction)test3:(id)sender;
- (IBAction)test4:(id)sender;
- (IBAction)test5:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *image;

@end

@implementation YXTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/**
 *  测试方法1
 *
 *  @param sender 按钮
 */
- (IBAction)test1:(id)sender {
    
    // 考核控制器
    YXAssessController *controller = [[YXAssessController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)test2:(id)sender {
    
    self.image.image = self.view.convertViewToImage;
    
//    GPUImageGaussianBlurFilter *filter = [[GPUImageGaussianBlurFilter alloc] init];
//    filter.blurRadiusInPixels = 2;
//    UIImage *image1 = [self.view convertViewToImage];
//    UIImage *image2 = [filter imageByFilteringImage:image1];
//    self.image.image = image2;
    
}

- (IBAction)test3:(id)sender {
}

- (IBAction)test4:(id)sender {
}

- (IBAction)test5:(id)sender {
}


@end
