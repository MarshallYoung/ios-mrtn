//
//  附件
//  有URL就直接显示照片,否则点击拍照获取照片
//
//  Created by Mac on 16/1/8.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

@interface YXTaskAttachment : UIView

@property (nonatomic,assign)BOOL attSetted;// 图片是否设置
@property (nonatomic,strong)NSString *fileName;// 图片名称
@property (nonatomic,strong)NSMutableArray *imageArray;// 图片的集合
+ (instancetype)initWithFileName:(NSString *)fileName;//  初始化方法

@end
