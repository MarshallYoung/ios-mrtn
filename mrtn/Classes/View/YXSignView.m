//
//  YXSignView.m
//  yuchengapp
//
//  Created by Mac on 16/1/13.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXSignView.h"

@implementation YXSignView

@synthesize points, points_all, paint_clr;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        paint_clr = [UIColor greenColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if ((!self.points) || (self.points.count < 2)) {
        return;
    }
    
    context = UIGraphicsGetCurrentContext();
    //设置画笔粗细
    CGContextSetLineWidth(context, 5.0f);
    //设置画笔颜色
    //[[UIColor blueColor]set ];
    // [paint_clr set];
    //CGContextSetStrokeColorWithColor(context, [[UIColor blueColor]CGColor]);
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor]CGColor]);
    
    //画以前的轨迹
    for (int j = 0 ; j < [self.points_all count]; j++) {
        NSMutableArray *points_tmp = [points_all objectAtIndex:j];
        
        for (int i = 0;i < [points_tmp count]-1;i++)
        {
            CGPoint point1 = [[points_tmp objectAtIndex:i] CGPointValue];
            CGPoint point2 = [[points_tmp objectAtIndex:(i+1)] CGPointValue];
            CGContextMoveToPoint(context, point1.x, point1.y);
            CGContextAddLineToPoint(context, point2.x, point2.y);
            CGContextStrokePath(context);
        }
    }
    
    //画这次
    for (int i=0; i < [self.points count]-1; i++) {
        CGPoint point1 = [[self.points objectAtIndex:i] CGPointValue];
        CGPoint point2 = [[self.points objectAtIndex:(i+1)] CGPointValue];
        CGContextMoveToPoint(context, point1.x, point1.y);
        CGContextAddLineToPoint(context, point2.x, point2.y);
        CGContextStrokePath(context);
    }
}

//不支持多点触摸
- (BOOL) isMultipleTouchEnabled
{
    return NO;
}

//创建一个array，并且记录初始ponit
- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
    self.points = [NSMutableArray array];
    CGPoint pt = [[touches anyObject] locationInView:self];
    [self.points addObject:[NSValue valueWithCGPoint:pt]];
}

//移动过程中记录这些points
//调用setNeedsDisplay，会触发drawRect方法的调用
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self];
    [self.points addObject:[NSValue valueWithCGPoint:pt]];
    [self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSMutableArray *points_tmp = [[NSMutableArray alloc] initWithArray:self.points];
    if (self.points_all == nil) {
        self.points_all = [[NSArray alloc] initWithObjects:points_tmp, nil];
    }else {
        self.points_all = [self.points_all arrayByAddingObject:points_tmp];
    }
}


@end
