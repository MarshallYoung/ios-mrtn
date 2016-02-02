//
//  YXOrderDetailController.m
//  yuchengapp
//
//  Created by Mac on 15/12/29.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXOrderDetailController.h"
#import "YXNetworkingManager.h"
#import "MBProgressHUD+Extension.h"
#import "YXOrderDetailRequest.h"
#import "YXOrderDetailResponse.h"

#import "UIBarButtonItem+Extension.h"
#import "UIImageView+WebCache.h"
#import "YXTaskRepairFragment.h"
#import "YXTaskTrainFragment.h"
#import "YXTaskVisitFragment.h"
#import "YXTaskBankFragment.h"
#import "YXTaskSurveyFragment.h"
#import "YXTaskDistributionFragment.h"
#import "YXTaskAttachment.h"
#import "YXUploadImageResponse.h"
#import "YXSignBoard.h"
#import "YXAlertDialog.h"

#import "AFNetworking.h"
#import "YXURLHelper.h"

@interface YXOrderDetailController ()<MBProgressHUDDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel      *taskIdL;// 任务单编号
@property (strong, nonatomic) IBOutlet UILabel      *taskNameL;// 任务单名称
@property (strong, nonatomic) IBOutlet UILabel      *mcIdL;// 商户编号
@property (strong, nonatomic) IBOutlet UILabel      *mcNameL;// 商户名称
@property (strong, nonatomic) IBOutlet UILabel      *mcAddrL;// 商户地址
@property (strong, nonatomic) IBOutlet UILabel      *disptTimeL;// 派工日期
@property (strong, nonatomic) IBOutlet UILabel      *termIdL;// 终端编号
@property (strong, nonatomic) IBOutlet UILabel      *termStatusNameL;// 终端状态
@property (strong, nonatomic) IBOutlet UILabel      *termTaddrL;// 装机地址
@property (strong, nonatomic) IBOutlet UILabel      *partnerNameL;// 归属支行
@property (strong, nonatomic) IBOutlet UILabel      *mcServicesManL;// 维护人员
@property (strong, nonatomic) IBOutlet UILabel      *instNameL;// 合作机构
@property (strong, nonatomic) IBOutlet UILabel      *mcTypeIdNameL;// 合作业务
@property (strong, nonatomic) IBOutlet UILabel      *mhTypeNameL;// 机具类型
@property (strong, nonatomic) IBOutlet UILabel      *handleTimeL;// 处理时限
@property (strong, nonatomic) IBOutlet UILabel      *termTlinknmL;// 终端联系人
@property (strong, nonatomic) IBOutlet UILabel      *termTlinktelL;// 终端联系电话
@property (strong, nonatomic) IBOutlet UIImageView  *signIV;// 签名

@end


@implementation YXOrderDetailController {
    
    UIBarButtonItem *btn;// 提交按钮
    YXFragment *fragment;// 各种任务单
    YXTaskAttachment *att;// 照片附件
    UITapGestureRecognizer *singleTap;// 单击事件
    
    BOOL signSetted;// 签名是否设置
    BOOL attSetted;// 附件是否设置

}

/**
 *  初始化方法
 *
 *  @param taskOrderInfo 任务单信息
 *
 *  @return 视图管理器
 */
+ (instancetype)initWithTaskOrderInfo:(YXTaskOrderInfo *)taskOrderInfo {
    
    YXOrderDetailController *controller = [[YXOrderDetailController alloc] init];
    controller.taskOrderInfo = taskOrderInfo;
    return controller;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _taskOrderInfo.taskName;
    singleTap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sign)];// 初始化点击事件
    signSetted = NO;
    attSetted  = NO;
    [self initInfo];
    
}

/**
 *  初始化数据
 */
- (void)initInfo {
    
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self text:@"初始化数据..."];// 读取框
    YXOrderDetailRequest *request = [YXOrderDetailRequest initWithId:_taskOrderInfo.taskId];
    [YXNetworkingManager queryWithRequest:request success:^(id responseObject) {
        [progress hide:YES];// 隐藏读取框
        YXOrderDetailResponse *rsp = [[YXOrderDetailResponse alloc] initWithDictionary:responseObject error:nil];// 得到响应
        if (rsp.success) {
            if (rsp.data) {
                _taskOrderInfo = rsp.data;
                [self refreshData];
            }
        }else{
            [MBProgressHUD showFail:rsp.msg];// 显示错误消息
        }
    }failure:^(void) {
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD show408];
    }];

}

