//
//  YXUpdateViewController.m
//  yuchengapp
//
//  Created by Mac on 15/11/29.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXMoreViewController.h"
#import "YXLoginController.h"
#import "AppDelegate.h"

@interface YXMoreViewController ()<UIActionSheetDelegate>

- (IBAction)exit:(id)sender;// 退出

@end


@implementation YXMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 退出登录
- (IBAction)exit:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles:nil];
    [actionSheet showInView:self.view];// 弹出提示
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.window.rootViewController = [delegate newLoginController];
    }
    
}


@end
