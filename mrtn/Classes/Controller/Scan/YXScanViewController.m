//
//  扫描
//
//  Created by Mac on 15/11/30.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXScanViewController.h"
#import "YXNetworkingManager.h"
#import "MBProgressHUD+Extension.h"
#import <CoreLocation/CoreLocation.h>
#import "YXEncryptHelper.h"
#import "YXShotViewController.h"
#import "YXTermRequest.h"
#import "YXTermResponse.h"
#import "YXUpdateTermRequest.h"
#import "YXUpdateTermResponse.h"

@interface YXScanViewController ()<CLLocationManagerDelegate,MBProgressHUDDelegate>

@property (strong, nonatomic) IBOutlet UITextField *mcIdF;// 商户编号
@property (strong, nonatomic) IBOutlet UITextField *termIdF;// 终端编号
@property (strong, nonatomic) IBOutlet UITextField *hostSerialNoF;// 机具序列号(一维条码)
@property (strong, nonatomic) IBOutlet UILabel     *mhIdL;// 二维码
@property (strong, nonatomic) IBOutlet UILabel     *mhFactoryNameL;// 机具厂商
@property (strong, nonatomic) IBOutlet UILabel     *mhTypeNameL;// 机具类型
@property (strong, nonatomic) IBOutlet UILabel     *mhModelL;// 机具型号
@property (strong, nonatomic) IBOutlet UILabel     *mhLongL;// 经度
@property (strong, nonatomic) IBOutlet UILabel     *mhLatL;// 纬度
@property (strong, nonatomic) IBOutlet UITextView  *mhAddrL;// 位置(机具地址)
@property (strong, nonatomic) CLLocationManager  *manager;
- (IBAction)scan:(id)sender;// 开始扫码
- (IBAction)upload:(id)sender;// 机具关联
- (IBAction)load:(id)sender;// 加载

@end


@implementation YXScanViewController {
    
    NSString *_id;// 编号,用于UpdateRequest
    MBProgressHUD *hud;// 读取框
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫码";
    [self initializeLocationService];// 初始化定位
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.codeStr && [self.codeStyle isEqual: @"org.iso.Code128"]) {
        // 扫描一维条码,显示SN号
        self.hostSerialNoF.text = self.codeStr;
    }else if (self.codeStr && [self.codeStyle isEqual: @"org.iso.QRCode"]) {
        // 扫描二维码,显示二维码
        NSString *decodeStr = [YXEncryptHelper decryptQRCode:self.codeStr withKey:nil];
        self.mhIdL.text = decodeStr;
    }
    
}


// 加载
- (IBAction)load:(id)sender {
    
    [self.view endEditing:YES];
    NSString *hostSerialNo = self.hostSerialNoF.text;
    if ([hostSerialNo isEmpty]) {
        [MBProgressHUD showFail:@"请输入SN号"];
        return;
    }
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self text:@"正在查询..."];// 进度框
    YXTermRequest *request = [YXTermRequest requestWithSN:hostSerialNo];
    [YXNetworkingManager queryWithRequest:request success:^(id responseObject) {
        YXLog(@"机具信息 : %@",responseObject);
        [progress hide:YES];// 隐藏读取框
        YXTermResponse *response = [[YXTermResponse alloc] initWithDictionary:responseObject error:nil];
        if (response.success) {// 查询成功
            if (response.data == nil || response.data == nil || response.data.count == 0) {// 不存在数据
                [MBProgressHUD showFail:@"暂无结果"];
                return;
            }
            YXMachineInfo *info = response.data[0];
            if (![hostSerialNo isEqual:info.hostSerialNo]) {// 数据不符
                [MBProgressHUD showFail:@"暂无结果"];
                return;
            }
            if (info.mhId) {// 存在关联二维码
                [MBProgressHUD showFail:@"机具已关联"];
                return;
            }
            _id = info.theId;
            self.mhFactoryNameL.text = info.mhFactoryName;
            self.mhTypeNameL.text    = info.mhTypeName;
            self.mhModelL.text       = info.mhModel;
        } else {
            [MBProgressHUD showFail:@"暂无结果"];
        }
    } failure:^(void) {
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD show408];
    }];
    
}