/**
 *  刷新数据
 */
- (void)refreshData {
    
    self.taskIdL.text = _taskOrderInfo.taskId;
    self.taskNameL.text = _taskOrderInfo.taskName;
    self.mcIdL.text = _taskOrderInfo.mcId;
    self.mcNameL.text = _taskOrderInfo.mcName;
    self.mcAddrL.text = _taskOrderInfo.mcAddr;
    self.disptTimeL.text = _taskOrderInfo.disptTime;
    self.termIdL.text = _taskOrderInfo.termId;
    self.termStatusNameL.text = _taskOrderInfo.termStatusName;
    self.termTaddrL.text = _taskOrderInfo.termTaddr;
    self.partnerNameL.text = _taskOrderInfo.partnerName;
    self.mcServicesManL.text = _taskOrderInfo.mcServicesMan;
    self.instNameL.text = _taskOrderInfo.instName;
    self.mcTypeIdNameL.text = _taskOrderInfo.mcTypeIdName;
    self.mhTypeNameL.text = _taskOrderInfo.mhTypeName;
    self.handleTimeL.text = _taskOrderInfo.handleTime;
    self.termTlinknmL.text = _taskOrderInfo.termTlinknm;
    self.termTlinktelL.text = _taskOrderInfo.termTlinktel;
    // 判断任务单处理状态
    if ([_taskOrderInfo.taskStatus isEqual:UNDONE]) {// 未完结
        btn = [UIBarButtonItem itemWithTitle:@"提交" target:self action:@selector(commitData)];
        self.navigationItem.rightBarButtonItem = btn;// 增加提交按钮
        [self clearSign];
    }else if ([_taskOrderInfo.taskStatus isEqual:DONE]) {// 已完结,显示签名
        if (_taskOrderInfo.sign != nil) {
            self.signIV.contentMode = UIViewContentModeScaleAspectFit;// 图片自动拉伸
            NSURL *url = [NSURL URLWithString:[URL_IMAGE stringByAppendingString:_taskOrderInfo.sign]];
            [self.signIV sd_setImageWithURL:url];
        }
    }
    // 判断任务单类型
    int type = [_taskOrderInfo.taskType intValue];
    switch (type) {
        case TASK_REPAIR:// 故障报修单
            fragment = [YXTaskRepairFragment initWithTaskOrderInfo:_taskOrderInfo];
            break;
        case TASK_TRAIN:// 培训任务单
            fragment = [YXTaskTrainFragment initWithTaskOrderInfo:_taskOrderInfo];
            break;
        case TASK_VISIT:// 走访回访单
            fragment = [YXTaskVisitFragment initWithTaskOrderInfo:_taskOrderInfo];
            break;
        case TASK_BANK:// 发卡行调单
            fragment = [YXTaskBankFragment initWithTaskOrderInfo:_taskOrderInfo];
            break;
        case TASK_DISTRIBUTION:// 耗材配送单
            fragment = [YXTaskDistributionFragment initWithTaskOrderInfo:_taskOrderInfo];
            break;
        case TASK_SURVEY:// 风险调查单
            fragment = [YXTaskSurveyFragment initWithTaskOrderInfo:_taskOrderInfo];
            break;
        case TASK_RISK:// 补充进件材料
            fragment = nil;
            break;
        default:
            fragment = nil;
            break;
    }
    [self.scrollView addBottomSubview:fragment];
    att = [YXTaskAttachment initWithFileName:_taskOrderInfo.attachment];// 附件
    [self.scrollView addBottomSubview:att];
    
}

/**
 *  提交
 */
