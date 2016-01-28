//
//  条码二维码扫描
//  github:https://github.com/MxABC/LBXScan
//
//  Created by lbxia on 15/10/21.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "YXShotViewController.h"
#import "YXScanViewController.h"
#import "MBProgressHUD+Extension.h"

@interface YXShotViewController ()

@end

@implementation YXShotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫码";
    self.view.backgroundColor = [UIColor blackColor];// 设置背景为黑色
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self drawScanView];
    if (_isMultifunction) {
        // 开启多功能界面
        [self drawBottomItems];// 绘制底部功能按钮
        [self.view bringSubviewToFront:_topTitle];// 显示标题
    }else {
        _topTitle.hidden = YES;
    }
    [self performSelector:@selector(startScan) withObject:nil afterDelay:0.2];
    
}

// 绘制扫描区域
- (void)drawScanView {
    
    if (!_qRScanView) {// 懒加载
        CGRect rect = self.view.frame;
        rect.origin = CGPointMake(0, 0);
        self.qRScanView = [[LBXScanView alloc]initWithFrame:rect style:_style];// 初始化扫描视图
        [self.view addSubview:_qRScanView];
        // 显示提示文字
        self.topTitle = [[UILabel alloc]init];
        _topTitle.bounds = CGRectMake(0, 0, 145, 60);
        _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 50);
        if ([UIScreen mainScreen].bounds.size.height <= 568 ) {// 3.5inch iphone失陪低分辨率
            _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 38);
            _topTitle.font = [UIFont systemFontOfSize:14];
        }
        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"将取景框对准二维码即可自动扫描";
        _topTitle.textColor = [UIColor whiteColor];
        [self.view addSubview:_topTitle];
    }
    [_qRScanView startDeviceReadyingWithText:@"相机启动中"];
    
}

// 绘制底部功能按钮
- (void)drawBottomItems {
    
    if (_bottomItemsView) {
        return;
    }
    self.bottomItemsView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-164,CGRectGetWidth(self.view.frame), 100)];
    _bottomItemsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];// 设置透明背景
    [self.view addSubview:_bottomItemsView];
    CGSize size = CGSizeMake(65, 87);
    self.btnFlash = [[UIButton alloc]init];
    _btnFlash.bounds = CGRectMake(0, 0, size.width, size.height);
    _btnFlash.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)/2, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [_btnFlash addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];
    self.btnPhoto = [[UIButton alloc]init];
    _btnPhoto.bounds = _btnFlash.bounds;
    _btnPhoto.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)/4, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_nor"] forState:UIControlStateNormal];
    [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_down"] forState:UIControlStateHighlighted];
    [_btnPhoto addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    self.btnMyQR = [[UIButton alloc]init];
    _btnMyQR.bounds = _btnFlash.bounds;
    _btnMyQR.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame) * 3/4, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnMyQR setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_myqrcode_nor"] forState:UIControlStateNormal];
    [_btnMyQR setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_myqrcode_down"] forState:UIControlStateHighlighted];
    [_btnMyQR addTarget:self action:@selector(myQRCode) forControlEvents:UIControlEventTouchUpInside];
    [_bottomItemsView addSubview:_btnFlash];
    [_bottomItemsView addSubview:_btnPhoto];
    [_bottomItemsView addSubview:_btnMyQR];   
    
}

// 启动设备
- (void)startScan {
    
    if (![LBXScanWrapper isGetCameraPermission]) {
        [_qRScanView stopDeviceReadying];
        [self showError:@"   请到设置隐私中开启本程序相机权限   "];
        return;
    }
    if (!_scanObj ) {
        __weak __typeof(self) weakSelf = self;
         // AVMetadataObjectTypeQRCode   AVMetadataObjectTypeEAN13Code
        CGRect cropRect = CGRectZero;
        if (_isOpenInterestRect) {
            cropRect = [LBXScanView getScanRectWithPreView:self.view style:_style];
        }
        self.scanObj = [[LBXScanWrapper alloc]initWithPreView:self.view
        ArrayObjectType:nil cropRect:cropRect
        success:^(NSArray *array) {
            [weakSelf scanResultWithArray:array];
        }];
    }
    [_scanObj startScan];
    [_qRScanView stopDeviceReadying];
    [_qRScanView startScanAnimation];
    self.view.backgroundColor = [UIColor clearColor];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [_scanObj stopScan];
    [_qRScanView stopScanAnimation];
    
}

- (void)showError:(NSString*)str {
    
    [MBProgressHUD showFail:str];
    
}

// 打开相册
- (void)openLocalPhotoAlbum {
    
    if ([LBXScanWrapper isGetPhotoPermission]) {
        [self openLocalPhoto];
    } else {
        [self showError:@"      请到设置->隐私中开启本程序相册权限     "];
    }
    
}


- (void)scanResultWithArray:(NSArray*)array {
    
    if (array.count < 1) {
        [self popAlertMsgWithScanResult:nil];
        return;
    }
    
    LBXScanResult *scanResult = array[0];
    NSString *strResult = scanResult.strScanned;
    self.scanImage = scanResult.imgScanned;
    if (!strResult) {
        [self popAlertMsgWithScanResult:nil];
        return;
    }
    [LBXScanWrapper systemVibrate];//震动提醒
//    [LBXScanWrapper systemSound];//声音提醒
    YXScanViewController *rootVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    rootVC.codeStyle = scanResult.strBarCodeType;
    rootVC.codeStr = scanResult.strScanned;
    [self.navigationController popToViewController:rootVC animated:YES];
   
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult {
    
    if (!strResult) {// 未输入文字
        strResult = @"识别失败";
    }
    [MBProgressHUD showFail:strResult];
    
}

#pragma mark -底部功能项
//打开相册
- (void)openPhoto {
    
    [self openLocalPhoto];
    
}

//开关闪光灯
- (void)openOrCloseFlash {
    
    [_scanObj openOrCloseFlash];
    self.isOpenFlash =!self.isOpenFlash;
    if (self.isOpenFlash) {
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    } else {
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    }
    
}

// 我的二维码
- (void)myQRCode {
    
}

#pragma mark --打开相册并识别图片
+ (UIViewController*)getWindowTopViewController {
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
    
}

// 打开本地照片，选择图片识别
- (void)openLocalPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
    
}

//当选择一张图片后进入这里
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    __weak __typeof(self) weakSelf = self;
    [LBXScanWrapper recognizeImage:image success:^(NSArray *array) {
        [weakSelf scanResultWithArray:array];
    }];
    
    //系统自带识别方法
    /*
     CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
     NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
     if (features.count >=1)
     {
     CIQRCodeFeature *feature = [features objectAtIndex:0];
     NSString *scanResult = feature.messageString;
     
     NSLog(@"%@",scanResult);
     }
     */
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


@end
