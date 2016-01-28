//
//  UIView的扩展
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
- (UIViewController *)currentController;// 得到view所在控制器
- (void)addBottomSubview:(UIView *)subview;// 末尾添加

@end