- (void)commitData {
    
    if (!signSetted) {// 未设置签名
        [MBProgressHUD showFail:@"请签名"];
        return;
    }
    attSetted = att.attSetted;// 得到附件属性
    if (!attSetted) {// 未设置附件
        [MBProgressHUD showFail:@"请拍照"];
        return;
    }
    // 显示进度框
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self text:@"上传签名..."];
    [YXNetworkingManager uploadImage:self.signIV.image success:^(id responseObject) {
        
        YXLog(@"%@",responseObject);
        YXUploadImageResponse *rsp = [[YXUploadImageResponse alloc] initWithDictionary:responseObject error:nil];
        if ([rsp.success isEqual:@"00"]) {// 成功
            progress.labelText = @"上传附件...";
            _taskOrderInfo.sign = rsp.file_id;
            UIImage *image = ((UIImageView *)att.imageArray[0]).image;
            [YXNetworkingManager uploadImage:image success:^(id responseObject) {
                
                YXLog(@"%@",responseObject);
                YXUploadImageResponse *rsp = [[YXUploadImageResponse alloc] initWithDictionary:responseObject error:nil];
                if ([rsp.success isEqual:@"00"]) {// 成功
                    progress.labelText = @"上传信息...";
                    _taskOrderInfo.attachment = rsp.file_id;
                    [self uploadInfo];
                } else {
                    [progress hide:YES];// 隐藏读取框
                    [MBProgressHUD show408];
                }
            } failure:^(void) {// 连接服务器失败
                [progress hide:YES];// 隐藏读取框
                [MBProgressHUD show408];
            }];
        } else {
            [progress hide:YES];// 隐藏读取框
            [MBProgressHUD show408];
        }
    } failure:^(void) {// 连接服务器失败
        [progress hide:YES];// 隐藏读取框
        [MBProgressHUD show408];
    }];
    
}

/**
 *  弹出签名窗口
 */
- (void)sign {

    [YXSignBoard initWithSuperView:self.view imageView:self.signIV confirm:^(void) {
        signSetted = YES;// 已经设置签名
    }];

}

/**
 *  清空电子签名
 */
- (void)clearSign {
    
    self.signIV.contentMode = UIViewContentModeCenter;// 图片居中不拉伸
    self.signIV.image = [UIImage imageNamed:@"do_sign"];// 设置图片
    self.signIV.userInteractionEnabled = YES;
    [self.signIV addGestureRecognizer:singleTap];// 添加点击事件
    signSetted = NO;
    
}

