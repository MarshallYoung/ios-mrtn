//
//  用于OrderListInfo
//
//  Created by Mac on 15/12/22.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@protocol YXTaskVisitDetail

@end

@interface YXTaskVisitDetail : JSONModel

@property (nonatomic,strong)NSString<Optional> *externalChange;// 周边环境的重大变化
@property (nonatomic,strong)NSString<Optional> *internalChange;// 内部经营环境的重大变化
@property (nonatomic,strong)NSString<Optional> *managementChange;// 管理层人员变动情况
@property (nonatomic,strong)NSString<Optional> *managementName;// 变更后姓名
@property (nonatomic,strong)NSString<Optional> *managementTel;// 变更后电话
@property (nonatomic,strong,getter = theNewAddr)NSString<Optional> *newAddr;// 不修改getter,字段不让用new开头
@property (nonatomic,strong,getter = theNewLat)NSString<Optional> *newLat;
@property (nonatomic,strong,getter = theNewLong)NSString<Optional> *newLong;
@property (nonatomic,strong)NSString<Optional> *otherRisk;// 其他可能造成风险的情况
@property (nonatomic,strong)NSString<Optional> *personQualityChange;// 收银员变化情况及综合素质
@property (nonatomic,strong)NSString<Optional> *posIsAddr;// 安装Pos店面地址
@property (nonatomic,strong)NSString<Optional> *posNewAddr;// 变更后地址
@property (nonatomic,strong)NSString<Optional> *posPositionChange;// Pos机摆放位置
@property (nonatomic,strong)NSString<Optional> *result;// 处理结果
@property (nonatomic,strong)NSString<Optional> *statusChange;// 经营状况的重大变化
@property (nonatomic,strong)NSString<Optional> *stockException;// 退货明细及库存清单是否异常
@property (nonatomic,strong)NSString<Optional> *taskId;
@property (nonatomic,strong)NSString<Optional> *turnoverAvg;// 本店面近三个月月均营业额
@property (nonatomic,strong)NSString<Optional> *visitDate;// 本次回访日期
@property (nonatomic,strong)NSString<Optional> *visitLastDate;// 上次回访日期

@end
