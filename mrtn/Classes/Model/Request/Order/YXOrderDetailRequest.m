//
//  YXOrderDetailRequest.m
//  mrtn
//
//  Created by Mac on 16/2/2.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXOrderDetailRequest.h"

@implementation YXOrderDetailRequest

+ (instancetype)initWithId:(NSString *)theId {
    
    YXOrderDetailRequest *request = [[YXOrderDetailRequest alloc] init];
    request.id = theId;
    return request;
    
}

@end
