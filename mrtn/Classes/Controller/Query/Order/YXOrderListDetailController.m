//
//  任务单列表详情
//
//  Created by Mac on 15/12/23.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXOrderListDetailController.h"
#import "MBProgressHUD+Extension.h"
#import "YXURLHelper.h"
#import "YXQueryTaskOrderResponse.h"
#import "YXTaskOrderCell.h"
#import "YXOrderDetailController.h"

@interface YXOrderListDetailController ()<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table;

@end


@implementation YXOrderListDetailController {
    
    NSString *taskStatus;// 任务单状态
    NSMutableArray<YXTaskOrderInfo> *arr;// 结果集合
    NSString *predictTime;// 预计上门时间
    
    MBProgressHUD *progress;// 进度框

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"待办任务单列表";
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self loadData];// 显示数据
    
}

- (void)loadData {
    
    if (_controllerInfo.mode == ORDER_BACKLOG) {
        taskStatus = @"1";
    }else if (_controllerInfo.mode == ORDER_PROCESSED) {
        taskStatus = @"2";
    }
    
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
    
    NSDictionary *parameters = @{@"mcId":_orderInfo.mcid,@"taskStatus":taskStatus,@"mcName":_orderInfo.mcName,@"disptTime":@"",@"instId":@"",@"UserId":@""};// 设置参数
    [manager POST:URL_ORDERLIST_DETAIL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [progress hide:YES];// 隐藏读取框
        YXQueryTaskOrderResponse *rsp = [[YXQueryTaskOrderResponse alloc] initWithDictionary:responseObject error:nil];
        if (rsp.success) {
            arr = rsp.data;// 设置数据
            [self.table reloadData];
        }else{
            [MBProgressHUD showFail:rsp.msg];// 显示错误消息
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD showFail:@"服务器无响应,请联系服务人员"];
        
    }];
    
}

+ (instancetype)initWithOrderListInfo:(YXOrderListInfo *)orderInfo {
    
    YXOrderListDetailController *detailVC = [[YXOrderListDetailController alloc] init];
    detailVC.orderInfo = orderInfo;
    return detailVC;
    
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
    
    YXOrderDetailController *detailVC = [YXOrderDetailController initWithTaskOrderInfo:arr[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


@end
