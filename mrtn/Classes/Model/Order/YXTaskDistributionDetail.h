//
//  用于OrderListInfo
//
//  Created by Mac on 15/12/22.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@protocol YXTaskDistributionDetail

@end

@interface YXTaskDistributionDetail : JSONModel

@property (nonatomic,strong)NSString<Optional> *mtalNum1;
@property (nonatomic,strong)NSString<Optional> *mtalNum2;
@property (nonatomic,strong)NSString<Optional> *mtalNum3;
@property (nonatomic,strong)NSString<Optional> *remarks;
@property (nonatomic,strong)NSString<Optional> *taskId;

@end
