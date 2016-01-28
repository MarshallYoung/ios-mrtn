//
//  查询任务单列表
//
//  Created by Mac on 15/12/18.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXOrderListController.h"
#import "MBProgressHUD+Extension.h"
#import "YXURLHelper.h"
#import "YXQueryOrderListResponse.h"
#import "YXBacklogCell.h"
#import "YXOrderListDetailController.h"
#import "YXDatePicker.h"

@interface YXOrderListController ()<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *mcIdTF;
@property (strong, nonatomic) IBOutlet UITextField *mcNameTF;
@property (strong, nonatomic) IBOutlet UITextField *disptTimeTF;
- (IBAction)datePicker:(id)sender;
- (IBAction)query:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *table;

@end

@implementation YXOrderListController {
    
    NSString *mcId;// 商户编号
    NSString *taskStatus;// 任务单编号
    NSString *mcName;// 商户名称
    NSString *disptTime;// 派工时间
    NSString *instId;// 机构编号
    NSString *UserId;// 用户编号
    NSMutableArray<YXOrderListInfo> *arr;// 结果集合
    MBProgressHUD *progress;// 进度框
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_controllerInfo.mode == ORDER_BACKLOG) {
        self.title = @"待办列表";
    }else if (_controllerInfo.mode == ORDER_PROCESSED) {
        self.title = @"办结列表";
    }
    disptTime = @"";
    
}

// 弹出日期选择器
- (IBAction)datePicker:(id)sender {
    
    [YXDatePicker initWithSuperView:self.view textField:self.disptTimeTF confirm:^(NSString *dateString) {
        disptTime = dateString;// 更新派工时间
    }];
    
}

// 查询
- (IBAction)query:(id)sender {
    
    YXLog(@"%@",disptTime);
    
    [self.view endEditing:YES];
    mcId = self.mcIdTF.text;// 得到商户编号
    mcName = self.mcNameTF.text;// 得到商户名称
    instId = @"0";// 机构编号
    if (_controllerInfo.mode == ORDER_BACKLOG) {
        taskStatus = @"1";// 查询待办
    }else if (_controllerInfo.mode == ORDER_PROCESSED) {
        taskStatus = @"2";// 查询办结
    }
    UserId = @"";// 用户编号
    
    // 显示进度框
    progress = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];;
    progress.delegate = self;// 设置代理,用于移除
    progress.labelText = @"正在查询...";// 设置文本
    [self.navigationController.view addSubview:progress];// 显示
    
    // 测试查询
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;// 设置超时时间
    
    // 设置请求头,<<调试DEBUG>>用
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"android_request"];
    
    NSDictionary *parameters = @{@"mcId":mcId,@"taskStatus":taskStatus,@"mcName":mcName,@"disptTime":disptTime,@"instId":instId,@"UserId":UserId};// 设置参数
    [manager POST:URL_ORDER_LIST parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [progress hide:YES];// 隐藏读取框
        YXQueryOrderListResponse *rsp = [[YXQueryOrderListResponse alloc] initWithDictionary:responseObject error:nil];
        if (rsp.success) {
            arr = rsp.data;// 设置数据
            [self.table reloadData];// 刷新数据源
        }else{
            [MBProgressHUD showFail:rsp.msg];// 显示错误消息
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD showFail:@"服务器无响应,请联系服务人员"];
        
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
    
    YXBacklogCell *cell = [YXBacklogCell cellWithTableView:self.table];
    cell.orderListInfo =arr[indexPath.row];
    return cell;
    
}

// 点击cell执行方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXOrderListDetailController *detailVC = [YXOrderListDetailController initWithOrderListInfo:arr[indexPath.row]];
    detailVC.controllerInfo = _controllerInfo;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


@end
