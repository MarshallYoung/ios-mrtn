//
//  YXAlertDialog.h
//  mrtn
//
//  Created by Mac on 16/1/29.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXAlertDialog : UIView

@property (strong, nonatomic) void(^confirmBlock)(void);// 点击确定的回调
@property (strong, nonatomic) IBOutlet UILabel *label;// 文本
+ (instancetype)initWithSuperView:(UIView *)superView message:(NSString *)message confirm:(void(^)(void))confirm ;// 初始化方法

@end
