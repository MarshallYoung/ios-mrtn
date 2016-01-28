//
//  任务单信息
//
//  Created by Mac on 15/12/22.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#define UNDONE @"1" // 未办结
#define DONE @"2" // 办结
#define TASK_TRAIN 001 // 培训任务单
#define TASK_VISIT 002 // 走访回访单
#define TASK_SURVEY 003 // 风险调查单
#define TASK_BANK 004 // 发卡行调单
#define TASK_DISTRIBUTION 006 // 耗材配送任务单
#define TASK_REPAIR 007 // 报修任务单
#define TASK_APPLY 009 // 装机申请任务单
#define TASK_INSTALL 008 // 装机任务单
#define TASK_RISK 010 // 补充进件材料单

#import "JSONModel.h"
#import "YXTaskTrainDetail.h"
#import "YXTaskVisitDetail.h"
#import "YXTaskSurveyDetail.h"
#import "YXTaskDistributionDetail.h"
#import "YXTaskRepairDetail.h"
#import "YXTaskBankDetail.h"
#import "YXTaskApplyDetail.h"
#import "YXTaskInstallDetail.h"
#import "YXTaskRiskDetail.h"

@protocol YXTaskOrderInfo

@end


@interface YXTaskOrderInfo : JSONModel

@property (nonatomic,strong)NSString<Optional> *attachment;// 附件图片
@property (nonatomic,strong)NSString<Optional> *completionTime;
@property (nonatomic,strong)NSString<Optional> *createTime;
@property (nonatomic,strong)NSString<Optional> *createTime_begin;
@property (nonatomic,strong)NSString<Optional> *createTime_end;
@property (nonatomic,strong)NSString<Optional> *disptTime;// 派工日期
@property (nonatomic,strong)NSString<Optional> *handleTime;// 处理时限
@property (nonatomic,strong)NSString<Optional> *instId;
@property (nonatomic,strong)NSString<Optional> *instName;
@property (nonatomic,strong)NSString<Optional> *mcAddr;// 商户地址
@property (nonatomic,strong)NSString<Optional> *mcId;// 商户编号
@property (nonatomic,strong)NSString<Optional> *mcName;// 商户名称
@property (nonatomic,strong)NSString<Optional> *mcSalesMan;
@property (nonatomic,strong)NSString<Optional> *mcServicesMan;
@property (nonatomic,strong)NSString<Optional> *mcTypeId;
@property (nonatomic,strong)NSString<Optional> *mcTypeIdName;
@property (nonatomic,strong)NSString<Optional> *mhType;// 机具类型
@property (nonatomic,strong)NSString<Optional> *mhTypeName;
@property (nonatomic,strong)NSString<Optional> *operator;
@property (nonatomic,strong)NSString<Optional> *operatorName;
@property (nonatomic,strong)NSString<Optional> *operatorType;
@property (nonatomic,strong)NSString<Optional> *partnerId;
@property (nonatomic,strong)NSString<Optional> *partnerName;
@property (nonatomic,strong)NSString<Optional> *predictTime;
@property (nonatomic,strong)NSString<Optional> *servicesManName;
@property (nonatomic,strong)NSString<Optional> *sign;// 电子签名
@property (nonatomic,strong)YXTaskApplyDetail<Optional> *taskApplyDetail;// 装机申请单
@property (nonatomic,strong)YXTaskBankDetail<Optional> *taskBankDetail;// 发卡行调单
@property (nonatomic,strong)YXTaskDistributionDetail<Optional> *taskDistributionDetail;// 配送耗材
@property (nonatomic,strong)NSString<Optional> *taskId;// 任务单编号
@property (nonatomic,strong)YXTaskInstallDetail<Optional> *taskInstallDetail;// 装机任务单
@property (nonatomic,strong)NSString<Optional> *taskName;// 任务单名称
@property (nonatomic,strong)YXTaskRepairDetail<Optional> *taskRepairDetail;// 故障报修
@property (nonatomic,strong)YXTaskRiskDetail<Optional> *taskRiskDetail;// 补充进件材料
@property (nonatomic,strong)NSString<Optional> *taskStatus;
@property (nonatomic,strong)YXTaskSurveyDetail<Optional> *taskSurveyDetail;// 风险商户调查单
@property (nonatomic,strong)NSString<Optional> *taskType;
@property (nonatomic,strong)YXTaskVisitDetail<Optional> *taskVisitDetail;// 走访回访单
@property (nonatomic,strong)NSString<Optional> *termId;// 终端编号
@property (nonatomic,strong)NSString<Optional> *termStatus;
@property (nonatomic,strong)NSString<Optional> *termStatusName;// 终端状态
@property (nonatomic,strong)NSString<Optional> *termTaddr;// 装机地址
@property (nonatomic,strong)NSString<Optional> *termTlinknm;// 终端联系人
@property (nonatomic,strong)NSString<Optional> *termTlinktel;
@property (nonatomic,strong)NSString<Optional> *yxMcId;
@property (nonatomic,strong)YXTaskTrainDetail<Optional> *taskTrainDetail;// 培训

@end
