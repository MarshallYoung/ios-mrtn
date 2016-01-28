//
//  YXBacklogCell.m
//  yuchengapp
//
//  Created by Mac on 15/12/28.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXBacklogCell.h"

@interface YXBacklogCell ()

@property (strong, nonatomic) IBOutlet UILabel *mcidL;// 商户编号
@property (strong, nonatomic) IBOutlet UILabel *mcNameL;// 商户名称
@property (strong, nonatomic) IBOutlet UILabel *type001L;// 培训
@property (strong, nonatomic) IBOutlet UILabel *type002L;// 走访回访单
@property (strong, nonatomic) IBOutlet UILabel *type003L;// 风险调查单
@property (strong, nonatomic) IBOutlet UILabel *type004L;// 发卡行调单
@property (strong, nonatomic) IBOutlet UILabel *type005L;// 其他任务单
@property (strong, nonatomic) IBOutlet UILabel *type006L;// 配送耗材
@property (strong, nonatomic) IBOutlet UILabel *type007L;// 故障报修
@property (strong, nonatomic) IBOutlet UILabel *type008L;// 装机任务单
@property (strong, nonatomic) IBOutlet UILabel *type009L;// 装机申请任务单
@property (strong, nonatomic) IBOutlet UILabel *type010L;// 补充进件材料

@end


@implementation YXBacklogCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrderListInfo:(YXOrderListInfo *)orderListInfo {
    
    _orderListInfo = orderListInfo;
    
    self.mcidL.text = orderListInfo.mcid;
    self.mcNameL.text = orderListInfo.mcName;
    self.type001L.text = orderListInfo.type001;
    self.type002L.text = orderListInfo.type002;
    self.type003L.text = orderListInfo.type003;
    self.type004L.text = orderListInfo.type004;
    self.type005L.text = orderListInfo.type005;
    self.type006L.text = orderListInfo.type006;
    self.type007L.text = orderListInfo.type007;
    self.type008L.text = orderListInfo.type008;
    self.type009L.text = orderListInfo.type009;
    self.type010L.text = orderListInfo.type010;
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *identifier= @"YXBacklogCell";
    YXBacklogCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"YXBacklogCell" owner:nil options:nil]firstObject];
    }
    return cell;
    
}


@end
