//
//  商户信息详情,用于YXMcDetailController
//
//  Created by Mac on 15/12/24.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"
#import "YXTermInfo.h"

@interface YXMerchantDetailInfo : JSONModel

@property (nonatomic,strong)NSString<Optional> *createTime;
@property (nonatomic,strong)NSMutableArray<Optional> *docs;
@property (nonatomic,strong)NSString<Optional> *elongsTo;
@property (nonatomic,strong)NSString<Optional> *id;
@property (nonatomic,strong)NSString<Optional> *instId;
@property (nonatomic,strong)NSString<Optional> *instName;
@property (nonatomic,strong)NSString<Optional> *instanceid;
@property (nonatomic,strong)NSString<Optional> *isTempSave;
@property (nonatomic,strong)NSString<Optional> *locked;
@property (nonatomic,strong)NSString<Optional> *mcAddr;
@property (nonatomic,strong)NSString<Optional> *mcArea;
//@property (nonatomic,strong)NSString<Optional> *mcBaseInfo;
@property (nonatomic,strong)NSString<Optional> *mcCapital;
@property (nonatomic,strong)NSString<Optional> *mcHours;
@property (nonatomic,strong)NSString<Optional> *mcId;
@property (nonatomic,strong)NSString<Optional> *mcLand;
@property (nonatomic,strong)NSString<Optional> *mcLglidno;
@property (nonatomic,strong)NSString<Optional> *mcLglidtp;
@property (nonatomic,strong)NSString<Optional> *mcLglnam;
@property (nonatomic,strong)NSString<Optional> *mcLgltel;
@property (nonatomic,strong)NSString<Optional> *mcLicenseNo;
@property (nonatomic,strong)NSString<Optional> *mcLinknm;
@property (nonatomic,strong)NSString<Optional> *mcModel;
@property (nonatomic,strong)NSString<Optional> *mcMprofit;
@property (nonatomic,strong)NSString<Optional> *mcName;
@property (nonatomic,strong)NSString<Optional> *mcNature;
@property (nonatomic,strong)NSString<Optional> *mcOparea;
@property (nonatomic,strong)NSString<Optional> *mcOpnbnk;
@property (nonatomic,strong)NSString<Optional> *mcOrgcode;
@property (nonatomic,strong)NSString<Optional> *mcRegional;
@property (nonatomic,strong)NSString<Optional> *mcSection;
@property (nonatomic,strong)NSString<Optional> *mcSettleNature;
@property (nonatomic,strong)NSString<Optional> *mcSettleact;
@property (nonatomic,strong)NSString<Optional> *mcSettlenam;
@property (nonatomic,strong)NSString<Optional> *mcSetupDate;
@property (nonatomic,strong)NSString<Optional> *mcStatus;
@property (nonatomic,strong)NSString<Optional> *mcTaxNo;
@property (nonatomic,strong)NSString<Optional> *mcTel;
@property (nonatomic,strong)NSString<Optional> *mcTypeId;
@property (nonatomic,strong)NSString<Optional> *mcTypeIdName;
@property (nonatomic,strong)NSString<Optional> *mcTypeName;
@property (nonatomic,strong)NSString<Optional> *nodeVersion;
@property (nonatomic,strong)NSString<Optional> *nodeid;
@property (nonatomic,strong)NSString<Optional> *partnerId;
@property (nonatomic,strong)NSString<Optional> *partnerName;
@property (nonatomic,strong)NSMutableArray<Optional> *rates;
@property (nonatomic,strong)NSMutableArray<YXTermInfo,Optional> *terms;
@property (nonatomic,strong)NSString<Optional> *track;
@property (nonatomic,strong)NSString<Optional> *yxMcId;

@end
