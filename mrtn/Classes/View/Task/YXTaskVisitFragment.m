//
//  走访回访单
//
//  Created by Mac on 16/1/13.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXTaskVisitFragment.h"
#import "YXDatePicker.h"

@interface YXTaskVisitFragment ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIButton *visitDateB;// 设置本次回访日期 tag=41
@property (strong, nonatomic) IBOutlet UIButton *visitLastDateB;// 设置上次回访日期 tag=42
@property (strong, nonatomic) IBOutlet UITextField *visitDateTF;// 本次回访日期
@property (strong, nonatomic) IBOutlet UITextField *visitLastDateTF;// 上次回访日期
@property (strong, nonatomic) IBOutlet UITableView *posIsAddrT;// 安装Pos店面地址 tag=11
@property (strong, nonatomic) IBOutlet UITextView *posNewAddrTV;// 变更后地址
@property (strong, nonatomic) IBOutlet UITableView *posPositionChangeT;// Pos机具摆放位置 tag=12
@property (strong, nonatomic) IBOutlet UITableView *turnoverAvgT;// 本店面近三个月月均营业额 tag=18
@property (strong, nonatomic) IBOutlet UITableView *stockExceptionT;// 退货明细是否异常 tag=13
@property (strong, nonatomic) IBOutlet UITableView *externalChangeT;// 周边环境重大变化 tag=14
@property (strong, nonatomic) IBOutlet UITableView *internalChangeT;// 内部经营环境重大变化 tag=15
@property (strong, nonatomic) IBOutlet UITableView *statusChangeT;// 经营状态重大变化 tag=16
@property (strong, nonatomic) IBOutlet UITableView *managementChangeT;// 管理层人员变动情况 tag=17
@property (strong, nonatomic) IBOutlet UITextField *managementNameTF;// 变更后姓名
@property (strong, nonatomic) IBOutlet UITextField *managementTelTF;// 变更后电话
@property (strong, nonatomic) IBOutlet UITableView *personQualityChangeT;// 收银员变化情况及综合素质 tag=20
@property (strong, nonatomic) IBOutlet UITableView *otherRiskT;// 其他可能造成风险的状况 tag=19
@property (strong, nonatomic) IBOutlet UITextView *resultTV;// 处理结果

@end


@implementation YXTaskVisitFragment

@synthesize taskOrderInfo = _taskOrderInfo;

- (void)setTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo {
    
    _taskOrderInfo = taskOrderInfo;
    self.visitDateTF.text = _taskOrderInfo.taskVisitDetail.visitDate;
    self.visitLastDateTF.text = _taskOrderInfo.taskVisitDetail.visitLastDate;
    self.posNewAddrTV.text = _taskOrderInfo.taskVisitDetail.posNewAddr;
    self.managementNameTF.text = _taskOrderInfo.taskVisitDetail.managementName;
    self.managementTelTF.text = _taskOrderInfo.taskVisitDetail.managementTel;
    self.resultTV.text = _taskOrderInfo.taskVisitDetail.result;
    for (int i = 11; i < 21; i++) {// 给所有TableView添加代理和数据
        ((UITableView *)[self viewWithTag:i]).dataSource = self;
        ((UITableView *)[self viewWithTag:i]).delegate = self;
    }
    if ([_taskOrderInfo.taskStatus isEqual:DONE]) {// 已完结任务单,不可填写
        [self.visitDateTF setEnabled:NO];
        [self.visitLastDateTF setEnabled:NO];
        [self.posNewAddrTV setSelectable:NO];
        [self.managementNameTF setEnabled:NO];
        [self.managementTelTF setEnabled:NO];
        [self.resultTV setSelectable:NO];
        [self.visitDateB setEnabled:NO];
        [self.visitLastDateB setEnabled:NO];
    }
    
}

