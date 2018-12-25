//
//  UIImage+tool.h
//  testToolDemo
//
//  Created by 段贤才 on 16/6/28.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (tool)

/**
 *  等比缩放
 *
 *  @param size 设置尺寸
 *
 *  @return image
 */
-(UIImage *)scaleImageToSize:(CGSize)size;
/**
 *  自定长宽
 *
 *  @param reSize 设置尺寸
 *
 *  @return image
 */
-(UIImage *)imageReSize:(CGSize)reSize;
/**
 *  剪切
 *
 *  @param cutRect 选取截取部分
 *
 *  @return image
 */
-(UIImage *)cutImageWithRect:(CGRect)cutRect;
/**
 *  压缩
 *
 *  @param image 待压缩的图片
 *
 *  @return image
 */
+ (UIImage *)smallTheImage:(UIImage *)image;
/**
 *  压缩（上传）
 *
 *  @param image 待压缩图片
 *
 *  @return 图片的二进制文件
 */
+ (NSData *)smallTheImageBackData:(UIImage *)image;
/**
 *  压缩到指定大小
 *
 *  @param image 待压缩图片
 * @param  size
 *  @return 图片的二进制文件
 */
+ (NSData *)smallTheImageBackData:(UIImage *)image toSize: (NSInteger)size;
/**
 *  view转位图（一般用于截图）
 *
 *  @param view 需要转化的view
 *
 *  @return image
 */
+ (UIImage *)imageFromView:(UIView*)view;
/**
 *  保存图片到指定目录下
 *
 *  @param 子目录
 *
 *  @return 物理路径
 */
- (NSString *)saveImageToSandox:(NSString *)filePath;

/**
 *  根据缩略图创建不同大小的占位图image
 *
 *  @param 生成占位图Size
 *
 *  @return 生成的占位图
 */
+ (UIImage *)creatImage:(CGSize )size;
@end
