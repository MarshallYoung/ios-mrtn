//
//  任务单列表
//
//  Created by Mac on 15/12/18.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXOrderListController.h"
#import "YXNetworkingManager.h"
#import "MBProgressHUD+Extension.h"
#import "YXOrderListRequest.h"
#import "YXOrderListResponse.h"
#import "YXDatePicker.h"
#import "YXBacklogCell.h"
#import "YXOrderListDetailController.h"

@interface YXOrderListController ()<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *mcIdF;// 商户编号
@property (strong, nonatomic) IBOutlet UITextField *mcNameF;// 商户名称
@property (strong, nonatomic) IBOutlet UITextField *disptTimeF;// 派工时间
@property (strong, nonatomic) IBOutlet UITableView *table;// 结果
- (IBAction)datePicker:(id)sender;
- (IBAction)query:(id)sender;

@end


@implementation YXOrderListController {
    
    NSMutableArray<YXOrderListInfo> *arr;// 结果集合
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([_controllerInfo.mode isEqual:ORDER_BACKLOG]) {
        self.title = @"待办列表";
    }else if ([_controllerInfo.mode isEqual:ORDER_PROCESSED]) {
        self.title = @"办结列表";
    }
    
}

// 弹出日期选择器
- (IBAction)datePicker:(id)sender {
    
    [YXDatePicker initWithSuperView:self.view textField:self.disptTimeF confirm:^(NSString *dateString) {}];
    
}

// 查询
- (IBAction)query:(id)sender {
    
    [self.view endEditing:YES];
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self text:@"正在查询..."];// 读取框
    YXOrderListRequest *request = [[YXOrderListRequest alloc] init];
    request.mcId       = self.mcIdF.text;// 商户编号
    request.mcName     = self.mcNameF.text;// 商户名称
    request.disptTime  = self.disptTimeF.text;// 分配日期
    request.taskStatus = _controllerInfo.mode;// 任务单状态
    [YXNetworkingManager queryWithRequest:request success:^(id responseObject) {
        [progress hide:YES];// 隐藏读取框
        YXOrderListResponse *response = [[YXOrderListResponse alloc] initWithDictionary:responseObject error:nil];
        if (response.success) {
            arr = response.data;// 设置数据
            [self.table reloadData];
        }else{
            [MBProgressHUD showFail:response.msg];// 显示错误消息
        }
    } failure:^(void) {
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD show408];
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
    
    YXOrderListDetailController *controller = [YXOrderListDetailController initWithOrderListInfo:arr[indexPath.row]];
    controller.controllerInfo = _controllerInfo;
    [self.navigationController pushViewController:controller animated:YES];
    
}


@end
