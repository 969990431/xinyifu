//
//  NoNetworkView.m
//  XinYiFu
//
//  Created by apple on 2018/12/29.
//  Copyright © 2018 apple. All rights reserved.
//

#import "NoNetworkView.h"

@interface NoNetworkView ()
@property (nonatomic ,assign) id<NoNetworkViewDelegate> delegate;
@end
@implementation NoNetworkView

+ (void)showWithDelegate:(id<NoNetworkViewDelegate>)delegate{
    NoNetworkView *view = [[NoNetworkView alloc]initWithDelegate:delegate];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}
- (UIView *)initWithDelegate:(id<NoNetworkViewDelegate>)delegate{
    if (self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *image = [[UIImageView alloc] initWithImage:GetImage(@"wuwangluo")];
        [self addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self).offset(-50);
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(294);
            make.height.mas_equalTo(238);
        }];
        
        UILabel *label = [UILabel labelWithTextColor:AlertGray font:16 aligment:NSTextAlignmentCenter];
        label.text = @"网络出现问题了，请刷新试~";
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(image.mas_bottom).offset(-8);
            make.height.mas_equalTo(22);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:GetImage(@"shuaxin") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(image.mas_bottom).offset(52);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(46);
        }];
        self.delegate = delegate;
    }
    return self;
}

- (void)refreshData{
    [self.delegate refreshData];
    [self removeFromSuperview];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
