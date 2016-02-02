//
//  用于YXOrderListInfo
//
//  Created by Mac on 15/12/22.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@protocol YXTaskTrainDetail

@end

@interface YXTaskTrainDetail : JSONModel

@property (nonatomic,strong)NSString<Optional> *itemCard;
@property (nonatomic,strong)NSString<Optional> *itemCardContent;
@property (nonatomic,strong)NSString<Optional> *itemMcAgreement;
@property (nonatomic,strong)NSString<Optional> *itemMcAgreementContent;
@property (nonatomic,strong)NSString<Optional> *itemPosFault;
@property (nonatomic,strong)NSString<Optional> *itemPosFaultContent;
@property (nonatomic,strong)NSString<Optional> *itemPostSave;
@property (nonatomic,strong)NSString<Optional> *itemPostSaveContent;
@property (nonatomic,strong)NSString<Optional> *itemUserinfo;
@property (nonatomic,strong)NSString<Optional> *itemUserinfoContent;
@property (nonatomic,strong)NSString<Optional> *itemVoucher;
@property (nonatomic,strong)NSString<Optional> *itemVoucherContent;
@property (nonatomic,strong)NSString<Optional> *taskId;
@property (nonatomic,strong)NSString<Optional> *trainDate;
@property (nonatomic,strong)NSString<Optional> *trainNum;
@property (nonatomic,strong)NSString<Optional> *trainRemark;
@property (nonatomic,strong)NSString<Optional> *trainStudent;
@property (nonatomic,strong)NSString<Optional> *trainTeacher;
@property (nonatomic,strong)NSString<Optional> *trainType;// 培训类型 001新增终端 002 收银员变更 003 定期培训

@end
