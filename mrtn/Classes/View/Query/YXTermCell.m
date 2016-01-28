//
//  YXTermCell.m
//  yuchengapp
//
//  Created by Mac on 15/12/28.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXTermCell.h"

@interface YXTermCell()

@property (strong, nonatomic) IBOutlet UILabel *termIdL;// 终端号
@property (strong, nonatomic) IBOutlet UILabel *termAddrL;// 装机地址
@property (strong, nonatomic) IBOutlet UILabel *servicesManNameL;// 维护人员
@property (strong, nonatomic) IBOutlet UILabel *salesManNameL;// 业务人员
@property (strong, nonatomic) IBOutlet UILabel *hostSerialNoL;// 序列号
@property (strong, nonatomic) IBOutlet UILabel *termLinknmL;// 联系人
@property (strong, nonatomic) IBOutlet UILabel *termLinktelL;// 联系人电话

@end


@implementation YXTermCell

- (void)setTermInfo:(YXTermInfo *)termInfo {
    
    _termInfo = termInfo;
    self.termIdL.text = termInfo.termId;
    self.termAddrL.text = termInfo.termAddr;
    self.servicesManNameL.text = termInfo.servicesManName;
    self.salesManNameL.text = termInfo.salesManName;
    self.hostSerialNoL.text = termInfo.hostSerialNo;
    self.termLinknmL.text = termInfo.termLinknm;
    self.termLinktelL.text = termInfo.termLinktel;
    
}

+ (instancetype)initWithTermInfo:(YXTermInfo *)termInfo {
    
    YXTermCell *cell=[[[NSBundle mainBundle]loadNibNamed:@"YXTermCell" owner:nil options:nil]firstObject];
    cell.termInfo = termInfo;
    return cell;
    
}


@end
