//
//  UIButton+CreatBtn.m
//  GoldenCatLottery
//
//  Created by Aron on 2017/11/23.
//  Copyright © 2017年 Aron. All rights reserved.
//

#import "UIButton+CreatBtn.h"

@implementation UIButton (CreatBtn)
+ (UIButton *)buttonWithTitle:(NSString *)title font:(NSInteger)font titleColor:(UIColor *)titleColor backGroundColor:(UIColor *)backGroundColor aligment:(UIControlContentHorizontalAlignment)aligment{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:backGroundColor];
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    button.contentHorizontalAlignment = aligment;
    return button;
}
@end
