//
//  YXMcInfoCell.m
//  yuchengapp
//
//  Created by Mac on 15/12/7.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXMerchantCell.h"

@interface YXMerchantCell()

@property (strong, nonatomic) IBOutlet UILabel *mcIdL;// 商户编号
@property (strong, nonatomic) IBOutlet UILabel *mcNameL;// 商户名称
@property (strong, nonatomic) IBOutlet UILabel *instNameL;// 机构名称
@property (strong, nonatomic) IBOutlet UILabel *mcAddrL;// 商户地址

@end

@implementation YXMerchantCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 设置商户信息
- (void)setMerchantInfo:(YXMerchantInfo *)merchantInfo {
    _merchantInfo = merchantInfo;
    
    self.mcIdL.text = merchantInfo.mcId;
    self.mcNameL.text = merchantInfo.mcName;
    self.instNameL.text = merchantInfo.instName;
    self.mcAddrL.text = merchantInfo.mcAddr;
    
}

// 初始化cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *identifier= @"YXMerchantCell";
    YXMerchantCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"YXMerchantCell" owner:nil options:nil]firstObject];
        }
    return cell;
    
}


@end
