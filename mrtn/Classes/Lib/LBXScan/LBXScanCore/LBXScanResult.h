//
//  扫码的结果
//  github:https://github.com/MxABC/LBXScan
//
//  Created by lbxia on 15/11/17.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBXScanResult : NSObject


- (instancetype)initWithScanString:(NSString*)str imgScan:(UIImage*)img barCodeType:(NSString*)type;
@property (nonatomic, strong) NSString *strScanned;// 扫码字符串
@property (nonatomic, strong) UIImage *imgScanned;// 扫码图像
/**
 @brief  扫码码的类型,AVMetadataObjectType  如AVMetadataObjectTypeQRCode，AVMetadataObjectTypeEAN13Code等
         如果使用ZXing扫码，返回类型也已经转换成对应的AVMetadataObjectType
 */
@property (nonatomic, strong) NSString *strBarCodeType;


@end
