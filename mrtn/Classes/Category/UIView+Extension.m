//
//  UIView的扩展
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#define MARGIN 5 // 外边距

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x {
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
    
}

- (CGFloat)x {
    
    return self.frame.origin.x;
    
}

- (void)setY:(CGFloat)y {
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
    
}

- (CGFloat)y {
    
    return self.frame.origin.y;
    
}

- (void)setWidth:(CGFloat)width {
    
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    
}

- (CGFloat)width {
    
    return self.frame.size.width;
    
}

- (void)setHeight:(CGFloat)height {
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    
}

- (CGFloat)height {
    
    return self.frame.size.height;
    
}

- (void)setSize:(CGSize)size {
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    
}

- (CGSize)size {
    
    return self.frame.size;
    
}

// 得到当前view所在controller
- (UIViewController *)currentController {
    
    UIViewController *controller;
    for (UIView* next = [self superview]; next; next =
         next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                          class]]) {
            controller = (UIViewController *)nextResponder;
            break;
        }
    }
    return controller;
    
}

// 在底端添加subview
- (void)addBottomSubview:(UIView *)subview {
    
    if (subview) {// 子控件不为空
        subview.y = self.height;// 设置控件纵坐标
        CGSize newSize = self.size;// 得到尺寸
        newSize.height += subview.height + MARGIN;// 设置ScrollView的滚动区域
        self.size = newSize;
        [self addSubview:subview];
    }
    
}


@end
