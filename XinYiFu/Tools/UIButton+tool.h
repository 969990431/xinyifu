//
//  UIButton+tool.h
//  GoldenCatLottery
//
//  Created by Aron on 2017/7/3.
//  Copyright © 2017年 Aron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (tool)
+ (UIButton *)buttonWithTitle: (NSString *)title;
+ (UIButton *)buttonWithSelected: (BOOL)selected title: (NSString *)title;
+ (UIButton *)buttonWithTitle:(NSString *)title textColor: (UIColor *)textColor backGroundColor: (UIColor *)backGroundColor font: (CGFloat)font;
@end
