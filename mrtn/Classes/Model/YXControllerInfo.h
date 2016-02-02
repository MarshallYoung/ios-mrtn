//
//  视图控制器信息,用于初始化共用视图控制器,区分试图控制器的不同任务
//
//  Created by Mac on 15/12/30.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#define ORDER_BACKLOG   @"1"// 用于mode字段,表示进入待办列表
#define ORDER_PROCESSED @"2"// 用于mode字段,表示进入办结列表

@interface YXControllerInfo : NSObject

@property (nonatomic, strong) NSString *mode;// 视图控制器的模式

@end
