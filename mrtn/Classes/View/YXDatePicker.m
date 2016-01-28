//
//  自定义日期选择器
//
//  Created by Mac on 16/1/26.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXDatePicker.h"

@interface YXDatePicker ()

- (IBAction)confirm:(id)sender;// 确认
- (IBAction)cancel:(id)sender;// 取消

@end

@implementation YXDatePicker

+(instancetype)initWithSuperView:(UIView *)superView textField:(UITextField *)textField{
    
    YXDatePicker *root = [[[NSBundle mainBundle] loadNibNamed:@"YXDatePicker" owner:nil options:nil] firstObject];
    root.frame = CGRectMake(0, 0, superView.width, superView.height);
    root.datePicker.size = CGSizeMake(superView.width, superView.height);
    root.textField = textField;
    [superView addSubview:root];
    return root;
    
}

+ (instancetype)initWithSuperView:(UIView *)superView textField:(UITextField *)textField confirm:(void (^)(NSString *))confirm {
    
    YXDatePicker *root = [YXDatePicker initWithSuperView:superView textField:textField];
    root.confirmBlock = confirm;
    return root;
    
}

+ (instancetype)initWithSuperView:(UIView *)superView confirm:(void (^)(NSString *))confirm {
    
    YXDatePicker *root = [YXDatePicker initWithSuperView:superView textField:nil];
    root.confirmBlock = confirm;
    return root;
    
}

- (IBAction)confirm:(id)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *strFormatter = [[NSDateFormatter alloc] init];
    if (_datePicker.datePickerMode == UIDatePickerModeDate) {
        [formatter setDateFormat:@"yyyy-MM-dd"];
        [strFormatter setDateFormat:@"yyyyMMdd"];
    }else if (_datePicker.datePickerMode == UIDatePickerModeDateAndTime) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [strFormatter setDateFormat:@"yyyyMMddHHmm"];
    }
    if (_textField) {// 存在文本框就填充
        _textField.text = [formatter stringFromDate:self.datePicker.date];
    }
    if (_confirmBlock) {
        _confirmBlock([strFormatter stringFromDate:self.datePicker.date]);
    }
    [self removeFromSuperview];
    
}

- (IBAction)cancel:(id)sender {
    
    [self removeFromSuperview];
    
}


@end
