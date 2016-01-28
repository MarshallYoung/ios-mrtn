//
//  用于YXOrderListInfo
//
//  Created by Mac on 15/12/22.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@protocol YXTaskRepairDetail

@end

@interface YXTaskRepairDetail : JSONModel

@property (nonatomic,strong)NSString<Optional> *otherContext;
@property (nonatomic,strong)NSString<Optional> *remark;
@property (nonatomic,strong)NSString<Optional> *rtContent;
@property (nonatomic,strong)NSString<Optional> *taskId;

@end
