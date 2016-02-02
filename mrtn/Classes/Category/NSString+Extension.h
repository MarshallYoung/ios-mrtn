//
//  NSString扩展
//
//  Created by Mac on 15/12/2.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

@interface NSString (Extension)

+ (BOOL)isEmpty:(NSString *)string;// 是否为空
- (BOOL)isEmpty;// 是否为空
/**
 *  产生16位随机大写英文字符串
 *
 *  @return 16位字符串
 */
+ (NSString *)random16bitString;
+ (NSString *)stringWithHexString:(NSString *)hexString;// 通过16进制ASCII码产生字符串

@end
