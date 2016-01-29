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
        subview.y = self.contentSize.height;// 设置控件纵坐标
        [self addSubview:subview];
        [self refreshLayout];
    }

}

-(void)refreshLayout {
    
    UIView *lastSubview = [[self subviews] lastObject];
    CGSize newContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, lastSubview.y + lastSubview.height + MARGIN);// 宽度是屏幕宽度,需要的话就修改
    self.contentSize = newContentSize;
    
}

-(void)selectAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


@end
