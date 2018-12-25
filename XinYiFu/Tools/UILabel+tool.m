//
//  UILabel+tool.m
//  GoldenCatLottery
//
//  Created by Aron on 2017/7/4.
//  Copyright © 2017年 Aron. All rights reserved.
//

#import "UILabel+tool.h"

@implementation UILabel (tool)
+ (UILabel *)labelWithTextColor:(UIColor *)color font:(CGFloat)font aligment:(NSTextAlignment)aligement {
    UILabel *label = [[UILabel alloc]init];
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = aligement;
    label.numberOfLines = 0;
    return label;
}
@end
