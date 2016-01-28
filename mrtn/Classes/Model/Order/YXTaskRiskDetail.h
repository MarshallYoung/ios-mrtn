//
//  YXTaskRiskDetail.h
//  yuchengapp
//
//  Created by Mac on 15/12/29.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@interface YXTaskRiskDetail : JSONModel

@property (nonatomic,strong)NSString<Optional> *taskId;// 任务单编号
@property (nonatomic,strong)NSString<Optional> *content;
@property (nonatomic,strong)NSString<Optional> *mcGuestmg;
@property (nonatomic,strong)NSString<Optional> *path;

@end
