//
//  YXRepresentativeFragment.m
//  mrtn
//
//  Created by Mac on 16/2/18.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXBusinessRepresentativeFragment.h"

@implementation YXBusinessRepresentativeFragment

+(instancetype)initWithInfo:(id)info {
    
    YXBusinessRepresentativeFragment *fragment = [[[NSBundle mainBundle]loadNibNamed:@"YXBusinessRepresentativeFragment" owner:nil options:nil]firstObject];
    return fragment;
    
}

@end
