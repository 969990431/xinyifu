//
//  UIButton+CreatBtn.h
//  GoldenCatLottery
//
//  Created by Aron on 2017/11/23.
//  Copyright © 2017年 Aron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CreatBtn)
+ (UIButton *)buttonWithTitle: (NSString *)title font: (NSInteger)font titleColor: (UIColor *)titleColor backGroundColor: (UIColor *)backGroundColor aligment: (UIControlContentHorizontalAlignment)aligment;
@end
