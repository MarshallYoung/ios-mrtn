//
//  YXQueryMerchantResponse.h
//  yuchengapp
//
//  Created by Mac on 15/12/23.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "JSONModel.h"

@interface YXQueryMerchantResponse : JSONModel

@property (nonatomic,assign)BOOL success;// 是否查询成功
@property (nonatomic,strong)NSString<Optional> *flag;
@property (nonatomic,strong)NSMutableArray<Optional> *data;// 查询结果,非必须

@end
