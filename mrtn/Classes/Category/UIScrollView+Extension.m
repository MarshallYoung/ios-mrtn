//
//  UIScrollView+Extension.m
//  mrtn
//
//  Created by Mac on 16/1/19.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#define MARGIN 5.0 // 外边距

#import "UIScrollView+Extension.h"

@implementation UIScrollView (Extension)

- (void)addBottomSubview:(UIView *)subview {
    
    if (subview) {// 子控件不为空
        subview.y = self.contentSize.height;// 设置控件纵坐标
        CGSize newSize = self.contentSize;// 得到ScrollView内容尺寸
        newSize.height += subview.height + MARGIN;// 设置ScrollView的滚动区域
        self.contentSize = newSize;
        [self addSubview:subview];
    }

}


@end
