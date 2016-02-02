//
//  YXTaskInstallDetail.h
//  yuchengapp
//
//  Created by Mac on 15/12/29.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@interface YXTaskInstallDetail : JSONModel

@property (nonatomic,strong)NSString<Optional> *taskId;// 任务单编号
@property (nonatomic,strong)NSString<Optional> *mcTermLocation;// 机具安放位置
@property (nonatomic,strong)NSString<Optional> *mcFilingDate;// 资料整理时间
@property (nonatomic,strong)NSString<Optional> *mcMarkDept;// 营销部门
@property (nonatomic,strong)NSString<Optional> *mcIsApprove;// 审批是否通过
@property (nonatomic,strong)NSString<Optional> *mcApproveDate;// 审批时间
@property (nonatomic,strong)NSString<Optional> *mcInstallDate;// 预计上门安装时间
@property (nonatomic,strong)NSString<Optional> *mcRefundDate;// 预计退还资料时间
@property (nonatomic,strong)NSString<Optional> *TermNum;// 装机台数
@property (nonatomic,strong)NSString<Optional> *paramMode;// 参数模式
@property (nonatomic,strong)NSString<Optional> *IsProc;// 是否非接程序 是否
@property (nonatomic,strong)NSString<Optional> *mcSerial;// 机具序列号
@property (nonatomic,strong)NSString<Optional> *mcTermType;//机具类型
@property (nonatomic,strong)NSString<Optional> *mcTermMarker;//机具型号
@property (nonatomic,strong)NSString<Optional> *mcPwdkey;// 密码键盘
@property (nonatomic,strong)NSString<Optional> *mcPwdkeyMarker;// 密码键盘型号
@property (nonatomic,strong)NSString<Optional> *operator;// 电银部经办人
@property (nonatomic,strong)NSString<Optional> *trainContent;// 培训内容
@property (nonatomic,strong)NSString<Optional> *trainContentOther;// 培训内容 其它部分
@property (nonatomic,strong)NSString<Optional> *trainResult;// 培训结果
@property (nonatomic,strong)NSString<Optional> *trainResultOther;// 培训结果 其它部分
@property (nonatomic,strong)NSString<Optional> *TermTel;// 机具线路号码
@property (nonatomic,strong)NSString<Optional> *TermAtt;// 随机配送物品

@end
