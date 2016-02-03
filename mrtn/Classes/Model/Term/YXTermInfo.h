//
//  机具信息(用于商户详情)
//
//  Created by Mac on 15/12/25.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@protocol YXTermInfo

@end

@interface YXTermInfo : JSONModel

@property (nonatomic,strong)NSString<Optional> *historyAddr;
@property (nonatomic,strong)NSString<Optional> *historyLat;
@property (nonatomic,strong)NSString<Optional> *historyLong;
@property (nonatomic,strong)NSString<Optional> *hostSerialNo;
@property (nonatomic,strong)NSString<Optional> *id;
@property (nonatomic,strong,getter=theInitAddr)NSString<Optional> *initAddr;
@property (nonatomic,strong,getter=theInitLat)NSString<Optional> *initLat;
@property (nonatomic,strong,getter=theInitLong)NSString<Optional> *initLong;
@property (nonatomic,strong)NSString<Optional> *instId;
@property (nonatomic,strong)NSString<Optional> *instName;
@property (nonatomic,strong)NSString<Optional> *isKeyboard;
@property (nonatomic,strong)NSString<Optional> *isManual;
@property (nonatomic,strong)NSString<Optional> *mcId;
@property (nonatomic,strong)NSString<Optional> *mcSalesMan;// 业务人员
@property (nonatomic,strong)NSString<Optional> *mcServicesMan;// 维护人员
@property (nonatomic,strong)NSString<Optional> *mhDeposit;
@property (nonatomic,strong)NSString<Optional> *mhFactory;
@property (nonatomic,strong)NSString<Optional> *mhId;// 终端号
@property (nonatomic,strong)NSString<Optional> *mhModel;
@property (nonatomic,strong)NSString<Optional> *mhType;
@property (nonatomic,strong,getter=theNewAddr)NSString<Optional> *newAddr;
@property (nonatomic,strong,getter=theNewLat)NSString<Optional> *newLat;
@property (nonatomic,strong,getter=theNewLong)NSString<Optional> *newLong;
@property (nonatomic,strong)NSString<Optional> *returnDeposit;
@property (nonatomic,strong)NSString<Optional> *salesManName;
@property (nonatomic,strong)NSString<Optional> *servicesManName;
@property (nonatomic,strong)NSString<Optional> *termAddr;// 装机地址
@property (nonatomic,strong)NSString<Optional> *termId;
@property (nonatomic,strong)NSString<Optional> *termLinknm;
@property (nonatomic,strong)NSString<Optional> *termLinktel;
@property (nonatomic,strong)NSString<Optional> *termStatus;
@property (nonatomic,strong)NSString<Optional> *termTel;
@property (nonatomic,strong)NSString<Optional> *termType;

@end
