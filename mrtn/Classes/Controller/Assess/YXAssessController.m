//
//  YXAssessController.m
//  mrtn
//
//  Created by Mac on 16/2/18.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXAssessController.h"
#import "YXBusinessRepresentativeFragment.h"

@interface YXAssessController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation YXAssessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(){
        YXBusinessRepresentativeFragment *fragment = [YXBusinessRepresentativeFragment initWithInfo:nil];
        [self.scrollView addBottomSubview:fragment];
    });
    
}


@end
