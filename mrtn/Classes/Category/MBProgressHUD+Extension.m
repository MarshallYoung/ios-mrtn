//
//  MBProgressHUD扩展
//
//  Created by Mac on 15/12/2.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#define ROOTVIEW [[UIApplication sharedApplication].windows lastObject] // 应用当前显示的View
#define DE 1.0 // 延迟
#define MSG408 @"连接服务器超时,请联系客服人员" // 服务器超时提示的信息

#import "MBProgressHUD+Extension.h"

@implementation MBProgressHUD (Extension)

/**
 *  显示读取动画
 *
 *  @param controller 视图控制器
 *  @param string     显示的信息
 *
 *  @return 登录框
 */
+ (instancetype)showHUDAddedTo:(UIViewController<MBProgressHUDDelegate> *)controller text:(NSString *)string {
    
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];;
    progress.delegate  = controller;// 设置代理,用于移除
    progress.labelText = string;// 文本信息
    [controller.view addSubview:progress];// 显示
    return progress;
    
}

// 显示文字
+ (void)showText:(NSString *)string {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:ROOTVIEW animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = string;// 设置文字
    hud.margin = 10.f;// 设置边距
    hud.removeFromSuperViewOnHide = YES;// 当隐藏的时候移除
    [hud hide:YES afterDelay:DE];
    
}

// 显示文字,上面是对号
+ (void)showSuccess:(NSString *)string {
    
    [self showText:string withImageNamed:@"success"];
    
}

// 显示文字,上面是错号
+(void)showFail:(NSString *)string {
    
    [self showText:string withImageNamed:@"error"];
    
}

// 显示文字,上面是图片
+ (void)showText:(NSString *)string withImageNamed:(NSString *)imageName {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:ROOTVIEW animated:YES];
    hud.labelText = string;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;// 隐藏时候从父控件中移除
    [hud hide:YES afterDelay:DE];
    
}

// 显示连接服务器超时的信息
+ (void)show408 {
    
    [self showFail:MSG408];
    
}


@end
