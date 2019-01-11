//
//  NoDataView.m
//  XinYiFu
//
//  Created by apple on 2019/1/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView

+ (void)showWithSuperView:(UIView *)superView{
    NoDataView *view = [[NoDataView alloc]initWithFrame:superView.bounds];
    [superView addSubview:view];
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(180+34+22);
        }];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 146, 180)];
        imageView.image = GetImage(@"wuneirong");
        [contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(contentView);
        }];

        UILabel *text = [UILabel labelWithTextColor:AlertGray font:16 aligment:NSTextAlignmentCenter];
        text.text = @"暂无数据展示哦~";
        [contentView addSubview:text];
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentView);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(22);
        }];
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
