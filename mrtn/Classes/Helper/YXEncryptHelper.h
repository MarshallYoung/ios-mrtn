//
//  加密工具
//
//  Created by Mac on 15/12/2.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "CommonCrypto/CommonDigest.h"

@interface YXEncryptHelper : NSObject

+ (NSString *)md5HexDigest:(NSString *)input;// 加密
+ (NSString *)decryptQRCode:(NSString *)qrcode withKey:(NSString *)keyStr;// 二维码解密

@end
