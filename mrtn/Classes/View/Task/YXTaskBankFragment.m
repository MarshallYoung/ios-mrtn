//
//  YXTaskBankFragment.m
//  yuchengapp
//
//  Created by Mac on 16/1/14.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXTaskBankFragment.h"
#import "YXDatePicker.h"

@interface YXTaskBankFragment ()

@property (strong, nonatomic) IBOutlet UIButton *dealDateB;// 设置交易日期 tag=41
@property (strong, nonatomic) IBOutlet UIButton *dealTimeB;// 设置交易时间 tag=42
@property (strong, nonatomic) IBOutlet UIButton *clearDateB;// 设置清算日期 tag=43
@property (strong, nonatomic) IBOutlet UITextField *dealDateTF;// 交易日期
@property (strong, nonatomic) IBOutlet UITextField *dealTimeTF;//  交易时间
@property (strong, nonatomic) IBOutlet UITextField *clearDateTF;// 清算日期
@property (strong, nonatomic) IBOutlet UITextField *cardIdTF;// 卡号
@property (strong, nonatomic) IBOutlet UITextField *authNoTF;//  授权码
@property (strong, nonatomic) IBOutlet UITextField *dealAmountTF;// 交易金额

@end

@implementation YXTaskBankFragment

@synthesize taskOrderInfo = _taskOrderInfo;

- (void)setTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo {
    
    _taskOrderInfo = taskOrderInfo;
    self.dealDateTF.text = _taskOrderInfo.taskBankDetail.dealDate;
    self.dealTimeTF.text = _taskOrderInfo.taskBankDetail.dealTime;
    self.clearDateTF.text = _taskOrderInfo.taskBankDetail.clearDate;
    self.cardIdTF.text = _taskOrderInfo.taskBankDetail.cardId;
    self.authNoTF.text = _taskOrderInfo.taskBankDetail.authNo;
    self.dealAmountTF.text = _taskOrderInfo.taskBankDetail.dealAmount;
    if ([_taskOrderInfo.taskStatus isEqual:DONE]) {// 已完结任务单,不可填写
        [self.dealDateTF setEnabled:NO];
        [self.dealTimeTF setEnabled:NO];
        [self.clearDateTF setEnabled:NO];
        [self.cardIdTF setEnabled:NO];
        [self.authNoTF setEnabled:NO];
        [self.dealAmountTF setEnabled:NO];
        [self.dealDateB setEnabled:NO];
        [self.dealTimeB setEnabled:NO];
        [self.clearDateB setEnabled:NO];
    }
    
}

- (YXTaskOrderInfo *)taskOrderInfo {
    if (_taskOrderInfo) {
        _taskOrderInfo.taskBankDetail.dealDate = self.dealDateTF.text;
        _taskOrderInfo.taskBankDetail.dealTime = self.dealTimeTF.text;
        _taskOrderInfo.taskBankDetail.clearDate = self.clearDateTF.text;
        _taskOrderInfo.taskBankDetail.cardId = self.cardIdTF.text;
        _taskOrderInfo.taskBankDetail.authNo = self.authNoTF.text;
        _taskOrderInfo.taskBankDetail.dealAmount = self.dealAmountTF.text;
    }
    return _taskOrderInfo;
}

// 弹出日期选择器
- (IBAction)datePicker:(UIButton *)sender {
    
    if (sender.tag == 41) {
        [YXDatePicker initWithSuperView:[self currentController].view textField:self.dealDateTF];
    } else if (sender.tag == 42) {
        YXDatePicker *picker = [YXDatePicker initWithSuperView:[self currentController].view textField:self.dealTimeTF];
        picker.datePicker.datePickerMode = UIDatePickerModeTime;// 时间选择器模式
    } else if (sender.tag == 43) {
        [YXDatePicker initWithSuperView:[self currentController].view textField:self.clearDateTF];
    }
    
}

+ (instancetype)initWithTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo {
    
    YXTaskBankFragment *fragment = [[[NSBundle mainBundle]loadNibNamed:@"YXTaskBankFragment" owner:nil options:nil]firstObject];
    fragment.taskOrderInfo = taskOrderInfo;
    return fragment;
    
}

@end
