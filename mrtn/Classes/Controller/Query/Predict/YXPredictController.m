//
//  YXPredictController.m
//  mrtn
//
//  Created by Mac on 16/1/19.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXPredictController.h"
#import "YXNetworkingManager.h"
#import "MBProgressHUD+Extension.h"
#import "YXPredictListRequest.h"
#import "YXOrderListDetailResponse.h"
#import "YXUpdatePredictRequest.h"
#import "YXUpdatePredictResponse.h"
#import "YXTaskOrderCell.h"
#import "YXDatePicker.h"

@interface YXPredictController ()<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *disptTimeF;// 派工日期
@property (strong, nonatomic) IBOutlet UITextField *mcNameF;// 商户名称
@property (strong, nonatomic) IBOutlet UITableView *table;
- (IBAction)datePicker:(id)sender;
- (IBAction)query:(id)sender;

@end


@implementation YXPredictController {
    
    NSMutableArray<YXTaskOrderInfo> *array;// 结果
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"预计上门工单查询";
    
}

- (IBAction)datePicker:(id)sender {
    
    [YXDatePicker initWithSuperView:self.view textField:self.disptTimeF];
    
}

- (IBAction)query:(id)sender {
    
    NSString *mcName    = self.mcNameF.text;
    NSString *disptTime = self.disptTimeF.text;
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self text:@"正在查询..."];// 读取框
    YXPredictListRequest *request = [YXPredictListRequest requestWithName:mcName time:disptTime];
    [YXNetworkingManager queryWithRequest:request success:^(id responseObject) {
        [progress hide:YES];// 隐藏读取框
        YXOrderListDetailResponse *response = [[YXOrderListDetailResponse alloc] initWithDictionary:responseObject error:nil];
        if (response.success) {
            array = response.data;// 设置数据
            [self.table reloadData];
        }else{
            [MBProgressHUD showFail:response.msg];// 显示错误消息
        }
    } failure:^(void) {
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD show408];
    }];
    
}

/**
 *  更新预计上门时间
 *
 *  @param taskId 任务单编号
 */
- (void)updatePredictWithId:(NSString *)taskId {
    
    YXDatePicker *picker = [YXDatePicker initWithSuperView:self.view confirm:^(NSString *dateString) {
        MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self text:@"更新预计上门时间..."];// 进度框
        YXUpdatePredictRequest *request = [YXUpdatePredictRequest requestWithId:taskId date:dateString];
        [YXNetworkingManager updateWithRequest:request success:^(id responseObject) {
            [progress hide:YES];// 隐藏读取框
            YXUpdatePredictResponse *response = [[YXUpdatePredictResponse alloc] initWithDictionary:responseObject error:nil];
            if (response.success) {
                [MBProgressHUD showSuccess:@"设置成功"];
            } else {
                if (response.msg) {
                    [MBProgressHUD showFail:response.msg];// 显示错误消息
                } else {
                    [MBProgressHUD showFail:@"上传失败"];// 显示错误消息
                }
            }
            [self query:nil];// 刷新列表
        } failure:^(void) {
            [progress hide:YES];// 隐藏读取框
            [MBProgressHUD show408];
        }];

    }];
    picker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
}

// 显示几个部分
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

// 显示多少条数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return array.count;
    
}

// 显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXTaskOrderCell *cell = [YXTaskOrderCell cellWithTableView:self.table];
    cell.taskOrderInfo = array[indexPath.row];
    return cell;
    
}

// 点击cell执行方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *taskId = ((YXTaskOrderInfo *)array[indexPath.row]).taskId;
    [self updatePredictWithId:taskId];
    
}


@end