// 上传任务单
- (void)uploadInfo {
    
    // 请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;// 设置超时时间
    // 设置请求头,<<调试DEBUG>>用
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"android_request"];
    int type = [_taskOrderInfo.taskType intValue];// 判断任务单类型
    NSDictionary *parameters;// 设置参数
    YXTaskOrderInfo *taskOrderInfo = fragment.taskOrderInfo;
    switch (type) {
        case TASK_REPAIR:// 故障报修单
            parameters = @{@"taskId":_taskOrderInfo.taskId, @"sign":_taskOrderInfo.sign, @"attachment":_taskOrderInfo.attachment, @"taskRepairDetail.otherContext":taskOrderInfo.taskRepairDetail.otherContext, @"taskRepairDetail.remark":taskOrderInfo.taskRepairDetail.remark, @"taskRepairDetail.rtContent":taskOrderInfo.taskRepairDetail.rtContent};
            break;
        case TASK_TRAIN:// 培训任务单
            parameters = @{@"taskId":_taskOrderInfo.taskId, @"sign":_taskOrderInfo.sign, @"attachment":_taskOrderInfo.attachment, @"taskTrainDetail.trainDate":taskOrderInfo.taskTrainDetail.trainDate, @"taskTrainDetail.trainNum":taskOrderInfo.taskTrainDetail.trainNum, @"taskTrainDetail.trainRemark":taskOrderInfo.taskTrainDetail.trainRemark, @"taskTrainDetail.trainType":taskOrderInfo.taskTrainDetail.trainType, @"taskTrainDetail.itemPosFault":taskOrderInfo.taskTrainDetail.itemPosFault, @"taskTrainDetail.itemCard":taskOrderInfo.taskTrainDetail.itemCard, @"taskTrainDetail.itemVoucher":taskOrderInfo.taskTrainDetail.itemVoucher, @"taskTrainDetail.itemUserinfo":taskOrderInfo.taskTrainDetail.itemUserinfo, @"taskTrainDetail.itemPostSave":taskOrderInfo.taskTrainDetail.itemPostSave, @"taskTrainDetail.itemMcAgreement":taskOrderInfo.taskTrainDetail.itemMcAgreement};
            break;
        case TASK_VISIT:// 走访回访单
            parameters = @{@"taskId":_taskOrderInfo.taskId, @"sign":_taskOrderInfo.sign, @"attachment":_taskOrderInfo.attachment, @"taskVisitDetail.visitDate":taskOrderInfo.taskVisitDetail.visitDate, @"taskVisitDetail.visitLastDate":taskOrderInfo.taskVisitDetail.visitLastDate, @"taskVisitDetail.posNewAddr":taskOrderInfo.taskVisitDetail.posNewAddr, @"taskVisitDetail.managementName":taskOrderInfo.taskVisitDetail.managementName, @"taskVisitDetail.managementTel":taskOrderInfo.taskVisitDetail.managementTel, @"taskVisitDetail.result":taskOrderInfo.taskVisitDetail.result, @"taskVisitDetail.posIsAddr":taskOrderInfo.taskVisitDetail.posIsAddr, @"taskVisitDetail.posPositionChange":taskOrderInfo.taskVisitDetail.posPositionChange, @"taskVisitDetail.turnoverAvg":taskOrderInfo.taskVisitDetail.turnoverAvg, @"taskVisitDetail.stockException":taskOrderInfo.taskVisitDetail.stockException, @"taskVisitDetail.externalChange":taskOrderInfo.taskVisitDetail.externalChange, @"taskVisitDetail.internalChange":taskOrderInfo.taskVisitDetail.internalChange, @"taskVisitDetail.statusChange":taskOrderInfo.taskVisitDetail.statusChange, @"taskVisitDetail.managementChange":taskOrderInfo.taskVisitDetail.managementChange, @"taskVisitDetail.personQualityChange":taskOrderInfo.taskVisitDetail.personQualityChange, @"taskVisitDetail.otherRisk":taskOrderInfo.taskVisitDetail.otherRisk};
            break;
        case TASK_BANK:// 发卡行调单
            parameters = @{@"taskId":_taskOrderInfo.taskId, @"sign":_taskOrderInfo.sign, @"attachment":_taskOrderInfo.attachment, @"taskBankDetail.dealDate":taskOrderInfo.taskBankDetail.dealDate, @"taskBankDetail.dealTime":taskOrderInfo.taskBankDetail.dealTime, @"taskBankDetail.clearDate":taskOrderInfo.taskBankDetail.clearDate, @"taskBankDetail.cardId":taskOrderInfo.taskBankDetail.cardId, @"taskBankDetail.authNo":taskOrderInfo.taskBankDetail.authNo, @"taskBankDetail.dealAmount":taskOrderInfo.taskBankDetail.dealAmount};
            break;
        case TASK_DISTRIBUTION:// 耗材配送单
            parameters = @{@"taskId":_taskOrderInfo.taskId, @"sign":_taskOrderInfo.sign, @"attachment":_taskOrderInfo.attachment, @"taskDistributionDetail.mtalNum1":taskOrderInfo.taskDistributionDetail.mtalNum1, @"taskDistributionDetail.mtalNum2":taskOrderInfo.taskDistributionDetail.mtalNum2, @"taskDistributionDetail.mtalNum3":taskOrderInfo.taskDistributionDetail.mtalNum3};
            break;
        case TASK_SURVEY:// 风险调查单
            parameters = @{@"taskId":_taskOrderInfo.taskId, @"sign":_taskOrderInfo.sign, @"attachment":_taskOrderInfo.attachment, @"taskSurveyDetail.riskQuestion":taskOrderInfo.taskSurveyDetail.riskQuestion, @"taskSurveyDetail.surveyRequire":taskOrderInfo.taskSurveyDetail.surveyRequire, @"taskSurveyDetail.bankOpinion":taskOrderInfo.taskSurveyDetail.bankOpinion, @"taskSurveyDetail.feedback":taskOrderInfo.taskSurveyDetail.feedback, @"taskSurveyDetail.measures":taskOrderInfo.taskSurveyDetail.measures};
            break;
        case TASK_RISK:// 补充进件材料
            parameters = @{@"taskId":_taskOrderInfo.taskId, @"sign":_taskOrderInfo.sign, @"attachment":_taskOrderInfo.attachment};
            break;
        default:
            parameters = nil;
            break;
    }
    [manager POST:URL_ORDER_UPLOAD parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        YXLog(@"%@",responseObject);
        [btn setEnabled:NO];// 失效提交按钮
        [YXAlertDialog initWithSuperView:self.view message:@"任务单上传成功" confirm:^(void) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [YXAlertDialog initWithSuperView:self.view message:@"服务器无响应,请联系服务人员" confirm:^(void) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
    
}


@end
