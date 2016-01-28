//
//  UIBarButtonItem的扩展
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

@interface UIBarButtonItem (Extension)

/** 得到自定义导航按钮 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName target:(id)target action:(SEL)action;

@end
