//
//  风险调查单
//
//  Created by Mac on 16/1/14.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXTaskSurveyFragment.h"

@interface YXTaskSurveyFragment ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextView *riskQuestionTV;// 商户疑似风险问题
@property (strong, nonatomic) IBOutlet UITextView *surveyRequireTV;// 调查要求
@property (strong, nonatomic) IBOutlet UITableView *feedbackT;// 现场调查情况反馈 tag=11
@property (strong, nonatomic) IBOutlet UITableView *measuresT;// 风险控制措施 tag=12
@property (strong, nonatomic) IBOutlet UITextView *bankOpinionTV;// 意见

@end


@implementation YXTaskSurveyFragment

@synthesize taskOrderInfo = _taskOrderInfo;

- (void)setTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo {
    
    _taskOrderInfo = taskOrderInfo;
    self.riskQuestionTV.text = _taskOrderInfo.taskSurveyDetail.riskQuestion;
    self.surveyRequireTV.text = _taskOrderInfo.taskSurveyDetail.surveyRequire;
    self.bankOpinionTV.text = _taskOrderInfo.taskSurveyDetail.bankOpinion;
    for (int i = 11; i < 13; i++) {// 给所有TableView添加代理和数据
        ((UITableView *)[self viewWithTag:i]).dataSource = self;
        ((UITableView *)[self viewWithTag:i]).delegate = self;
    }
    if ([_taskOrderInfo.taskStatus isEqual:DONE]) {// 已完结任务单,不可填写
        [self.riskQuestionTV setSelectable:NO];
        [self.surveyRequireTV setSelectable:NO];
        [self.bankOpinionTV setSelectable:NO];
    }
    
}

- (YXTaskOrderInfo *)taskOrderInfo {
    if (_taskOrderInfo) {
        _taskOrderInfo.taskSurveyDetail.riskQuestion = self.riskQuestionTV.text;
        _taskOrderInfo.taskSurveyDetail.surveyRequire = self.surveyRequireTV.text;
        _taskOrderInfo.taskSurveyDetail.bankOpinion = self.bankOpinionTV.text;
        _taskOrderInfo.taskSurveyDetail.feedback = [NSString stringWithFormat:@"%ld",[self.feedbackT selectedIndexPathRow]];
        _taskOrderInfo.taskSurveyDetail.measures = [NSString stringWithFormat:@"%ld",[self.measuresT selectedIndexPathRow]];
    }
    return _taskOrderInfo;
}

+ (instancetype)initWithTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo {
    
    YXTaskSurveyFragment *fragment = [[[NSBundle mainBundle]loadNibNamed:@"YXTaskSurveyFragment" owner:nil options:nil]firstObject];
    fragment.taskOrderInfo = taskOrderInfo;
    return fragment;
    
}

// 显示几个部分
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

// 显示多少条数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag == 11) {
        return 2;
    } else if (tableView.tag == 12){
        return 4;
    } else {
        return 0;
    }
    
}

// 显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;// 点击不变暗
    // 初始化选项
    if (tableView.tag == 11) {// 现场调查情况反馈
        switch (index) {
            case 0:
                cell.textLabel.text = @"无风险";
                break;
            case 1:
                cell.textLabel.text = @"有风险";
                break;
        }
    } else if (tableView.tag == 12){// 商户风险控制措施
        switch (index) {
            case 0:
                cell.textLabel.text = @"再次培训";
                break;
            case 1:
                cell.textLabel.text = @"交易限额";
                break;
            case 2:
                cell.textLabel.text = @"警告";
                break;
            case 3:
                cell.textLabel.text = @"撤机处理";
                break;
        }
    }
    
    int position = 0;// 目标信息
    switch (tableView.tag) {
        case 11:// 现场调查情况反馈
            position = [_taskOrderInfo.taskSurveyDetail.feedback intValue];
            break;
        case 12:// 商户风险控制措施
            position = [_taskOrderInfo.taskSurveyDetail.measures intValue];
            break;
    }
    if (position == index) {// 目标信息等于选项描述,就勾选选项
        cell.textLabel.textColor=[UIColor blueColor];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    return cell;
    
}

// 点击cell执行方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_taskOrderInfo.taskStatus isEqual:DONE]) {// 已完结任务单,点击无响应
    } else {// 未完结任务单
        NSArray *array = [tableView visibleCells];
        for (UITableViewCell *cell in array) {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            cell.textLabel.textColor=[UIColor blackColor];
        }
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor=[UIColor blueColor];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    
}

@end
