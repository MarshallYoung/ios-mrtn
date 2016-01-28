//
//  签字板
//
//  Created by Mac on 16/1/27.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

@interface YXSignBoard : UIView

@property (strong, nonatomic)UIImageView *targetImageView;
@property (strong, nonatomic) void(^confirmBlock)(void);// 点击确定的回调
+ (instancetype)initWithSuperView:(UIView *)superView imageView:(UIImageView *)targetImageView;// 初始化方法
+ (instancetype)initWithSuperView:(UIView *)superView imageView:(UIImageView *)targetImageView confirm:(void(^)(void))confirm ;// 初始化方法

@end
