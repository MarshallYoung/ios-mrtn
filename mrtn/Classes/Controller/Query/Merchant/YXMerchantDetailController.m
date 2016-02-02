//
//  商户详情
//
//  Created by Mac on 15/12/8.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXMerchantDetailController.h"
#import "YXNetworkingManager.h"
#import "MBProgressHUD+Extension.h"
#import "YXMerchantDetailRequest.h"
#import "YXMerchantDetailResponse.h"
#import "YXTermCell.h"

@interface YXMerchantDetailController () <MBProgressHUDDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;// 根ScrollView
@property (strong, nonatomic) IBOutlet UILabel      *mcIdL;// 商户编号
@property (strong, nonatomic) IBOutlet UILabel      *mcNameL;// 商户名称
@property (strong, nonatomic) IBOutlet UILabel      *mcOrgcodeL;// 组织机构代码证号
@property (strong, nonatomic) IBOutlet UILabel      *mcTaxNoL;// 税务登记证号
@property (strong, nonatomic) IBOutlet UILabel      *mcAddrL;// 注册地址
@property (strong, nonatomic) IBOutlet UILabel      *mcSetupDateL;// 成立日期
@property (strong, nonatomic) IBOutlet UILabel      *mcLglnamL;// 法人代表姓名
@property (strong, nonatomic) IBOutlet UILabel      *mcLglidtpL;// 法人证件类型
@property (strong, nonatomic) IBOutlet UILabel      *mcLglidnoL;// 法人证件号码
@property (strong, nonatomic) IBOutlet UILabel      *mcLgltelL;// 法人联系电话
@property (strong, nonatomic) IBOutlet UILabel      *mcLinknmL;// 商户联系人
@property (strong, nonatomic) IBOutlet UILabel      *mcTelL;// 商户联系电话
@property (strong, nonatomic) IBOutlet UILabel      *mcNatureL;// 商户性质
@property (strong, nonatomic) IBOutlet UILabel      *mcOpareaL;// 经营范围
@property (strong, nonatomic) IBOutlet UILabel      *mcStatusL;// 商户状态
@property (strong, nonatomic) IBOutlet UILabel      *instNameL;// 机构名称

@end


@implementation YXMerchantDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商户详情";
    [self loadData];
    
}

/**
 *  到服务器请求数据
 */
- (void)loadData {
    
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self text:@"初始化数据..."];// 读取框
    YXMerchantDetailRequest *request = [YXMerchantDetailRequest requestWithId:_merchantInfo.theId];
    [YXNetworkingManager queryWithRequest:request success:^(id responseObject) {
        [progress hide:YES];// 隐藏读取框
        YXMerchantDetailResponse *rsp = [[YXMerchantDetailResponse alloc] initWithDictionary:responseObject error:nil];// 得到响应
        if (rsp.success) {
            YXMerchantDetailInfo *info = rsp.data;
            [self displayInfo:info];
        }else{
            [MBProgressHUD showFail:rsp.msg];// 显示错误消息
        }
    } failure:^(void) {
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD show408];
    }];
    
}

/**
 *  显示数据
 *
 *  @param info 商户详细信息
 */
- (void)displayInfo:(YXMerchantDetailInfo *)info {
    
    self.mcIdL.text = info.mcId;
    self.mcNameL.text = info.mcName;
    self.mcOrgcodeL.text = info.mcOrgcode;
    self.mcTaxNoL.text = info.mcTaxNo;
    self.mcAddrL.text = info.mcAddr;
    self.mcSetupDateL.text = info.mcSetupDate;
    self.mcLglnamL.text = info.mcLglnam;
    self.mcLglidtpL.text = info.mcLglidtp;
    self.mcLglidnoL.text = info.mcLglidno;
    self.mcLgltelL.text = info.mcLgltel;
    self.mcLinknmL.text = info.mcLinknm;
    self.mcTelL.text = info.mcTel;
    int nature = [info.mcNature intValue];//商户性质0国营;1集体;2私营;3合资;4股份制;5个体工商户;6其它
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
    self.mcOpareaL.text = info.mcOparea;
    int status = [info.mcStatus intValue];// 商户状态0：正常；1：撤机；2：可疑
    if (status == 0) {
        self.mcStatusL.text = @"正常";
    }else if(status == 1) {
        self.mcStatusL.text = @"撤机";
    }else if(status == 2) {
        self.mcStatusL.text = @"可疑";
    }
    self.instNameL.text = info.instName;
    NSMutableArray *array = info.terms;
    for (YXTermInfo *info in array) {
        [self.scrollView addBottomSubview:[YXTermCell initWithTermInfo:info]];
    }
    
}

/**
 *  初始化方法
 *
 *  @param merchantInfo 商户信息
 *
 *  @return 视图控制器
 */
+ (instancetype)initWithMerchantInfo:(YXMerchantInfo *)merchantInfo {
    
    YXMerchantDetailController *controller = [[YXMerchantDetailController alloc] init];
    controller.merchantInfo = merchantInfo;
    return controller;
    
}


@end
