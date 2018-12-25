//
//  UIImage+tool.m
//  testToolDemo
//
//  Created by 段贤才 on 16/6/28.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import "UIImage+tool.h"

@implementation UIImage (tool)


-(UIImage *)scaleImageToSize:(CGSize)size{
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

- (UIImage *)imageReSize:(CGSize)reSize{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

-(UIImage *)cutImageWithRect:(CGRect)cutRect{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, cutRect);
    UIGraphicsBeginImageContext(cutRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, cutRect, subImageRef);
    UIImage* cutedImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    if (subImageRef) {
        CFRelease(subImageRef);
    }
    return cutedImage;
}

+ (UIImage *)smallTheImage:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 1.);
    if (data.length > 1024*1024*2) {
        NSData *smallData = UIImageJPEGRepresentation(image, (1024*1024*2)/data.length*2);
        if (smallData.length > 1024*1024*2) {
            return [self smallTheImage:[UIImage imageWithData:smallData]];
        } else {
            return [UIImage imageWithData:smallData];
        }
    } else {
        return image;
    }
}

+ (NSData *)smallTheImageBackData:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 1.);
    if (data.length > 1024*1024*1) {//上传的图片压缩至1Mb以下
        NSData *smallData = UIImageJPEGRepresentation(image, (1024*1024*1)/data.length*2);
        if (smallData.length > 1024*1024*1) {
            return [self smallTheImageBackData:[UIImage imageWithData:smallData]];
        } else {
            return smallData;
        }
    } else {
        return data;
    }
}

+ (NSData *)smallTheImageBackData:(UIImage *)image toSize:(NSInteger)size {
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}

+ (UIImage *)imageFromView:(UIView*)view{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(view.bounds.size);
    }
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //    CGContextSetInterpolationQuality(currnetContext, kCGInterpolationHigh);
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

- (NSString *)saveImageToSandox:(NSString *)filePath{
    
    NSString *imagePath = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents%@",filePath]];
    [UIImagePNGRepresentation(self) writeToFile:imagePath atomically:YES];
    return imagePath;
}

+ (UIImage *)creatImage:(CGSize ) size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    CGContextSetFillColorWithColor(context, [UIColorFromRGB(LOGIN_GRY_COLOR) CGColor]);
    CGContextFillRect(context, rect);
    float min = size.width<size.height?:size.height;
    CGFloat actWidth = min * 0.618;
    CGFloat actHeight = min * 0.618;
    
    UIGraphicsPushContext( context );
    [[UIImage imageNamed:@"img_logo_placeholder"] drawInRect:CGRectMake((size.width - actWidth)/2, (size.height - actHeight) / 2 , actWidth, actHeight)];
    UIGraphicsPopContext();
    //
    //    CGImageRef moren = CGImageRetain([UIImage imageNamed:@"icon_morentu"].CGImage);
    //
    //    CGContextDrawImage(context, CGRectMake(size.width /2 - 25, size.height / 2 - 25, 50, 50), moren);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;

}
@end
