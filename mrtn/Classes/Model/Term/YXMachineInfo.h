//
//  机具信息
//
//  Created by Mac on 15/12/21.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@protocol YXMachineInfo

@end

@interface YXMachineInfo : JSONModel

@property (nonatomic,strong)NSString<Optional> *batchId;
@property (nonatomic,strong)NSString<Optional> *elongsTo;
@property (nonatomic,strong)NSString<Optional> *hostSerialNo;
@property (nonatomic,strong,getter=theId)NSString<Optional> *id;
@property (nonatomic,strong)NSString<Optional> *instId;
@property (nonatomic,strong)NSString<Optional> *instName;
@property (nonatomic,strong)NSString<Optional> *instanceid;
@property (nonatomic,strong)NSString<Optional> *isLinked;
@property (nonatomic,strong)NSString<Optional> *locked;
@property (nonatomic,strong)NSString<Optional> *mhAddr;
@property (nonatomic,strong)NSString<Optional> *mhFactory;
@property (nonatomic,strong)NSString<Optional> *mhFactoryName;
@property (nonatomic,strong)NSString<Optional> *mhId;
@property (nonatomic,strong)NSString<Optional> *mhLat;
@property (nonatomic,strong)NSString<Optional> *mhLong;
@property (nonatomic,strong)NSString<Optional> *mhModel;
@property (nonatomic,strong)NSString<Optional> *mhStatus;
@property (nonatomic,strong)NSString<Optional> *mhType;
@property (nonatomic,strong)NSString<Optional> *mhTypeName;
@property (nonatomic,strong)NSString<Optional> *nodeVersion;
@property (nonatomic,strong)NSString<Optional> *nodeid;
@property (nonatomic,strong)NSString<Optional> *opTime;
@property (nonatomic,strong)NSString<Optional> *opType;
@property (nonatomic,strong,getter=theOperator)NSString<Optional> *operator;
@property (nonatomic,strong)NSString<Optional> *operatorName;
@property (nonatomic,strong)NSString<Optional> *partnerId;
@property (nonatomic,strong)NSString<Optional> *partnerName;
@property (nonatomic,strong)NSString<Optional> *track;

@end
