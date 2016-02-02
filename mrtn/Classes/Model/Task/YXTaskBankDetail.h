//
//  用于YXOrderListInfo
//
//  Created by Mac on 15/12/22.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@protocol YXTaskBankDetail

@end

@interface YXTaskBankDetail : JSONModel

@property (nonatomic,strong)NSString<Optional> *authNo;
@property (nonatomic,strong)NSString<Optional> *cardId;
@property (nonatomic,strong)NSString<Optional> *clearDate;
@property (nonatomic,strong)NSString<Optional> *dealAmount;
@property (nonatomic,strong)NSString<Optional> *dealDate;
@property (nonatomic,strong)NSString<Optional> *dealTime;
@property (nonatomic,strong)NSString<Optional> *replyDate;
@property (nonatomic,strong)NSString<Optional> *taskId;

@end
