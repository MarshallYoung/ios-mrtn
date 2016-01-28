//
//  电子签名画板
//
//  Created by Mac on 15/12/2.
//  Copyright © 2015年 YusysTechnologies. All rights reserved.
//

#import "YXTouchDrawView.h"

@implementation YXTouchDrawView

@synthesize linesCompleted;
@synthesize currentLine;

// 在nib文件中加载的时候调用
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        linesCompleted = [[NSMutableArray alloc] init];
        [self setMultipleTouchEnabled:YES];
        [self becomeFirstResponder];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    for (YXLine *line in linesCompleted) {
        [[UIColor blackColor] set];
        CGContextMoveToPoint(context, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
    }
}

// 撤销
- (void)backout {
    if ([self.undoManager canUndo]) {
        [self.undoManager undo];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.undoManager beginUndoGrouping];// 开始记录多个触摸点作为一个笔画
    for (UITouch *t in touches) {
        // Create a line for the value
        CGPoint loc = [t locationInView:self];
        YXLine *newLine = [[YXLine alloc] init];
        [newLine setBegin:loc];
        [newLine setEnd:loc];
        currentLine = newLine;
    }
}

// 将笔画增加到数组中
- (void)addLine:(YXLine*)line
{
    [[self.undoManager prepareWithInvocationTarget:self] removeLine:line];
    [linesCompleted addObject:line];
    [self setNeedsDisplay];// 显示变化
}

// 从数组中移除笔画
- (void)removeLine:(YXLine*)line
{
    if ([linesCompleted containsObject:line]) {
        [[self.undoManager prepareWithInvocationTarget:self] addLine:line];
        [linesCompleted removeObject:line];
        [self setNeedsDisplay];
    }
}

- (void)removeLineByEndPoint:(CGPoint)point
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        YXLine *evaluatedLine = (YXLine*)evaluatedObject;
        //        return (evaluatedLine.end.x == point.x && evaluatedLine.end.y == point.y) ||
        //               (evaluatedLine.end.x == point.x - 1.0f && evaluatedLine.end.y == point.y - 1.0f) ||
        //               (evaluatedLine.end.x == point.x + 1.0f && evaluatedLine.end.y == point.y + 1.0f);
        return (evaluatedLine.end.x <= point.x-1 || evaluatedLine.end.x > point.x+1) &&
        (evaluatedLine.end.y <= point.y-1 || evaluatedLine.end.y > point.y+1);
    }];
    NSArray *result = [linesCompleted filteredArrayUsingPredicate:predicate];
    if (result && result.count > 0) {
        [linesCompleted removeObject:result[0]];
    }
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!isCleared) {
        for (UITouch *t in touches) {
            CGPoint loc = [t locationInView:self];
            [currentLine setEnd:loc];
            
            if (currentLine) {
//                if ([Common color:drawColor isEqualToColor:[UIColor clearColor] withTolerance:0.2]) {
                    // eraser
                    // [self removeLineByEndPoint:loc]; //this solution can not work.
//                    _isEraser = YES;
//                } else {
//                    _isEraser = NO;
                    [self addLine:currentLine];
//                }
            }
            YXLine *newLine = [[YXLine alloc] init];
            [newLine setBegin:loc];
            [newLine setEnd:loc];
            currentLine = newLine;
        }
    }
}

- (void)endTouches:(NSSet *)touches
{
    if (!isCleared) {
        [self setNeedsDisplay];
    } else {
        isCleared = NO;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
    [self.undoManager endUndoGrouping];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)didMoveToWindow
{
    [self becomeFirstResponder];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


@end
