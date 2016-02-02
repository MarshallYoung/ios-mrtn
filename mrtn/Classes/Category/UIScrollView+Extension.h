//
//  滚动控件扩展
//
//  Created by Mac on 16/1/19.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

@interface UIScrollView (Extension)

- (void)addBottomSubview:(UIView *)subview;// 末尾添加
- (void)refreshLayout;// 刷新布局,配置contentSize

@end
