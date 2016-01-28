//
//  YXBacklogDetailCell.m
//  yuchengapp
//
//  Created by Mac on 15/12/29.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXTaskOrderCell.h"

@interface YXTaskOrderCell ()

@property (strong, nonatomic) IBOutlet UILabel *taskIdL;// 任务单编号
@property (strong, nonatomic) IBOutlet UILabel *taskNameL;// 任务单类型
@property (strong, nonatomic) IBOutlet UILabel *mcNameL;// 商户名称
@property (strong, nonatomic) IBOutlet UILabel *termIdL;// 终端编号
@property (strong, nonatomic) IBOutlet UILabel *termTaddrL;// 终端地址
@property (strong, nonatomic) IBOutlet UILabel *disptTimeL;// 派工时间

@end

@implementation YXTaskOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo {
    
    _taskOrderInfo = taskOrderInfo;
    
    self.taskIdL.text = taskOrderInfo.taskId;
    self.mcNameL.text = taskOrderInfo.mcName;
    self.termIdL.text = taskOrderInfo.termId;
    self.termTaddrL.text = taskOrderInfo.termTaddr;
    self.disptTimeL.text = taskOrderInfo.disptTime;
//    NSString *type = @"暂无资料";
//    if (taskOrderInfo.taskApplyDetail != nil) {
//        type = @"装机申请单";
//    }
//    if (taskOrderInfo.taskBankDetail != nil) {
//        type = @"发卡行调单";
//    }
//    if (taskOrderInfo.taskDistributionDetail != nil) {
//        type = @"耗材配送单";
//    }
//    if (taskOrderInfo.taskInstallDetail != nil) {
//        type = @"装机任务单";
//    }
//    if (taskOrderInfo.taskRepairDetail != nil) {
//        type = @"故障报修单";
//    }
//    if (taskOrderInfo.taskRiskDetail != nil) {
//        type = @"补充进件材料单";
//    }
//    if (taskOrderInfo.taskSurveyDetail != nil) {
//        type = @"风险商户调查单";
//    }
//    if (taskOrderInfo.taskVisitDetail != nil) {
//        type = @"走访回访单";
//    }
//    if (taskOrderInfo.taskTrainDetail != nil) {
//        type = @"培训单";
//    }
    self.taskNameL.text = taskOrderInfo.taskName;

}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *identifier= @"YXTaskOrderCell";
    YXTaskOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"YXTaskOrderCell" owner:nil options:nil]firstObject];
    }
    return cell;
    
}


@end
