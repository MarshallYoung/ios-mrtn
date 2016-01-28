//
//  YXSignView.h
//  yuchengapp
//
//  Created by Mac on 16/1/13.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXSignView : UIView {
    NSMutableArray *points;
    NSArray *points_all;
    CGContextRef context;
    UIColor *paint_clr;
}
@property (strong,nonatomic) NSMutableArray *points;
@property (strong,nonatomic) NSArray *points_all;
@property (strong,nonatomic) UIColor *paint_clr;

@end
