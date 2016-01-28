//
//  MBProgressHUD扩展
//
//  Created by Mac on 15/12/2.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extension)

+ (void)showText:(NSString *)string;// 显示文字
+ (void)showSuccess:(NSString *)string;// 显示对号和文字
+ (void)showFail:(NSString *)string;// 显示错号和文字
+ (void)showText:(NSString *)string withImageNamed:(NSString *)imageName;// 显示文字和图片
+ (void)show408;// 显示连接服务器超时信息

@end
