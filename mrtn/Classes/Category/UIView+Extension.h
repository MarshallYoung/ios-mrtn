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
@property (nonatomic, assign) CGSize  size;
/**
 *  得到所在视图控制器
 *
 *  @return 视图控制器
 */
- (UIViewController *)currentController;
/**
 *  末尾添加子控件
 *
 *  @param subview 子控件
 */
- (void)addBottomSubview:(UIView *)subview;
/**
 *  屏幕快照
 *
 *  @return 图片
 */
-(UIImage *)convertViewToImage;

@end
