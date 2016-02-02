//
//  YXPredictController.m
//  mrtn
//
//  Created by Mac on 16/1/19.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXPredictController.h"
#import "MBProgressHUD+Extension.h"
#import "YXURLHelper.h"
#import "YXOrderListDetailResponse.h"
#import "YXPredictResponse.h"
#import "YXTaskOrderCell.h"
#import "YXDatePicker.h"
#import "AFNetworking.h"

@interface YXPredictController ()<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *disptTimeF;// 派工日期
@property (strong, nonatomic) IBOutlet UITextField *mcNameF;// 商户名称
- (IBAction)datePicker:(id)sender;
- (IBAction)query:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *table;

@end

@implementation YXPredictController {
    
    NSString *mcName;// 商户名称
    NSString *disptTime;// 派工时间
    NSMutableArray<YXTaskOrderInfo> *arr;// 结果集合
    
    MBProgressHUD *progress;// 进度框
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"预计上门工单查询";
    disptTime = @"";
    
}

- (IBAction)datePicker:(id)sender {
    
    [YXDatePicker initWithSuperView:self.view textField:self.disptTimeF];
    
}

// 上传预计上门时间
- (void)updatePredictTime:(NSString *)date forTaskId:(NSString *)taskId {
    
    // 显示进度框
    progress = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];;
    progress.delegate = self;// 设置代理,用于移除
    progress.labelText = @"正在更新预计上门时间...";// 设置文本
    [self.navigationController.view addSubview:progress];// 显示
    
    // 测试查询
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;// 设置超时时间
    // 设置请求头,<<调试DEBUG>>用
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"android_request"];
    NSDictionary *parameters = @{@"taskId":taskId,@"type":@"3",@"date":date};// 设置参数
    [manager POST:URL_PREDICT_UPLOAD parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [progress hide:YES];// 隐藏读取框
        YXPredictResponse *rsp = [[YXPredictResponse alloc] initWithDictionary:responseObject error:nil];
        if (rsp.success) {
            [MBProgressHUD showSuccess:@"设置成功"];
        }else{
            if (rsp.msg) {
                [MBProgressHUD showFail:rsp.msg];// 显示错误消息
            } else {
                [MBProgressHUD showFail:@"上传失败"];// 显示错误消息
            }
        }
        [self query:nil];// 刷新列表
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD show408];
    }];
    
}

- (IBAction)query:(id)sender {
    
    mcName = self.mcNameF.text;
    // 显示进度框
    progress = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];;
    progress.delegate = self;// 设置代理,用于移除
    progress.labelText = @"正在查询...";// 设置文本
    [self.navigationController.view addSubview:progress];// 显示
    // 发送请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;// 设置超时时间
    // 设置请求头,<<调试DEBUG>>用
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"android_request"];
    NSDictionary *parameters = @{@"mcId":@"",@"taskStatus":@"1",@"mcName":mcName,@"disptTime":disptTime,@"type":@"3"};// 设置参数
    [manager POST:URL_ORDER_LIST_DETAIL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        YXLog(@"%@",responseObject);
        [progress hide:YES];// 隐藏读取框
        YXOrderListDetailResponse *rsp = [[YXOrderListDetailResponse alloc] initWithDictionary:responseObject error:nil];
        if (rsp.success) {
            arr = rsp.data;// 设置数据
            [self.table reloadData];
        }else{
            [MBProgressHUD showFail:rsp.msg];// 显示错误消息
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD show408];
    }];
    
}

// 设置预计上门时间
- (void)setPredictTimeForTaskId:(NSString *)taskId {
    
    [YXDatePicker initWithSuperView:self.view confirm:^(NSString *dateString) {
        [self updatePredictTime:dateString forTaskId:taskId];
    }];
    
}

// 显示几个部分
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

// 显示多少条数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arr.count;
    
}

// 显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXTaskOrderCell *cell = [YXTaskOrderCell cellWithTableView:self.table];
    cell.taskOrderInfo = arr[indexPath.row];
    return cell;
    
}

// 点击cell执行方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *taskId = ((YXTaskOrderInfo *)arr[indexPath.row]).taskId;
    [self setPredictTimeForTaskId:taskId];
    
}


@end
