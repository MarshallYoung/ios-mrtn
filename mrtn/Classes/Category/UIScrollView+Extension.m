//
//  滚动控件扩展
//
//  Created by Mac on 16/1/19.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#define MARGIN 5.0 // 外边距

#import "UIScrollView+Extension.h"

@implementation UIScrollView (Extension)

- (void)addBottomSubview:(UIView *)subview {
    
    if (subview) {// 子控件不为空
        YXLog(@"scrollView添加subView之前的contentSize高度是:%f",[self contentSize].height);
//        UIView *lastObj = [[self subviews] lastObject];
        subview.y = [self contentSize].height;// 设置控件纵坐标
        YXLog(@"subView的纵坐标y是:%f",subview.y);
        [self addSubview:subview];
        CGSize newContentSize = [self contentSize];
        newContentSize.height = subview.y + subview.height + MARGIN;
        self.contentSize = newContentSize;
        YXLog(@"scrollView添加subView之后的contentSize高度是:%f",[self contentSize].height);
        
    }

}

@end
