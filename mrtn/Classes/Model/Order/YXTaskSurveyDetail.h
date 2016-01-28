//
//  用于OrderListInfo
//
//  Created by Mac on 15/12/22.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@protocol YXTaskSurveyDetail

@end

@interface YXTaskSurveyDetail : JSONModel

@property (nonatomic,strong)NSString<Optional> *bankOpinion;
@property (nonatomic,strong)NSString<Optional> *feedback;
@property (nonatomic,strong)NSString<Optional> *measures;
@property (nonatomic,strong)NSString<Optional> *riskQuestion;
@property (nonatomic,strong)NSString<Optional> *surveyRequire;
@property (nonatomic,strong)NSString<Optional> *surveyUser;
@property (nonatomic,strong)NSString<Optional> *taskId;

@end
