//
//  商户详情,用于YXQueryViewController
//
//  Created by Mac on 15/11/16.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@protocol YXMerchantInfo

@end

@interface YXMerchantInfo : JSONModel

@property (nonatomic,strong) NSString<Optional> *createTime;//
@property (nonatomic,strong) NSString<Optional> *diners;// 大莱
@property (nonatomic,strong) NSString<Optional> *elongsTo;
@property (nonatomic,strong) NSString<Optional> *express;
@property (nonatomic,strong, getter = theId)NSString<Optional> *id;
@property (nonatomic,strong) NSString<Optional> *instId;// 机构编号
@property (nonatomic,strong) NSString<Optional> *instName;// 机构名称
@property (nonatomic,strong) NSString<Optional> *instanceid;
@property (nonatomic,strong) NSString<Optional> *isTempSave;
@property (nonatomic,strong) NSString<Optional> *jcb;
@property (nonatomic,strong) NSString<Optional> *master;
@property (nonatomic,strong) NSString<Optional> *mcAddr;// 注册地址
@property (nonatomic,strong) NSString<Optional> *mcArea;
@property (nonatomic,strong) NSString<Optional> *mcBhdjkFee;
@property (nonatomic,strong) NSString<Optional> *mcBhdjkFeeMax;
@property (nonatomic,strong) NSString<Optional> *mcBhjjkFee;
@property (nonatomic,strong) NSString<Optional> *mcBhjjkFeeMax;
@property (nonatomic,strong) NSString<Optional> *mcCapital;
@property (nonatomic,strong) NSString<Optional> *mcFeedate;
@property (nonatomic,strong) NSString<Optional> *mcHours;
@property (nonatomic,strong) NSString<Optional> *mcId;// 商户编号
@property (nonatomic,strong) NSString<Optional> *mcIstownMcc;
@property (nonatomic,strong) NSString<Optional> *mcLand;
@property (nonatomic,strong) NSString<Optional> *mcLglidno;// 法人证件号码
@property (nonatomic,strong) NSString<Optional> *mcLglidtp;// 法人证件类型
@property (nonatomic,strong) NSString<Optional> *mcLglnam;// 法人代表姓名
@property (nonatomic,strong) NSString<Optional> *mcLgltel;// 法人联系电话
@property (nonatomic,strong) NSString<Optional> *mcLicenseNo;
@property (nonatomic,strong) NSString<Optional> *mcLinknm;// 商户联系人
@property (nonatomic,strong) NSString<Optional> *mcMcc;
@property (nonatomic,strong) NSString<Optional> *mcModel;
@property (nonatomic,strong) NSString<Optional> *mcMprofit;
@property (nonatomic,strong) NSString<Optional> *mcName;// 商户名称
@property (nonatomic,strong) NSString<Optional> *mcNature;// 商户性质0国营;1集体;2私营;3合资;4股份制;5个体工商户;6其它
@property (nonatomic,strong) NSString<Optional> *mcOparea;// 经营范围
@property (nonatomic,strong) NSString<Optional> *mcOpnbnk;
@property (nonatomic,strong) NSString<Optional> *mcOrgcode;// 组织机构代码证号
@property (nonatomic,strong) NSString<Optional> *mcRegional;
@property (nonatomic,strong) NSString<Optional> *mcSection;
@property (nonatomic,strong) NSString<Optional> *mcSettleNature;
@property (nonatomic,strong) NSString<Optional> *mcSettleact;
@property (nonatomic,strong) NSString<Optional> *mcSettlenam;
@property (nonatomic,strong) NSString<Optional> *mcSetupDate;// 成立日期
@property (nonatomic,strong) NSString<Optional> *mcStatus;// 商户状态0：正常；1：撤机；2：可疑
@property (nonatomic,strong) NSString<Optional> *mcTaxNo;// 税务登记证号
@property (nonatomic,strong) NSString<Optional> *mcTel;// 商户联系电话
@property (nonatomic,strong) NSString<Optional> *mcThdjkFee;
@property (nonatomic,strong) NSString<Optional> *mcThdjkFeeMax;
@property (nonatomic,strong) NSString<Optional> *mcThjjkFee;
@property (nonatomic,strong) NSString<Optional> *mcThjjkFeeMax;
@property (nonatomic,strong) NSString<Optional> *mcTypeId;
@property (nonatomic,strong) NSString<Optional> *partnerId;
@property (nonatomic,strong) NSString<Optional> *visa;
@property (nonatomic,strong) NSString<Optional> *yxMcId;

@end
