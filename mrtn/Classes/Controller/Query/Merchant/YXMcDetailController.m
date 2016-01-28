//
//  商户详情
//
//  Created by Mac on 15/12/8.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXMcDetailController.h"
#import "MBProgressHUD+Extension.h"
#import "YXQueryMerchantDetailResponse.h"
#import "YXTermCell.h"
#import "YXURLHelper.h"

@interface YXMcDetailController () <MBProgressHUDDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;// 根ScrollView
@property (strong, nonatomic) IBOutlet UILabel *mcIdL;// 商户编号
@property (strong, nonatomic) IBOutlet UILabel *mcNameL;// 商户名称
@property (strong, nonatomic) IBOutlet UILabel *mcOrgcodeL;// 组织机构代码证号
@property (strong, nonatomic) IBOutlet UILabel *mcTaxNoL;// 税务登记证号
@property (strong, nonatomic) IBOutlet UILabel *mcAddrL;// 注册地址
@property (strong, nonatomic) IBOutlet UILabel *mcSetupDateL;// 成立日期
@property (strong, nonatomic) IBOutlet UILabel *mcLglnamL;// 法人代表姓名
@property (strong, nonatomic) IBOutlet UILabel *mcLglidtpL;// 法人证件类型
@property (strong, nonatomic) IBOutlet UILabel *mcLglidnoL;// 法人证件号码
@property (strong, nonatomic) IBOutlet UILabel *mcLgltelL;// 法人联系电话
@property (strong, nonatomic) IBOutlet UILabel *mcLinknmL;// 商户联系人
@property (strong, nonatomic) IBOutlet UILabel *mcTelL;// 商户联系电话
@property (strong, nonatomic) IBOutlet UILabel *mcNatureL;// 商户性质
@property (strong, nonatomic) IBOutlet UILabel *mcOpareaL;// 经营范围
@property (strong, nonatomic) IBOutlet UILabel *mcStatusL;// 商户状态
@property (strong, nonatomic) IBOutlet UILabel *instNameL;// 机构名称

@end


@implementation YXMcDetailController {
    
    YXMerchantDetailInfo *merchantDetailInfo;// 商户详细信息
    NSMutableArray<YXTermInfo> *arr;// 商户绑定的机具信息集合
    MBProgressHUD *progress;// 进度框
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商户详情";
    [self loadData];// 将数据显示在视图上
    
}

// 读取数据
- (void)loadData {
    
    // 显示进度框
    progress = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];;
    progress.delegate = self;// 设置代理,用于移除
    progress.labelText = @"初始化数据...";// 设置文本
    [self.navigationController.view addSubview:progress];// 显示
    
    // 请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10;// 设置超时时间
    // 设置请求头,<<调试DEBUG>>用
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"android_request"];
    
    NSDictionary *parameters = @{@"id":_merchantInfo.id};// 设置参数
    [manager POST:URL_QUERY_MERCHANT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [progress hide:YES];// 隐藏读取框
        YXQueryMerchantDetailResponse *rsp = [[YXQueryMerchantDetailResponse alloc] initWithDictionary:responseObject error:nil];// 得到响应
        if (rsp.success) {
            arr = rsp.data.terms;// 设置数据
            [self displayData];
        }else{
            [MBProgressHUD showFail:rsp.msg];// 显示错误消息
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD show408];
        
    }];
    
}

// 显示数据
- (void)displayData {
    
    self.mcIdL.text = _merchantInfo.mcId;
    self.mcNameL.text = _merchantInfo.mcName;
    self.mcOrgcodeL.text = _merchantInfo.mcOrgcode;
    self.mcTaxNoL.text = _merchantInfo.mcTaxNo;
    self.mcAddrL.text = _merchantInfo.mcAddr;
    self.mcSetupDateL.text = _merchantInfo.mcSetupDate;
    self.mcLglnamL.text = _merchantInfo.mcLglnam;
    self.mcLglidtpL.text = _merchantInfo.mcLglidtp;
    self.mcLglidnoL.text = _merchantInfo.mcLglidno;
    self.mcLgltelL.text = _merchantInfo.mcLgltel;
    self.mcLinknmL.text = _merchantInfo.mcLinknm;
    self.mcTelL.text = _merchantInfo.mcTel;
    int nature = [_merchantInfo.mcNature intValue];//商户性质0国营;1集体;2私营;3合资;4股份制;5个体工商户;6其它
    if (nature == 0) {
        self.mcNatureL.text = @"国营";
    }else if(nature == 1) {
        self.mcNatureL.text = @"集体";
    }else if(nature == 2) {
        self.mcNatureL.text = @"私营";
    }else if(nature == 3) {
        self.mcNatureL.text = @"合资";
    }else if(nature == 4) {
        self.mcNatureL.text = @"股份制";
    }else if(nature == 5) {
        self.mcNatureL.text = @"个体工商户";
    }else if(nature == 6) {
        self.mcNatureL.text = @"其它";
    }
    self.mcOpareaL.text = _merchantInfo.mcOparea;
    int status = [_merchantInfo.mcStatus intValue];// 商户状态0：正常；1：撤机；2：可疑
    if (status == 0) {
        self.mcStatusL.text = @"正常";
    }else if(status == 1) {
        self.mcStatusL.text = @"撤机";
    }else if(status == 2) {
        self.mcStatusL.text = @"可疑";
    }
    self.instNameL.text = _merchantInfo.instName;
    for (YXTermInfo *info in arr) {
        [self.scrollView addBottomSubview:[YXTermCell initWithTermInfo:info]];
    }
    
}

// 通过商户信息初始化
+ (instancetype)initWithMerchantInfo:(YXMerchantInfo *)merchantInfo {
    
    YXMcDetailController *detailVC = [[YXMcDetailController alloc] init];
    detailVC.merchantInfo = merchantInfo;
    return detailVC;
    
}


@end
