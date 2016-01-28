//
//  加密工具
//
//  Created by Mac on 15/12/2.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#define KEY @"99909279702660260333703373330032"

#import "YXEncryptHelper.h"
#import "des.h"

@implementation YXEncryptHelper

// 加密
+ (NSString *)md5HexDigest:(NSString *)input {
    
    const char *str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (int)strlen(str), result);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",result[i]];
    }
    return output;
    
}

// 用二维码解密
+ (NSString *)decryptQRCode:(NSString *)qrcode withKey:(NSString *)keyStr {
    
    NSString *key = KEY;
    if (keyStr) {
        key = keyStr;
    }
    // 标准des解密是16位的
    // 这个用的是3des双倍长度的解密,需要分2次进行
    char *cKey = [key UTF8String];
    NSString *seed1 = [qrcode substringWithRange:NSMakeRange(0, 16)];// 头
    NSString *seed2 = [qrcode substringWithRange:NSMakeRange(16, 16)];// 尾巴
    // 1次解密
    char *source1 = [seed1 UTF8String];
    char target1[16] = "";// 1次结果
    Soft3DESASC(source1, cKey, DECRYPT, target1);
    // 2次解密
    char *source2 = [seed2 UTF8String];
    char target2[16] = "";// 2次结果
    Soft3DESASC(source2, cKey, DECRYPT, target2);
    char target[23] = "";// 接受2次的结果
    for (int i = 0; i < sizeof(target1); i++) {
        target[i] = target1[i];
    }
    for (int i = 0; i < sizeof(target2); i++) {
        target[i+16] = target2[i];
    }
    target[22] = 0;// 结束符
    NSString *hexString = [NSString stringWithFormat:@"%s",target];
    NSString *result = [NSString stringWithHexString:hexString];
    return result;
    
}


@end
