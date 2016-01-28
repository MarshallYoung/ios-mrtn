//
//  扫描
//
//  Created by Mac on 15/11/30.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXScanViewController.h"
#import "YXShotViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "YXUpdateRequest.h"
#import "MBProgressHUD+Extension.h"
#import "YXURLHelper.h"
#import "YXQueryMachineResponse.h"
#import "YXUploadScanResponse.h"
#import "YXEncryptHelper.h"

@interface YXScanViewController ()<CLLocationManagerDelegate,MBProgressHUDDelegate>

@property (strong, nonatomic) IBOutlet UITextField *mcIdL;// 商户编号
@property (strong, nonatomic) IBOutlet UITextField *termIdL;// 终端编号
@property (strong, nonatomic) IBOutlet UITextField *hostSerialNoL;// 机具序列号(一维条码)
@property (strong, nonatomic) IBOutlet UILabel *mhIdL;// 二维码
@property (strong, nonatomic) IBOutlet UILabel *mhLongL;// 经度
@property (strong, nonatomic) IBOutlet UILabel *mhLatL;// 纬度
@property (strong, nonatomic) IBOutlet UITextView *mhAddrL;// 位置(机具地址)
@property (strong, nonatomic) IBOutlet UILabel *mhFactoryNameL;// 机具厂商
@property (strong, nonatomic) IBOutlet UILabel *mhTypeNameL;// 机具类型
@property (strong, nonatomic) IBOutlet UILabel *mhModelL;// 机具型号
- (IBAction)scan:(id)sender;// 开始扫码
- (IBAction)upload:(id)sender;// 机具关联
- (IBAction)load:(id)sender;// 加载

@end


@implementation YXScanViewController {
    
    CLLocationManager *locManager;// 定位管理器
    NSString *_id;// 编号,用于UpdateRequest
    NSString *isManual;// 是否为手动（0自动，1手动）
    NSString *hostSerialNo;// 一维码
    NSString *mhId;// 二维码
    
    MBProgressHUD *progress;// 进度框
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫码";
    progress = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];;
    progress.delegate = self;// 设置代理,用于移除
    progress.labelText = @"正在获取位置...";// 设置文本
    [self.navigationController.view addSubview:progress];// 显示
    [self initializeLocationService];// 初始化定位
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.codeStr && [self.codeStyle isEqual: @"org.iso.Code128"]) {
        // 扫描一维条码,显示SN号
        self.hostSerialNoL.text = self.codeStr;
    }else if (self.codeStr && [self.codeStyle isEqual: @"org.iso.QRCode"]) {
        // 扫描二维码,显示二维码
        NSString *decodeStr = [YXEncryptHelper decryptQRCode:self.codeStr withKey:nil];
        self.mhIdL.text = decodeStr;
    }
    
}

// 打开扫描界面
- (IBAction)scan:(id)sender {
    
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 3;
    style.photoframeAngleW = 18;
    style.photoframeAngleH = 18;
    style.isNeedShowRetangle = NO;
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    // 配置线条图片
    UIImage *imgLine = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    style.animationImage = imgLine;
    YXShotViewController *vc = [YXShotViewController new];// 初始化界面
    vc.style = style;
    vc.isOpenInterestRect = YES;
    vc.isMultifunction = NO;// 关闭标题栏和底部按钮
    [self.navigationController pushViewController:vc animated:YES];

}

