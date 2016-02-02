//
//  商户信息列表
//
//  Created by Mac on 15/11/16.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXMerchantListController.h"
#import "YXNetworkingManager.h"
#import "MBProgressHUD+Extension.h"
#import "YXMerchantListRequest.h"
#import "YXMerchantListResponse.h"
#import "YXMerchantCell.h"
#import "YXMerchantDetailController.h"



@interface YXMerchantListController ()<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *mcIdF;// 商户编号
@property (strong, nonatomic) IBOutlet UITextField *mcNameF;// 商户名称
@property (strong, nonatomic) IBOutlet UITableView *table;// 显示结果的table
- (IBAction)query:(id)sender;// 查询

@end


@implementation YXMerchantListController {
    
    NSMutableArray<YXMerchantInfo> *arr;// 商户信息集合
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商户查询列表";
    
}

// 查询
- (IBAction)query:(id)sender {
    
    
    [self.view endEditing:YES];
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self text:@"正在查询..."];// 读取框
    NSString *mcId   = self.mcIdF.text;// 得到ID
    NSString *mcName = self.mcNameF.text;// 得到商户名称
    YXMerchantListRequest *request = [YXMerchantListRequest requestWithId:mcId name:mcName];// 得到请求
    [YXNetworkingManager queryWithRequest:request success:^(id responseObject) {
        [progress hide:YES];// 隐藏读取框
        YXMerchantListResponse *response = [[YXMerchantListResponse alloc] initWithDictionary:responseObject error:nil];// 得到响应
        if (response.success) {
            arr = response.data;// 设置数据
            [self.table reloadData];// 刷新数据源
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
    
    YXMerchantCell *cell = [YXMerchantCell cellWithTableView:self.table];
    cell.merchantInfo = arr[indexPath.row];
    return cell;
    
}

// 点击cell执行方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXMerchantDetailController *controller = [YXMerchantDetailController initWithMerchantInfo:arr[indexPath.row]];
    [self.navigationController pushViewController:controller animated:YES];
    
}


@end
