//
//  YXTaskApplyDetail.h
//  yuchengapp
//
//  Created by Mac on 15/12/29.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@interface YXTaskApplyDetail : JSONModel

@property (nonatomic,strong)NSString<Optional> *taskId;// 任务单编号
@property (nonatomic,strong)NSString<Optional> *mcIsApprove;// 审批是否通过
@property (nonatomic,strong)NSString<Optional> *mcApproveDate;// 审批时间
@property (nonatomic,strong)NSString<Optional> *mcoparea; // 经营范围
@property (nonatomic,strong)NSString<Optional> *mcbusilicense; // 营业执照
@property (nonatomic,strong)NSString<Optional> *intromcid; // 推荐人商户编号

@end
