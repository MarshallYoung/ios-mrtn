//
//  任务单信息
//
//  Created by Mac on 15/12/22.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@protocol YXOrderListInfo

@end

@interface YXOrderListInfo : JSONModel

@property (nonatomic,strong)NSString<Optional> *count;
@property (nonatomic,strong)NSString<Optional> *mcName;
@property (nonatomic,strong)NSString<Optional> *mcid;
@property (nonatomic,strong)NSString<Optional> *type001;// 培训
@property (nonatomic,strong)NSString<Optional> *type002;// 走访回访单
@property (nonatomic,strong)NSString<Optional> *type003;// 风险调查单
@property (nonatomic,strong)NSString<Optional> *type004;// 发卡行调单
@property (nonatomic,strong)NSString<Optional> *type005;// 其他任务单
@property (nonatomic,strong)NSString<Optional> *type006;// 耗材配送
@property (nonatomic,strong)NSString<Optional> *type007;// 故障报修
@property (nonatomic,strong)NSString<Optional> *type008;// 装机任务单
@property (nonatomic,strong)NSString<Optional> *type009;// 装机申请任务单
@property (nonatomic,strong)NSString<Optional> *type010;// 补充进件材料

@end
