//
//  签字版
//
//  Created by Mac on 16/1/27.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "YXSignBoard.h"
#import "YXSignView.h"

@interface YXSignBoard()

@property (strong, nonatomic) IBOutlet UIView *background;
@property (strong, nonatomic) IBOutlet YXSignView *signView;
- (IBAction)cancel:(id)sender;// 取消
- (IBAction)confirm:(id)sender;// 确定

@end


@implementation YXSignBoard

+(instancetype)initWithSuperView:(UIView *)superView imageView:(UIImageView *)targetImageView {
    
    YXSignBoard *root = [[[NSBundle mainBundle] loadNibNamed:@"YXSignBoard" owner:nil options:nil] firstObject];
    root.userInteractionEnabled = YES;
    root.signView.backgroundColor = [UIColor whiteColor];
    root.frame = CGRectMake(0, 0, superView.width, superView.height);
    root.targetImageView = targetImageView;
    [superView addSubview:root];
    return root;
    
}

+ (instancetype)initWithSuperView:(UIView *)superView imageView:(UIImageView *)targetImageView confirm:(void (^)(void))confirm {
    
    YXSignBoard *root = [YXSignBoard initWithSuperView:superView imageView:targetImageView];
    root.confirmBlock = confirm;
    return root;
    
}

- (IBAction)cancel:(id)sender {
    
    [self removeFromSuperview];
    
}

- (IBAction)confirm:(id)sender {
    
    if (_targetImageView) {
        UIGraphicsBeginImageContext(_signView.bounds.size);
        [_signView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _targetImageView.image = image;
        _targetImageView.contentMode = UIViewContentModeScaleAspectFit;// 缩放适应iv大小
    }
    if (_confirmBlock) {
        _confirmBlock();
    }
    [self removeFromSuperview];
    
}


@end
