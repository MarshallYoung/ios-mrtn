//
//  UIActionSheet+Block.h
//
//
//  Created by lbxia on 15/10/27.
//  Copyright © 2015年 lbxia. All rights reserved.
//

@interface UIActionSheet (Block)<UIActionSheetDelegate>

- (void)showInView:(UIView *)view block:(void(^)(NSInteger idx))block;

@end