// 上传机具信息
- (IBAction)upload:(id)sender {
    NSString *mcId = self.mcIdL.text;
    NSString *termId = self.termIdL.text;
    hostSerialNo = self.hostSerialNoL.text;
    mhId = self.mhIdL.text;
    NSString *mhLong = self.mhLongL.text;
    NSString *mhLat = self.mhLatL.text;
    NSString *mhAddr = self.mhAddrL.text;
    if ([mcId isEmpty] || [termId isEmpty] || [hostSerialNo isEmpty] || [mhId isEmpty]) {
        [MBProgressHUD showFail:@"请补全信息"];
        return;
    }
    if ([_id isEmpty]) {
        [MBProgressHUD showFail:@"数据有误,请重新扫描机具"];
        return;
    }
    
    // 显示进度框
    progress = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];;
    progress.delegate = self;// 设置代理,用于移除
    progress.labelText = @"正在读取数据...";// 设置文本
    [self.navigationController.view addSubview:progress];// 显示
    // 发送请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;// 设置超时时间
    // 设置请求头,<<调试DEBUG>>用
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"android_request"];
    NSDictionary *parameters = @{@"mcId":mcId ,@"termId":termId ,@"hostSerialNo":hostSerialNo ,@"id":_id, @"mhId":mhId, @"mhLong":mhLong, @"mhLat":mhLat, @"mhAddr":mhAddr, @"isManual":@"1"};// 设置参数
    [manager POST:URL_SCAN_UPLOAD parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [progress hide:YES];// 隐藏读取框
        YXUploadScanResponse *rsp = [[YXUploadScanResponse alloc] initWithDictionary:responseObject error:nil];
        if ([rsp.success isEqual:@"1"]) {
            [MBProgressHUD showSuccess:@"绑定成功"];
        } else {
            if (rsp.msg) {
                [MBProgressHUD showFail:rsp.msg];
            } else {
                [MBProgressHUD showFail:@"绑定失败"];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD show408];
        YXLog(@"%@",error);
        
    }];
    
}

// 位置管理者代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
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
            [progress hide:YES];// 隐藏进度框
        }
        else if (error == nil && [array count] == 0) {
            [progress hide:YES];// 隐藏进度框
            [MBProgressHUD showFail:@"无法获取地址"];
        }
        else if (error != nil) {
            [progress hide:YES];// 隐藏进度框
            [MBProgressHUD showFail:@"无法获取地址"];
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}

// 初始化定位管理器
- (void)initializeLocationService {
    
    locManager = [[CLLocationManager alloc] init];// 初始化定位管理器
    locManager.delegate = self;// 设置代理
    locManager.desiredAccuracy = kCLLocationAccuracyBest;// 设置定位精确度到米
    locManager.distanceFilter = kCLDistanceFilterNone;// 设置过滤器为无
    // 开始定位,取得定位权限，有两个方法，取决于你的定位使用情况
    if([locManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [locManager performSelector:NSSelectorFromString(@"requestAlwaysAuthorization")];; // 永久授权
    }
    [locManager startUpdatingLocation];// 开始定位
    
}

// 加载
- (IBAction)load:(id)sender {
    
    [self.view endEditing:YES];
    hostSerialNo = self.hostSerialNoL.text;
    if ([hostSerialNo isEmpty]) {
        [MBProgressHUD showFail:@"请输入SN号"];
        return;
    }
    // 显示进度框
    progress = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];;
    progress.delegate = self;// 设置代理,用于移除
    progress.labelText = @"正在读取数据...";// 设置文本
    [self.navigationController.view addSubview:progress];// 显示
    
    // 请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;// 设置超时时间
    // 设置请求头,<<调试DEBUG>>用
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"android_request"];
    
    NSDictionary *parameters = @{@"hostSerialNo":hostSerialNo};// 设置参数
    [manager POST:URL_MACHINE parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [progress hide:YES];// 隐藏读取框
        YXQueryMachineResponse *rsp = [[YXQueryMachineResponse alloc] initWithDictionary:responseObject error:nil];
        if (rsp.success) {// 查询成功
            if (rsp.data != nil && ![rsp.data isKindOfClass:[NSNull class]] && rsp.data.count != 0) {// 存在数据
                YXMachineInfo *info = rsp.data[0];
                if (![hostSerialNo isEqual:info.hostSerialNo]) {// 不数据符合
                    [MBProgressHUD showFail:@"暂无结果"];
                    return;
                }
                if (info.mhId) {
                    [MBProgressHUD showFail:@"机具已经关联"];
                    return;
                }
                _id = info.theId;
                self.mhFactoryNameL.text = info.mhFactoryName;
                self.mhTypeNameL.text = info.mhTypeName;
                self.mhModelL.text = info.mhModel;
            } else {
                [MBProgressHUD showFail:@"暂无结果"];
            }
        } else {
            [MBProgressHUD showFail:@"暂无结果"];
        }
        YXLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD showFail:@"服务器无响应,请联系服务人员"];
    }];
    
}


@end
