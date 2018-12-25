//
//  UIButton+tool.m
//  GoldenCatLottery
//
//  Created by Aron on 2017/7/3.
//  Copyright © 2017年 Aron. All rights reserved.
//

#import "UIButton+tool.h"
#import <UIKit/UIKit.h>

@implementation UIButton (tool)
+ (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.titleLabel.textColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    return btn;
}
+(UIButton *)buttonWithSelected:(BOOL)selected title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.selected = selected;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:selected?[UIColor redColor]:[UIColor whiteColor]];
    [btn setTitleColor:selected?[UIColor whiteColor]:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    return btn;
}

+ (UIButton *)buttonWithTitle:(NSString *)title textColor: (UIColor *)textColor backGroundColor: (UIColor *)backGroundColor font: (CGFloat)font{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:backGroundColor];
    btn.titleLabel.textColor = textColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
//    btn.layer.masksToBounds = YES;
//    btn.layer.cornerRadius = 4;
    return btn;
}
@end
