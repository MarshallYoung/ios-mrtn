//
//  自定义日期选择器
//
//  Created by Mac on 16/1/26.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

@interface YXDatePicker : UIView

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) UITextField *textField;// 显示时间的文本框
@property (strong, nonatomic) void(^confirmBlock)(NSString *dateString);// 点击确定的回调
+ (instancetype)initWithSuperView:(UIView *)superView textField:(UITextField *)textField;// 初始化方法
+ (instancetype)initWithSuperView:(UIView *)superView confirm:(void(^)(NSString *dateString))confirm ;// 初始化方法
+ (instancetype)initWithSuperView:(UIView *)superView textField:(UITextField *)textField confirm:(void(^)(NSString *dateString))confirm ;// 初始化方法

@end
