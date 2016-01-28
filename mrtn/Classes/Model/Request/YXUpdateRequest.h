//
//  用于scanCodeUpdate的请求
//
//  Created by Mac on 15/12/8.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXUpdateRequest : NSObject

@property (nonatomic,strong) NSString *id;// ID编号
@property (nonatomic,strong) NSString *mhId;// 宇信ID（二维条码）
@property (nonatomic,strong) NSString *hostSerialNo;// 机具序列号（一维条码）
@property (nonatomic,strong) NSString *mhLat;// 纬度
@property (nonatomic,strong) NSString *mhLong;// 经度
@property (nonatomic,strong) NSString *mcId;// 商户编号
@property (nonatomic,strong) NSString *termId;// 终端编号
@property (nonatomic,strong) NSString *isManual;// 是否为手动（0自动，1手动）
@property (nonatomic,strong) NSString *mhAddr;// 机具地址

@end
