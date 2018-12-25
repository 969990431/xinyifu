//
//  UIColor+StringColor.h
//  GoldenCatLottery
//
//  Created by Aron on 2017/7/18.
//  Copyright © 2017年 Aron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (StringColor)
// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;
@end