// 打开扫描界面
- (IBAction)scan:(id)sender {
    
    //设置扫码区域参数
    LBXScanViewStyle *style    = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset       = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW      = 3;
    style.photoframeAngleW     = 18;
    style.photoframeAngleH     = 18;
    style.isNeedShowRetangle   = NO;
    style.anmiationStyle       = LBXScanViewAnimationStyle_LineMove;
    // 配置线条图片
    UIImage *imgLine           = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    style.animationImage       = imgLine;
    YXShotViewController *vc   = [YXShotViewController new];// 初始化界面
    vc.style                   = style;
    vc.isOpenInterestRect      = YES;
    vc.isMultifunction         = NO;// 关闭标题栏和底部按钮
    [self.navigationController pushViewController:vc animated:YES];

}

// 上传机具信息
- (IBAction)upload:(id)sender {
    
    if ([self.mcIdF.text isEmpty] ||
        [self.termIdF.text isEmpty] ||
        [self.hostSerialNoF.text isEmpty] ||
        [self.mhIdL.text isEmpty]) {
        [MBProgressHUD showFail:@"请补全信息"];
        return;
    }
    if ([_id isEmpty]) {
        [MBProgressHUD showFail:@"请先加载机具信息"];
        return;
    }
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self text:@"正在关联..."];// 进度框
    YXUpdateTermRequest *request = [[YXUpdateTermRequest alloc] init];
    request.mcId         = self.mcIdF.text;
    request.termId       = self.termIdF.text;
    request.hostSerialNo = self.hostSerialNoF.text;
    request.id           = _id;
    request.mhId         = self.mhIdL.text;
    request.mhLong       = self.mhLongL.text;
    request.mhLat        = self.mhLatL.text;
    request.mhAddr       = self.mhAddrL.text;
    YXLog(@"请求 : %@",request);
    [YXNetworkingManager updateWithRequest:request success:^(id responseObject) {
        YXLog(@"商户关联 : %@",responseObject);
        [progress hide:YES];// 隐藏读取框
        YXUpdateTermResponse *response = [[YXUpdateTermResponse alloc] initWithDictionary:responseObject error:nil];
        if ([response.success isEqual:@"1"]) {
            [MBProgressHUD showSuccess:@"绑定成功"];
        } else {
            if (response.msg) {
                [MBProgressHUD showFail:response.msg];
            } else {
                [MBProgressHUD showFail:@"绑定失败"];
            }
        }
    } failure:^(void) {
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD show408];
    }];
    
}

/**
 *  获取位置成功执行方法
 *
 *  @param manager   位置管理器
 *  @param locations 位置信息
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = [locations lastObject];
    //将经度和纬度显示到label上
    self.mhLongL.text = [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
    self.mhLatL.text = [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
    // 获取所在城市
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //将获得的所有信息显示到label上
            self.mhAddrL.text = placemark.name;
            [hud hide:YES];// 隐藏进度框
        }
        else if (error == nil && [array count] == 0) {
            [hud hide:YES];// 隐藏进度框
            [MBProgressHUD showFail:@"无法获取地址"];
        }
        else if (error != nil) {
            [hud hide:YES];// 隐藏进度框
            [MBProgressHUD showFail:@"无法获取地址"];
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}

/**
 *  获取位置失败执行方法
 *
 *  @param manager 位置管理器
 *  @param error   错误
 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [hud hide:YES];// 隐藏进度框
    [MBProgressHUD showFail:@"无法获取地址"];
    [manager stopUpdatingLocation];
}

// 初始化定位管理器
- (void)initializeLocationService {
    
    hud = [MBProgressHUD showHUDAddedTo:self text:@"获取位置信息..."];
    self.manager = [[CLLocationManager alloc] init];// 初始化定位管理器
    self.manager.delegate           = self;// 设置代理
    self.manager.desiredAccuracy    = kCLLocationAccuracyBest;// 设置定位精确度到米
    self.manager.distanceFilter     = kCLDistanceFilterNone;// 设置过滤器为无
    // 开始定位,取得定位权限，有两个方法，取决于你的定位使用情况
    if([self.manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.manager performSelector:NSSelectorFromString(@"requestAlwaysAuthorization")];; // 永久授权
    }
//    [self.manager requestAlwaysAuthorization];
    [self.manager startUpdatingLocation];// 开始定位
    
}


@end
