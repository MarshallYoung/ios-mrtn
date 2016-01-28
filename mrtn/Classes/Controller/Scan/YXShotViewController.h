//
//  条码二维码扫描
//  github:https://github.com/MxABC/LBXScan
//
//  Created by lbxia on 15/10/21.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "LBXScanView.h"
#import "LBXScanWrapper.h"

@interface YXShotViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) LBXScanWrapper* scanObj;// 扫码功能封装对象

#pragma mark - 扫码界面效果及提示等
@property (nonatomic,strong) LBXScanView* qRScanView;// 扫码区域视图,二维码一般都是框
@property(nonatomic,strong)UIImage* scanImage;// 扫码当前图片
@property (nonatomic, strong) LBXScanViewStyle *style;// 界面效果参数
@property(nonatomic,assign)BOOL isOpenInterestRect;// 启动区域识别功能

#pragma mark - 多功能界面
@property (nonatomic, assign) BOOL isMultifunction;// 是否为多功能界面
@property (nonatomic, strong) UILabel *topTitle;// 扫码区域上方提示文字
@property(nonatomic,assign)BOOL isOpenFlash;//  闪关灯开启状态

#pragma mark - 底部几个功能：开启闪光灯、相册、我的二维码
@property (nonatomic, strong) UIView *bottomItemsView;//底部显示的功能项
@property (nonatomic, strong) UIButton *btnPhoto;// 相册
@property (nonatomic, strong) UIButton *btnFlash;// 闪光灯
@property (nonatomic, strong) UIButton *btnMyQR;// 我的二维码


@end
