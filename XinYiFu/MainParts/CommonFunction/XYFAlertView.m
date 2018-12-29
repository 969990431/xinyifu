//
//  XYFAlertView.m
//  XinYiFu
//
//  Created by apple on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "XYFAlertView.h"

@implementation XYFAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)showAlertViewWithTitle:(NSString *)title content:(NSString *)content buttonTitle:(NSString *)buttonTitle{
    XYFAlertView *view = [[XYFAlertView alloc] initAlertViewWithTitle:title content:content buttonTitle:buttonTitle];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (UIView *)initAlertViewWithTitle:(NSString *)title content:(NSString *)content buttonTitle:(NSString *)buttonTitle{
    if (self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.frame]) {
        self.backgroundColor = UIColorFromRGBWithAlpha(0, .5);
        
        UIView *alertView = [[UIView alloc] init];
        [self addSubview:alertView];
        [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(self.mas_right).offset(-20);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(230);
        }];
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:GetImage(@"7弹出框")];
        [alertView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(0);
        }];
        
        UILabel *titleLabel = [UILabel labelWithTextColor:WordOrange font:22 aligment:NSTextAlignmentCenter];
        titleLabel.text = title;
        [alertView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(22);
            make.centerX.mas_equalTo(alertView);
            make.height.mas_equalTo(30);
        }];
        
        UILabel *contentLabel = [UILabel labelWithTextColor:WordCloseBlack font:18 aligment:NSTextAlignmentCenter];
        contentLabel.text = content;
        contentLabel.numberOfLines = 0;
        [alertView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(alertView.mas_right).offset(-20);
            make.top.mas_equalTo(titleLabel.mas_bottom).offset(32);
        }];
        
        UIButton *button = [UIButton buttonWithTitle:buttonTitle font:18 titleColor:[UIColor whiteColor] backGroundColor:nil aligment:0];
        [button addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:GetImage(@"jianbianxaio") forState:UIControlStateNormal];
        [alertView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(48);
            make.right.mas_equalTo(alertView.mas_right).offset(-48);
            make.bottom.mas_equalTo(alertView.mas_bottom).offset(-16);
            make.height.mas_equalTo(40);
        }];
        
        [alertView sendSubviewToBack:imageView];
//        [[UIApplication sharedApplication].keyWindow addSubview:backView];
    }
    return self;
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)cancelAction:(UIButton *)sender{
    [self removeFromSuperview];
}

@end
