//
//  UIBarButtonItem的扩展
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

@interface UIBarButtonItem (Extension)

/**
 *  自定义导航栏按钮
 *
 *  @param imageName          图片名
 *  @param highlightImageName 点击图片名字
 *  @param target             执行方法所在类
 *  @param action             执行方法
 *
 *  @return 导航栏按钮
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName target:(id)target action:(SEL)action;

@end