- (YXTaskOrderInfo *)taskOrderInfo {
    if (_taskOrderInfo) {
        _taskOrderInfo.taskVisitDetail.visitDate = self.visitDateTF.text;
        _taskOrderInfo.taskVisitDetail.visitLastDate = self.visitLastDateTF.text;
        _taskOrderInfo.taskVisitDetail.posNewAddr = self.posNewAddrTV.text;
        _taskOrderInfo.taskVisitDetail.managementName = self.managementNameTF.text;
        _taskOrderInfo.taskVisitDetail.managementTel = self.managementTelTF.text;
        _taskOrderInfo.taskVisitDetail.result = self.resultTV.text;
        _taskOrderInfo.taskVisitDetail.posIsAddr = [NSString stringWithFormat:@"%ld",[self.posIsAddrT selectedIndexPathRow]];
        _taskOrderInfo.taskVisitDetail.posPositionChange = [NSString stringWithFormat:@"%ld",[self.posPositionChangeT selectedIndexPathRow]];
        _taskOrderInfo.taskVisitDetail.turnoverAvg = [NSString stringWithFormat:@"%ld",[self.turnoverAvgT selectedIndexPathRow]];
        _taskOrderInfo.taskVisitDetail.stockException = [NSString stringWithFormat:@"%ld",[self.stockExceptionT selectedIndexPathRow]];
        _taskOrderInfo.taskVisitDetail.externalChange = [NSString stringWithFormat:@"%ld",[self.externalChangeT selectedIndexPathRow]];
        _taskOrderInfo.taskVisitDetail.internalChange = [NSString stringWithFormat:@"%ld",[self.internalChangeT selectedIndexPathRow]];
        _taskOrderInfo.taskVisitDetail.statusChange = [NSString stringWithFormat:@"%ld",[self.statusChangeT selectedIndexPathRow]];
        _taskOrderInfo.taskVisitDetail.managementChange = [NSString stringWithFormat:@"%ld",[self.managementChangeT selectedIndexPathRow]];
        _taskOrderInfo.taskVisitDetail.personQualityChange = [NSString stringWithFormat:@"%ld",[self.personQualityChangeT selectedIndexPathRow]];
        _taskOrderInfo.taskVisitDetail.otherRisk = [NSString stringWithFormat:@"%ld",[self.otherRiskT selectedIndexPathRow]];
    }
    return _taskOrderInfo;
}

// 弹出日期选择器
- (IBAction)datePicker:(UIButton *)sender {
    
    if (sender.tag == 41) {
        [YXDatePicker initWithSuperView:[self currentController].view textField:self.visitDateTF];
    } else if (sender.tag == 42) {
        [YXDatePicker initWithSuperView:[self currentController].view textField:self.visitLastDateTF];
    }
    
}

+ (instancetype)initWithTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo {
    
    YXTaskVisitFragment *fragment = [[[NSBundle mainBundle]loadNibNamed:@"YXTaskVisitFragment" owner:nil options:nil]firstObject];
    fragment.taskOrderInfo = taskOrderInfo;
    return fragment;
    
}

// 显示几个部分
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

// 显示多少条数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag == 20) {// 收银员变化情况及综合素质
        return 4;
    } else if (tableView.tag > 17 && tableView.tag < 20){
        return 3;
    } else {
        return 2;
    }
    
}

// 显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;// 点击不变暗
    // 初始化选项
    if (tableView.tag == 20) {// 收银员变化情况及综合素质
        switch (index) {
            case 0:
                cell.textLabel.text = @"优秀";
                break;
            case 1:
                cell.textLabel.text = @"良好";
                break;
            case 2:
                cell.textLabel.text = @"一般";
                break;
            case 3:
                cell.textLabel.text = @"差";
                break;
            default:
                break;
        }
    } else if (tableView.tag == 19){// 其他可能造成风险的状况
        switch (index) {
            case 0:
                cell.textLabel.text = @"套现";
                break;
            case 1:
                cell.textLabel.text = @"移机";
                break;
            case 2:
                cell.textLabel.text = @"无";
                break;
            default:
                break;
        }
    } else if (tableView.tag == 18){// 本店面近三个月月均营业额
        switch (index) {
            case 0:
                cell.textLabel.text = @"高";
                break;
            case 1:
                cell.textLabel.text = @"正常";
                break;
            case 2:
                cell.textLabel.text = @"低";
                break;
            default:
                break;
        }
    } else {
        if (index == 0) {
            cell.textLabel.text = @"否";
        } else if (index == 1){
            cell.textLabel.text = @"是";
        }
    }
    
    int position = 0;// 目标信息
    switch (tableView.tag) {
        case 11:// 安装Pos店面地址
            position = [_taskOrderInfo.taskVisitDetail.posIsAddr intValue];
            break;
        case 12:// Pos机具摆放位置
            position = [_taskOrderInfo.taskVisitDetail.posPositionChange intValue];
            break;
        case 13:// 退货明细是否异常
            position = [_taskOrderInfo.taskVisitDetail.stockException intValue];
            break;
        case 14:// 周边环境重大变化
            position = [_taskOrderInfo.taskVisitDetail.externalChange intValue];
            break;
        case 15:// 内部经营环境重大变化
            position = [_taskOrderInfo.taskVisitDetail.internalChange intValue];
            break;
        case 16:// 经营状态重大变化
            position = [_taskOrderInfo.taskVisitDetail.statusChange intValue];
            break;
        case 17:// 管理层人员变动情况
            position = [_taskOrderInfo.taskVisitDetail.managementChange intValue];
            break;
        case 18:// 本店面近三个月月均营业额
            position = [_taskOrderInfo.taskVisitDetail.turnoverAvg intValue];
            break;
        case 19:// 其他可能造成风险的状况
            position = [_taskOrderInfo.taskVisitDetail.otherRisk intValue];
            break;
        case 20:// 收银员变化情况及综合素质
            position = [_taskOrderInfo.taskVisitDetail.personQualityChange intValue];
            break;
        default:
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
