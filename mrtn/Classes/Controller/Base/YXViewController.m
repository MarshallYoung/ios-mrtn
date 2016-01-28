//
//  视图控制器
//
//  Created by Mac on 15/11/6.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXViewController.h"

@implementation YXViewController {
    
    int keyBoardMargin_;// 移动偏移量
    float keyboardHeight;// 虚拟键盘高度
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];// 创建手势
    tap.cancelsTouchesInView = NO;// 先给子控件处理,之后给父控件处理
    [self.view addGestureRecognizer:tap];// 添加手势
    keyboardHeight = 216;// 初始化键盘高度
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)notification {
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    keyboardHeight = keyboardRect.size.height;
    
}

// 关闭虚拟键盘
- (void)dismissKeyboard {
    
    [self.view endEditing:YES];
    
}

#pragma mark - 处理文本位置方法
- (void)moveView:(UITextField *)textField leaveView:(BOOL)leave {
    
    float screenHeight = [UIScreen mainScreen].bounds.size.height; //屏幕尺寸，如果屏幕允许旋转，可根据旋转动态调整
    float statusBarHeight,NavBarHeight,tableCellHeight,textFieldOriginY,textFieldFromButtomHeigth;
    int margin = 0;
    statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height; //屏幕状态栏高度
    NavBarHeight = self.navigationController.navigationBar.frame.size.height; //获取导航栏高度
    UITableViewCell *tableViewCell=(UITableViewCell *)textField.superview;
    tableCellHeight = tableViewCell.frame.size.height; //获取单元格高度
    CGRect fieldFrame=[self.view convertRect:textField.frame fromView:tableViewCell];
    textFieldOriginY = fieldFrame.origin.y; //获取文本框相对本视图的y轴位置。
    //计算文本框到屏幕底部的高度（屏幕高度-顶部状态栏高度-导航栏高度-文本框的的相对y轴位置-单元格高度）
    textFieldFromButtomHeigth = screenHeight - statusBarHeight - NavBarHeight - textFieldOriginY - tableCellHeight;
    if(!leave) {// 还未移动过
        if(textFieldFromButtomHeigth < keyboardHeight) {// 如果文本框到屏幕底部的高度 < 键盘高度
            margin = textField.y - 5; // 移动距离就是虚拟键盘的高度
            keyBoardMargin_ = margin; // keyBoardMargin_ 为成员变量，记录上一次移动的间距,用户离开文本时恢复视图高度
        } else {// 没有遮挡
            margin= 0;
            keyBoardMargin_ = 0;
        }
    }
    const float movementDuration = 0.3f; // 动画时间
    int movement = (leave ? keyBoardMargin_ : -margin); // 进入时根据差距移动视图，离开时恢复之前的高度
    [UIView beginAnimations: @"textFieldAnim" context: nil]; //添加动画
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [self moveView:textField leaveView:NO];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self moveView:textField leaveView:YES];
    
}


@end
