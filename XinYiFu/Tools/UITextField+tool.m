//
//  UITextField+tool.m
//  GoldenCatLottery
//
//  Created by Aron on 2017/7/3.
//  Copyright © 2017年 Aron. All rights reserved.
//

#import "UITextField+tool.h"

@implementation UITextField (tool)
+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeHolder {
    UITextField *textF = [[UITextField alloc]init];
    textF.backgroundColor = [UIColor whiteColor];
    textF.textColor = [UIColor blackColor];
    textF.font = [UIFont systemFontOfSize:18];
    textF.placeholder = placeHolder;
    textF.clearButtonMode = UITextFieldViewModeWhileEditing;
    textF.textAlignment = NSTextAlignmentLeft;
    textF.tintColor = [UIColor blackColor];
//    textF.borderStyle = UITextBorderStyleRoundedRect;
    return textF;
}
@end
