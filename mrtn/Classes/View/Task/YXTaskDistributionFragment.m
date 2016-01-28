//
//  YXTaskDistributionFragment.m
//  yuchengapp
//
//  Created by Mac on 16/1/14.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXTaskDistributionFragment.h"

@interface YXTaskDistributionFragment ()

@property (strong, nonatomic) IBOutlet UITextField *mtalNum1TF;// 热敏纸大卷
@property (strong, nonatomic) IBOutlet UITextField *mtalNum2TF;// 热敏纸小卷
@property (strong, nonatomic) IBOutlet UITextField *mtalNum3TF;// 针打纸

@end


@implementation YXTaskDistributionFragment

@synthesize taskOrderInfo = _taskOrderInfo;

- (void)setTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo {
    
    _taskOrderInfo = taskOrderInfo;
    self.mtalNum1TF.text = _taskOrderInfo.taskDistributionDetail.mtalNum1;
    self.mtalNum2TF.text = _taskOrderInfo.taskDistributionDetail.mtalNum2;
    self.mtalNum3TF.text = _taskOrderInfo.taskDistributionDetail.mtalNum3;
    if ([_taskOrderInfo.taskStatus isEqual:DONE]) {// 已完结任务单,不可填写
        [self.mtalNum1TF setEnabled:NO];
        [self.mtalNum2TF setEnabled:NO];
        [self.mtalNum3TF setEnabled:NO];
    }
    
}

- (YXTaskOrderInfo *)taskOrderInfo {
    if (_taskOrderInfo) {
        _taskOrderInfo.taskDistributionDetail.mtalNum1 = self.mtalNum1TF.text;
        _taskOrderInfo.taskDistributionDetail.mtalNum2 = self.mtalNum2TF.text;
        _taskOrderInfo.taskDistributionDetail.mtalNum3 = self.mtalNum3TF.text;
    }
    return _taskOrderInfo;
}

+ (instancetype)initWithTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo {
    
    YXTaskDistributionFragment *fragment = [[[NSBundle mainBundle]loadNibNamed:@"YXTaskDistributionFragment" owner:nil options:nil]firstObject];
    fragment.taskOrderInfo = taskOrderInfo;
    return fragment;
    
}

@end
