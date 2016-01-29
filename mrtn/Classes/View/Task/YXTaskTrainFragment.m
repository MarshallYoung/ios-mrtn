//
//  YXTaskTrainFragment.m
//  yuchengapp
//
//  Created by Mac on 16/1/8.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXTaskTrainFragment.h"
#import "YXDatePicker.h"

@interface YXTaskTrainFragment ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *trainDateTF;// 培训日期
@property (strong, nonatomic) IBOutlet UITableView *trainTypeT;// 培训类型
@property (strong, nonatomic) IBOutlet UITextField *trainNumTF;// 培训人数
@property (strong, nonatomic) IBOutlet UITableView *itemPosFaultT;// Pos机硬件故障处理培训
@property (strong, nonatomic) IBOutlet UITableView *itemCardT;// 银行卡知识受理培训
@property (strong, nonatomic) IBOutlet UITableView *itemVoucherT;// 签购单培训
@property (strong, nonatomic) IBOutlet UITableView *itemUserinfoT;// 信息保护培训
@property (strong, nonatomic) IBOutlet UITableView *itemPostSaveT;// Pos机具保管培训
@property (strong, nonatomic) IBOutlet UITableView *itemMcAgreementT;// Pos商户特约协议
@property (strong, nonatomic) IBOutlet UITextView *trainRemarkTV;// 意见或者建议
@property (strong, nonatomic) IBOutlet UIButton *trainDateB;// 选择培训日期

@end


@implementation YXTaskTrainFragment

@synthesize taskOrderInfo = _taskOrderInfo;

- (void)setTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo {
    
    _taskOrderInfo = taskOrderInfo;
    self.trainDateTF.text = _taskOrderInfo.taskTrainDetail.trainDate;
    self.trainNumTF.text = _taskOrderInfo.taskTrainDetail.trainNum;
    self.trainRemarkTV.text = _taskOrderInfo.taskTrainDetail.trainRemark;
    for (int i = 10; i < 17; i++) {// 给所有TableView添加代理和数据
        ((UITableView *)[self viewWithTag:i]).dataSource = self;
        ((UITableView *)[self viewWithTag:i]).delegate = self;
    }
    if ([_taskOrderInfo.taskStatus isEqual:DONE]) {
        [self.trainDateTF setEnabled:NO];
        [self.trainNumTF setEnabled:NO];
        [self.trainRemarkTV setSelectable:NO];
        [self.trainDateB setEnabled:NO];
    }else if ([_taskOrderInfo.taskStatus isEqual:UNDONE]) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.trainTypeT selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.trainTypeT didSelectRowAtIndexPath:path];
        [self.itemPosFaultT selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.itemPosFaultT didSelectRowAtIndexPath:path];
        [self.itemCardT selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.itemCardT didSelectRowAtIndexPath:path];
        [self.itemVoucherT selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.itemVoucherT didSelectRowAtIndexPath:path];
        [self.itemUserinfoT selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.itemUserinfoT didSelectRowAtIndexPath:path];
        [self.itemPostSaveT selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.itemPostSaveT didSelectRowAtIndexPath:path];
        [self.itemMcAgreementT selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.itemMcAgreementT didSelectRowAtIndexPath:path];
    }
    
}

- (YXTaskOrderInfo *)taskOrderInfo {
    if (_taskOrderInfo) {
        _taskOrderInfo.taskTrainDetail.trainDate = self.trainDateTF.text;
        _taskOrderInfo.taskTrainDetail.trainNum = self.trainNumTF.text;
        _taskOrderInfo.taskTrainDetail.trainRemark = self.trainRemarkTV.text;
        _taskOrderInfo.taskTrainDetail.trainType = [NSString stringWithFormat:@"00%ld",[self.trainTypeT selectedIndexPathRow]+1];
        _taskOrderInfo.taskTrainDetail.itemPosFault = [self.itemPosFaultT cellForRowAtIndexPath:[self.itemPosFaultT indexPathForSelectedRow]].textLabel.text;
        _taskOrderInfo.taskTrainDetail.itemCard = [self.itemCardT cellForRowAtIndexPath:[self.itemCardT indexPathForSelectedRow]].textLabel.text;
        _taskOrderInfo.taskTrainDetail.itemVoucher = [self.itemVoucherT cellForRowAtIndexPath:[self.itemVoucherT indexPathForSelectedRow]].textLabel.text;
        _taskOrderInfo.taskTrainDetail.itemUserinfo = [self.itemUserinfoT cellForRowAtIndexPath:[self.itemUserinfoT indexPathForSelectedRow]].textLabel.text;
        _taskOrderInfo.taskTrainDetail.itemPostSave = [self.itemPostSaveT cellForRowAtIndexPath:[self.itemPostSaveT indexPathForSelectedRow]].textLabel.text;
        _taskOrderInfo.taskTrainDetail.itemMcAgreement = [self.itemMcAgreementT cellForRowAtIndexPath:[self.itemMcAgreementT indexPathForSelectedRow]].textLabel.text;
    }
    return _taskOrderInfo;
}

// 弹出日期选择器
- (IBAction)datePicker:(id)sender {
    
    [YXDatePicker initWithSuperView:[self currentController].view textField:self.trainDateTF];
    
}

+ (instancetype)initWithTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo {
    
    YXTaskTrainFragment *fragment = [[[NSBundle mainBundle]loadNibNamed:@"YXTaskTrainFragment" owner:nil options:nil]firstObject];
    fragment.taskOrderInfo = taskOrderInfo;
    return fragment;
    
}

// 显示几个部分
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

// 显示多少条数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag == 10) {// 培训类型
        return 3;
    } else {// 其他TableView
        return 2;
    }
    
}

// 显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;// 点击不变暗
    // 初始化选项
    if (tableView.tag == 10) {// 培训类型
        switch (index) {
            case 0:
                cell.textLabel.text = @"新增终端";
                break;
            case 1:
                cell.textLabel.text = @"收银员变更";
                break;
            case 2:
                cell.textLabel.text = @"定期培训";
                break;
            default:
                break;
        }
    } else {// 其他TableView
        if (index == 0) {
            cell.textLabel.text = @"未培训";
        }else if (index == 1) {
            cell.textLabel.text = @"已培训";
        }
    }
    
    NSString *info = @"";// 目标信息
    switch (tableView.tag) {
        case 10:// 培训类型
            if ([_taskOrderInfo.taskTrainDetail.trainType isEqual:@"001"]) {
                info = @"新增终端";
            }else if ([_taskOrderInfo.taskTrainDetail.trainType isEqual:@"002"]) {
                info = @"收银员变更";
            }else if ([_taskOrderInfo.taskTrainDetail.trainType isEqual:@"003"]) {
                info = @"定期培训";
            }
            break;
        case 11:// Pos机硬件故障处理培训
            info = _taskOrderInfo.taskTrainDetail.itemPosFault;
            break;
        case 12:// 银行卡知识受理培训
            info = _taskOrderInfo.taskTrainDetail.itemCard;
            break;
        case 13:// 签购单培训
            info = _taskOrderInfo.taskTrainDetail.itemVoucher;
            break;
        case 14:// 信息保护培训
            info = _taskOrderInfo.taskTrainDetail.itemUserinfo;
            break;
        case 15:// Pos机具保管培训
            info = _taskOrderInfo.taskTrainDetail.itemPostSave;
            break;
        case 16:// Pos商户特约协议
            info = _taskOrderInfo.taskTrainDetail.itemMcAgreement;
            break;
        default:
            break;
    }
    if ([info isEqual:cell.textLabel.text]) {// 目标信息等于选项描述,就勾选选项
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
