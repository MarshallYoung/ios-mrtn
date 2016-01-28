//
//  登录信息
//
//  Created by Mac on 15/11/10.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@interface YXLoginInfo : JSONModel

@property (nonatomic,strong)NSMutableArray<Optional> *roles;// 任务
@property (nonatomic,strong)NSMutableArray<Optional> *roleIds;// 任务ID
@property (nonatomic,strong)NSString<Optional> *userId;// 用户ID
@property (nonatomic,strong)NSString<Optional> *createTime;// 创建时间
@property (nonatomic,strong)NSString<Optional> *createUser;// 创建人
@property (nonatomic,strong)NSString<Optional> *deptDutyman;// 办事处责任人
@property (nonatomic,strong)NSString<Optional> *deptId;// 办事处ID
@property (nonatomic,strong)NSString<Optional> *instId;// 机构ID
@property (nonatomic,strong)NSString<Optional> *instName;// 机构名称
@property (nonatomic,strong)NSString<Optional> *pwdStatus;// 密码状态
@property (nonatomic,strong)NSString<Optional> *userEmail;// 电子邮箱
@property (nonatomic,strong)NSString<Optional> *userName;// 用户名
@property (nonatomic,strong)NSString<Optional> *userPasswd;// 密码(加密)
@property (nonatomic,strong)NSString<Optional> *userPhone;// 联系电话
@property (nonatomic,strong)NSString<Optional> *userStatus;// 用户状态
@property (nonatomic,strong)NSString<Optional> *weixinId;// 微信ID

@end