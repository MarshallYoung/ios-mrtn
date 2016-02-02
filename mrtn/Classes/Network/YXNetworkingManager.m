//
//  网络管理
//
//  Created by Mac on 15/12/21.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXNetworkingManager.h"
#import "YXEncryptHelper.h"
#import "AFNetworking.h"
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
 */
+ (void)loginWithRequest:(YXLoginRequest *)request success:(void (^)(YXLoginResponse *))success failure:(void (^)(void))failure {
    
    NSDictionary *parameters = @{@"name":request.name ,@"pwd":[YXEncryptHelper md5HexDigest:request.pwd]};// 设置参数
    AFHTTPRequestOperationManager *manager = [self requestManager];
    [manager POST:URL_LOGIN parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {// 登录成功
        YXLoginResponse *response = [[YXLoginResponse alloc] initWithDictionary:responseObject error:nil];// 得到响应
        success(response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {// 登录失败
        failure();
    }];

}

/**
 *  查询
 *
 *  @param request 查询请求
 *  @param success 查询成功执行方法
 *  @param failure 查询失败执行方法
 */
+ (void)queryWithRequest:(YXRequest *)request success:(void (^)(id responseObject))success failure:(void (^)(void))failure {
    
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
    AFHTTPRequestOperationManager *manager = [self requestManager];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {// 查询成功
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {// 查询失败
        failure();
    }];
    
}

/**
 *  上传图片
 *
 *  @param image   图片
 *  @param success 上传成功执行方法
 *  @param failure 上传失败执行方法
 */
+ (void)uploadImage:(UIImage *)image success:(void (^)(id))success failure:(void (^)(void))failure {
    
    AFHTTPRequestOperationManager *manager = [self requestManager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSSet *set = [[NSSet alloc] initWithObjects:@"text/plain",@"application/json",@"text/json",@"text/html", nil];
    manager.responseSerializer.acceptableContentTypes = set;
    [manager POST:URL_IMAGE_UPLOAD parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:[NSString random16bitString] fileName:[NSString stringWithFormat:@"%@.png", [NSString random16bitString]] mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {// 查询失败
        failure();
    }];
    
}

/**
 *  得到发送异步请求的线程
 *
 *  @return 请求管理者
 */
+ (AFHTTPRequestOperationManager *)requestManager {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;// 设置超时时间
    // 设置请求头,<<调试DEBUG>>用
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"android_request"];
    return manager;
    
}


@end
