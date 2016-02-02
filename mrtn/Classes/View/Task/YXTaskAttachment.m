//
//  附件
//
//  Created by Mac on 16/1/8.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#define NAME_LENGTH 40 // 图片文件名长度

#import "YXTaskAttachment.h"
#import "YXURLHelper.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+Extension.h"
#import "YXZoomImageController.h"

@interface YXTaskAttachment ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end


@implementation YXTaskAttachment {

    UITapGestureRecognizer *singleTap;// 单击手势
    NSMutableArray *fileNameArray;// 存放图片名字的数组

}

// 初始化方法
+ (instancetype)initWithFileName:(NSString *)fileName {
    
    YXTaskAttachment *root = [[[NSBundle mainBundle]loadNibNamed:@"YXTaskAttachment" owner:nil options:nil] firstObject];
    root.fileName = fileName;
    return root;
    
}

- (void)setFileName:(NSString *)fileName {
    
    _fileName = fileName;
    _imageArray = [NSMutableArray array];// 初始化图片数组
    if (!fileNameArray) {
        fileNameArray = [NSMutableArray array];
    }
    if (_fileName) {// 附件存在
        [self cutImageName:_fileName putIntoArray:fileNameArray];// 截取附件的文件名
    }
    if (fileNameArray.count > 0) {// 文件名存在
        for (int i = 0; i < fileNameArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.tag = i;
            imageView.x = 105;// 横坐标
            imageView.size = CGSizeMake(200, 160);// 大小
            imageView.contentMode = UIViewContentModeScaleToFill;// 拉伸占满
            [self addBottomSubview:imageView];
            [_imageArray addObject:imageView];
            NSURL *url = [NSURL URLWithString:[URL_IMAGE stringByAppendingString:fileNameArray[i]]];
            [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loading"]];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomImage:)];// 设置点击放大
            imageView.userInteractionEnabled = YES;// 可以点击
            [imageView addGestureRecognizer:tap];
        }
        _attSetted = YES;//  图片已设置
    } else {
        [self clearImage];
    }
    
}

// 包含多文件名的fileName(由"|"间隔),需要截断文件名
- (void)cutImageName:(NSString *)imageName putIntoArray:(NSMutableArray *)array {
    
    unsigned int count = (int)(imageName.length/NAME_LENGTH);// 有几个图片(40个文件名以内不会有误差)
    for (int n = 0; n < count; n++) {
        NSRange range = NSMakeRange(n * NAME_LENGTH + n, NAME_LENGTH);// 截取范围
        NSString *subStr = [imageName substringWithRange:range];
        [array addObject:subStr];// 添加字符串
    }
    
}

// 清空图片
-(void)clearImage {
    
    if (!singleTap) {// 单击手势不存在
        singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takeAPicture)];// 初始化
    }
    UIImageView *image = [[UIImageView alloc] init];
    image.frame = CGRectMake(105, 25, 200, 160);// 图片位置和大小
    image.contentMode = UIViewContentModeCenter;// 居中不拉伸
    image.image = [UIImage imageNamed:@"take_photo"];// 设置图片
    image.userInteractionEnabled = YES;
    [image addGestureRecognizer:singleTap];// 添加点击事件
    [self addBottomSubview:image];
    [_imageArray addObject:image];
    _attSetted = NO;// 图片未设置
    
}

// 放大图片
- (void)zoomImage:(UITapGestureRecognizer *)recognizer {
    
    long index = recognizer.view.tag;
    NSString *fileName = fileNameArray[index];
    YXZoomImageController *controller = [YXZoomImageController initWithFileName:fileName];
    UIViewController *current = [self currentController];// 得到当前所在的控制器
    if (current) {
        [current.navigationController pushViewController:controller animated:YES];
    }
    
}

// 拍照
- (void)takeAPicture {
    
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {// 支持相机
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照", nil];
        [sheet showInView:self.superview];
    } else {// 不支持相机
        [MBProgressHUD showFail:@"设备不支持拍照功能"];
    }
    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {// 取消
        return;
    } else if(buttonIndex == 1) {// 相机
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.delegate = self;
        controller.allowsEditing = YES;
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        UIViewController *current = [self currentController];// 得到当前所在的控制器
        if (current) {
            [current.navigationController presentViewController:controller animated:YES completion:nil];
        }
    }
    
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    UIImageView *imageView = _imageArray[0];
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleToFill;
    if (singleTap) {
        [imageView removeGestureRecognizer:singleTap];// 移除手势
    }
    _attSetted = YES;// 图片已设置
    
}

// 压缩图片
- (NSData *)resetSizeOfImageData:(UIImage *)originalImage maxSize:(NSInteger)maxSize {
    
    //先调整分辨率
    CGSize newSize = originalImage.size;
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(originalImage.size.width / tempWidth, originalImage.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(originalImage.size.width / tempHeight, originalImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [originalImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
        return finallImageData;
    }
    
    return imageData;
}


@end
