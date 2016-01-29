//
//  YXAlertDialog.m
//  mrtn
//
//  Created by Mac on 16/1/29.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXAlertDialog.h"

@interface YXAlertDialog ()

- (IBAction)confirm:(id)sender;// 确定

@end

@implementation YXAlertDialog

+(instancetype)initWithSuperView:(UIView *)superView message:(NSString *)message confirm:(void (^)(void))confirm {
    
    YXAlertDialog *root = [[[NSBundle mainBundle] loadNibNamed:@"YXAlertDialog" owner:nil options:nil] firstObject];
    root.frame = CGRectMake(0, 0, superView.width, superView.height);
    root.confirmBlock = confirm;
    root.label.text = message;
    [superView addSubview:root];
    return root;
    
}

- (IBAction)confirm:(id)sender {
    
    self.confirmBlock();
    
}
@end
