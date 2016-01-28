//
//  查询商户信息列表
//
//  Created by Mac on 15/11/16.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXQueryMcBookController.h"
#import "MBProgressHUD+Extension.h"
#import "YXQueryMerchantBookResponse.h"
#import "YXMerchantCell.h"
#import "YXMcDetailController.h"
#import "YXURLHelper.h"

@interface YXQueryMcBookController ()<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *merchantId;// 商户编号
@property (strong, nonatomic) IBOutlet UITextField *merchantName;// 商户名称
@property (strong, nonatomic) IBOutlet UITableView *table;// 显示结果的table
- (IBAction)query:(id)sender;// 查询

@end


@implementation YXQueryMcBookController {
    
    NSString *mcId;// 商户编号
    NSString *mcName;// 商户名称
    int currentPageNum;// 查询第几页
    int pageSize;// 每页多少条记录
    
    NSMutableArray<YXMerchantInfo> *arr;// 商户信息集合
    MBProgressHUD *progress;// 进度框

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商户查询列表";
    
}

// 查询
- (IBAction)query:(id)sender {
    
    [self.view endEditing:YES];
    mcId = self.merchantId.text;// 得到ID
    mcName = self.merchantName.text;// 得到商户名称
    currentPageNum = 0;// 设置第几页
    pageSize = 50;// 每页显示50条记录
    
    // 显示进度框
    progress = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];;
    progress.delegate = self;// 设置代理,用于移除
    progress.labelText = @"正在查询...";// 设置文本
    [self.navigationController.view addSubview:progress];// 显示
    
    // 请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;// 设置超时时间
    // 设置请求头,<<调试DEBUG>>用
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"android_request"];
    
    NSDictionary *parameters = @{@"mcId":mcId ,@"mcName":mcName ,@"currentPageNum":[NSString stringWithFormat:@"%d",currentPageNum] ,@"pageSize":[NSString stringWithFormat:@"%d",pageSize]};// 设置参数
    [manager POST:URL_QUERY_MCBOOK parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [progress hide:YES];// 隐藏读取框
        YXQueryMerchantBookResponse *rsp = [[YXQueryMerchantBookResponse alloc] initWithDictionary:responseObject error:nil];// 得到响应
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
    
    YXMerchantCell *cell = [YXMerchantCell cellWithTableView:self.table];
    cell.merchantInfo = arr[indexPath.row];
    return cell;
    
}

// 点击cell执行方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXMcDetailController *detailVC = [YXMcDetailController initWithMerchantInfo:arr[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


@end
