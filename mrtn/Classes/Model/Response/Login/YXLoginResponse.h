//
//  登录响应
//  用于YXLoginViewController
//
//  Created by Mac on 15/12/7.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"
#import "YXLoginInfo.h"

@interface YXLoginResponse : JSONModel

@property (nonatomic,assign)BOOL success;// 是否登录成功
@property (nonatomic,strong)NSString<Optional> *msg;// 错误信息,只有登录不成功才会出现,非必须
@property (nonatomic,strong)YXLoginInfo<Optional> *data;// 用户信息,非必须

@end
