//
//  YXTaskRepairFragment.m
//  yuchengapp
//
//  Created by Mac on 16/1/7.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXTaskRepairFragment.h"

@interface YXTaskRepairFragment ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *rtContentT;// 报修内容
@property (strong, nonatomic) IBOutlet UITextView *otherContextTV;// 其他内容
@property (strong, nonatomic) IBOutlet UITextView *remarkTV;// 备注

@end


@implementation YXTaskRepairFragment

@synthesize taskOrderInfo = _taskOrderInfo;

- (void)setTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo {
    
    _taskOrderInfo = taskOrderInfo;
    self.otherContextTV.text = _taskOrderInfo.taskRepairDetail.otherContext;
    self.remarkTV.text = _taskOrderInfo.taskRepairDetail.remark;
    self.rtContentT.delegate = self;
    self.rtContentT.dataSource = self;
    if ([_taskOrderInfo.taskStatus isEqual:DONE]) {
        [self.otherContextTV setSelectable:NO];
        [self.remarkTV setSelectable:NO];
    }else if ([_taskOrderInfo.taskStatus isEqual:UNDONE]) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.rtContentT selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.rtContentT didSelectRowAtIndexPath:path];
    }
    
    
}

- (YXTaskOrderInfo *)taskOrderInfo {
    if (_taskOrderInfo) {
        _taskOrderInfo.taskRepairDetail.otherContext = self.otherContextTV.text;
        _taskOrderInfo.taskRepairDetail.remark = self.remarkTV.text;
        _taskOrderInfo.taskRepairDetail.rtContent = [self.rtContentT cellForRowAtIndexPath:[self.rtContentT indexPathForSelectedRow]].textLabel.text;
    }
    return _taskOrderInfo;
}

+ (instancetype)initWithTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo {
    
    YXTaskRepairFragment *fragment = [[[NSBundle mainBundle]loadNibNamed:@"YXTaskRepairFragment" owner:nil options:nil]firstObject];
    fragment.taskOrderInfo = taskOrderInfo;
    return fragment;
    
}

// 显示几个部分
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

// 显示多少条数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
    
}

// 显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;// 点击不变暗
    if (index == 0) {
        cell.textLabel.text = @"不打印或打印不清楚";
    }else if (index == 1) {
        cell.textLabel.text = @"按键失灵";
    }else if (index == 2) {
        cell.textLabel.text = @"机具开机失败";
    }else if (index == 3) {
        cell.textLabel.text = @"磁条读取错误或无反应";
    }else if (index == 4) {
        cell.textLabel.text = @"连接超时";
    }else if (index == 5) {
        cell.textLabel.text = @"密钥未下载";
    }else if (index == 6) {
        cell.textLabel.text = @"其他";
    }
    if ([_taskOrderInfo.taskRepairDetail.rtContent isEqual:cell.textLabel.text]) {
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
