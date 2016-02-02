//
//  NSString扩展
//
//  Created by Mac on 15/12/2.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

// 是否为空
+ (BOOL)isEmpty:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqual:@""]) {
        return YES;
    }
    return NO;
    
}

- (BOOL)isEmpty {
    
    return [NSString isEmpty:self];
    
}

/**
 *  产生16位随机大写英文字符串
 *
 *  @return 16位字符串
 */
+ (NSString *)random16bitString {
    
    char data[16];
    for (int x = 0; x < 16; data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:16 encoding:NSUTF8StringEncoding];
    
}

// 通过16进制ASCII码产生字符串
+ (NSString *)stringWithHexString:(NSString *)hexString {
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    return unicodeString; 
    
} 


@end
