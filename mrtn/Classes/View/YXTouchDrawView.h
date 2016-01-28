//
//  电子签名画板
//
//  Created by Mac on 15/12/2.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXLine.h"

@interface YXTouchDrawView : UIView {
    BOOL isCleared;
}

@property (nonatomic,strong) NSMutableArray *linesCompleted;// 以前的笔画
@property (nonatomic) YXLine *currentLine;// 当前笔画
- (void) backout;// 撤销

@end
