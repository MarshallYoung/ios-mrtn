//
//  网络管理
//
//  Created by Mac on 15/12/21.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXNetworkingManager.h"
#import "YXEncryptHelper.h"
#import "YXURLHelper.h"
#import "YXMerchantListRequest.h"
#import "YXMerchantDetailRequest.h"
#import "YXOrderListRequest.h"
#import "YXOrderListDetailRequest.h"
#import "YXOrderDetailRequest.h"

@implementation YXNetworkingManager

/**
 *  登录
 *
 *  @param request 登录请求
 *  @param success 登录成功执行方法
 *  @param failure 登录失败执行方法
 *
 *  @return 任务
 */
+ (AFHTTPRequestOperation *)loginWithRequest:(YXLoginRequest *)request success:(void (^)(YXLoginResponse *))success failure:(void (^)(void))failure {
    
    NSDictionary *parameters = @{@"name":request.name ,@"pwd":[YXEncryptHelper md5HexDigest:request.pwd]};// 设置参数
    AFHTTPRequestOperationManager *manager = [self manager];
    AFHTTPRequestOperation *operation = [manager POST:URL_LOGIN parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {// 登录成功
        YXLoginResponse *response = [[YXLoginResponse alloc] initWithDictionary:responseObject error:nil];// 得到响应
        success(response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {// 登录失败
        failure();
    }];
    return operation;

}

/**
 *  查询
 *
 *  @param request 查询请求
 *  @param success 查询成功执行方法
 *  @param failure 查询失败执行方法
 *
 *  @return 任务
 */
+ (AFHTTPRequestOperation *)queryWithRequest:(YXRequest *)request success:(void (^)(id responseObject))success failure:(void (^)(void))failure {
    
    NSString *url;// 请求地址
    NSDictionary *parameters;// 设置参数
    if ([request isMemberOfClass:[YXMerchantListRequest class]]) {// 商户列表
        url = URL_MERCHANT_LIST;
        YXMerchantListRequest *query = (YXMerchantListRequest *)request;
        parameters = @{@"mcId":query.mcId, @"mcName":query.mcName, @"currentPageNum":query.currentPageNum, @"pageSize":query.pageSize};
    } else if ([request isMemberOfClass:[YXMerchantDetailRequest class]]) {// 商户详情
        url = URL_MERCHANT_DETAIL;
        YXMerchantDetailRequest *query = (YXMerchantDetailRequest *)request;
        parameters = @{@"id":query.theId};
    } else if ([request isMemberOfClass:[YXOrderListRequest class]]) {// 任务单列表
        url = URL_ORDER_LIST;
        YXOrderListRequest *query = (YXOrderListRequest *)request;
        parameters = @{@"mcId":query.mcId, @"mcName":query.mcName, @"disptTime":query.disptTime, @"taskStatus":query.taskStatus, @"instId":@"0", @"UserId":@""};
    } else if ([request isMemberOfClass:[YXOrderListDetailRequest class]]) {// 任务单列表详情
        url = URL_ORDER_LIST_DETAIL;
        YXOrderListDetailRequest *query = (YXOrderListDetailRequest *)request;
        parameters = @{@"mcId":query.mcId, @"mcName":query.mcName, @"disptTime":@"", @"taskStatus":query.taskStatus, @"instId":@"", @"UserId":@""};
    } else if ([request isMemberOfClass:[YXOrderDetailRequest class]]) {// 任务单列表详情
        url = URL_ORDER_DETAIL;
        YXOrderDetailRequest *query = (YXOrderDetailRequest *)request;
        parameters = @{@"id":query.theId};
    }
    AFHTTPRequestOperationManager *manager = [self manager];
    AFHTTPRequestOperation *operation = [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {// 查询成功
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {// 查询失败
        failure();
    }];
    return operation;
    
}

/**
 *  上传任务单
 *
 *  @param taskOrderInfo 任务单
 *  @param success       上传成功执行方法
 *  @param failure       上传失败执行方法
 *
 *  @return 任务
 */
+ (AFHTTPRequestOperation *)uploadTaskOrder:(YXTaskOrderInfo *)taskOrderInfo success:(void (^)(id))success failure:(void (^)(void))failure {
    
    NSDictionary *parameters;// 设置参数
    int type = [taskOrderInfo.taskType intValue];// 任务单类型
    switch (type) {
        case TASK_REPAIR:// 故障报修单
            parameters = @{@"taskId":taskOrderInfo.taskId, @"sign":taskOrderInfo.sign, @"attachment":taskOrderInfo.attachment, @"taskRepairDetail.otherContext":taskOrderInfo.taskRepairDetail.otherContext, @"taskRepairDetail.remark":taskOrderInfo.taskRepairDetail.remark, @"taskRepairDetail.rtContent":taskOrderInfo.taskRepairDetail.rtContent};
            break;
        case TASK_TRAIN:// 培训任务单
            parameters = @{@"taskId":taskOrderInfo.taskId, @"sign":taskOrderInfo.sign, @"attachment":taskOrderInfo.attachment, @"taskTrainDetail.trainDate":taskOrderInfo.taskTrainDetail.trainDate, @"taskTrainDetail.trainNum":taskOrderInfo.taskTrainDetail.trainNum, @"taskTrainDetail.trainRemark":taskOrderInfo.taskTrainDetail.trainRemark, @"taskTrainDetail.trainType":taskOrderInfo.taskTrainDetail.trainType, @"taskTrainDetail.itemPosFault":taskOrderInfo.taskTrainDetail.itemPosFault, @"taskTrainDetail.itemCard":taskOrderInfo.taskTrainDetail.itemCard, @"taskTrainDetail.itemVoucher":taskOrderInfo.taskTrainDetail.itemVoucher, @"taskTrainDetail.itemUserinfo":taskOrderInfo.taskTrainDetail.itemUserinfo, @"taskTrainDetail.itemPostSave":taskOrderInfo.taskTrainDetail.itemPostSave, @"taskTrainDetail.itemMcAgreement":taskOrderInfo.taskTrainDetail.itemMcAgreement};
            break;
        case TASK_VISIT:// 走访回访单
            parameters = @{@"taskId":taskOrderInfo.taskId, @"sign":taskOrderInfo.sign, @"attachment":taskOrderInfo.attachment, @"taskVisitDetail.visitDate":taskOrderInfo.taskVisitDetail.visitDate, @"taskVisitDetail.visitLastDate":taskOrderInfo.taskVisitDetail.visitLastDate, @"taskVisitDetail.posNewAddr":taskOrderInfo.taskVisitDetail.posNewAddr, @"taskVisitDetail.managementName":taskOrderInfo.taskVisitDetail.managementName, @"taskVisitDetail.managementTel":taskOrderInfo.taskVisitDetail.managementTel, @"taskVisitDetail.result":taskOrderInfo.taskVisitDetail.result, @"taskVisitDetail.posIsAddr":taskOrderInfo.taskVisitDetail.posIsAddr, @"taskVisitDetail.posPositionChange":taskOrderInfo.taskVisitDetail.posPositionChange, @"taskVisitDetail.turnoverAvg":taskOrderInfo.taskVisitDetail.turnoverAvg, @"taskVisitDetail.stockException":taskOrderInfo.taskVisitDetail.stockException, @"taskVisitDetail.externalChange":taskOrderInfo.taskVisitDetail.externalChange, @"taskVisitDetail.internalChange":taskOrderInfo.taskVisitDetail.internalChange, @"taskVisitDetail.statusChange":taskOrderInfo.taskVisitDetail.statusChange, @"taskVisitDetail.managementChange":taskOrderInfo.taskVisitDetail.managementChange, @"taskVisitDetail.personQualityChange":taskOrderInfo.taskVisitDetail.personQualityChange, @"taskVisitDetail.otherRisk":taskOrderInfo.taskVisitDetail.otherRisk};
            break;
        case TASK_BANK:// 发卡行调单
            parameters = @{@"taskId":taskOrderInfo.taskId, @"sign":taskOrderInfo.sign, @"attachment":taskOrderInfo.attachment, @"taskBankDetail.dealDate":taskOrderInfo.taskBankDetail.dealDate, @"taskBankDetail.dealTime":taskOrderInfo.taskBankDetail.dealTime, @"taskBankDetail.clearDate":taskOrderInfo.taskBankDetail.clearDate, @"taskBankDetail.cardId":taskOrderInfo.taskBankDetail.cardId, @"taskBankDetail.authNo":taskOrderInfo.taskBankDetail.authNo, @"taskBankDetail.dealAmount":taskOrderInfo.taskBankDetail.dealAmount};
            break;
        case TASK_DISTRIBUTION:// 耗材配送单
            parameters = @{@"taskId":taskOrderInfo.taskId, @"sign":taskOrderInfo.sign, @"attachment":taskOrderInfo.attachment, @"taskDistributionDetail.mtalNum1":taskOrderInfo.taskDistributionDetail.mtalNum1, @"taskDistributionDetail.mtalNum2":taskOrderInfo.taskDistributionDetail.mtalNum2, @"taskDistributionDetail.mtalNum3":taskOrderInfo.taskDistributionDetail.mtalNum3};
            break;
        case TASK_SURVEY:// 风险调查单
            parameters = @{@"taskId":taskOrderInfo.taskId, @"sign":taskOrderInfo.sign, @"attachment":taskOrderInfo.attachment, @"taskSurveyDetail.riskQuestion":taskOrderInfo.taskSurveyDetail.riskQuestion, @"taskSurveyDetail.surveyRequire":taskOrderInfo.taskSurveyDetail.surveyRequire, @"taskSurveyDetail.bankOpinion":taskOrderInfo.taskSurveyDetail.bankOpinion, @"taskSurveyDetail.feedback":taskOrderInfo.taskSurveyDetail.feedback, @"taskSurveyDetail.measures":taskOrderInfo.taskSurveyDetail.measures};
            break;
        case TASK_RISK:// 补充进件材料
            parameters = @{@"taskId":taskOrderInfo.taskId, @"sign":taskOrderInfo.sign, @"attachment":taskOrderInfo.attachment};
            break;
        default:
            parameters = nil;
            break;
    }
    AFHTTPRequestOperationManager *manager = [self manager];
    AFHTTPRequestOperation *operation = [manager POST:URL_ORDER_UPLOAD parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure();
    }];
    return operation;
    
}

/**
 *  上传图片
 *
 *  @param image   图片
 *  @param success 上传成功执行方法
 *  @param failure 上传失败执行方法
 *
 *  @return 任务
 */
+ (AFHTTPRequestOperation *)uploadImage:(UIImage *)image success:(void (^)(id))success failure:(void (^)(void))failure {
    
    AFHTTPRequestOperationManager *manager = [self manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSSet *set = [[NSSet alloc] initWithObjects:@"text/plain",@"application/json",@"text/json",@"text/html", nil];
    manager.responseSerializer.acceptableContentTypes = set;
    AFHTTPRequestOperation *operation = [manager POST:URL_IMAGE_UPLOAD parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:[NSString random16bitString] fileName:[NSString random16bitString] mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {// 查询失败
        failure();
    }];
    return operation;
    
}

/**
 *  得到发送异步请求的线程
 *
 *  @return 请求管理者
 */
+ (AFHTTPRequestOperationManager *)manager {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;// 设置超时时间
    // 设置请求头,<<调试DEBUG>>用
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"android_request"];
    return manager;
    
}


@end
