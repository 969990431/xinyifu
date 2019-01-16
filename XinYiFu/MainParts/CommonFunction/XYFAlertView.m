//
//  XYFAlertView.m
//  XinYiFu
//
//  Created by apple on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "XYFAlertView.h"

@interface XYFAlertView ()
@end
@implementation XYFAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (id)showAlertViewWithTitle:(NSString *)title content:(NSString *)content buttonTitle:(NSString *)buttonTitle{
    XYFAlertView *view = [[XYFAlertView alloc] initAlertViewWithTitle:title content:content buttonTitle:buttonTitle];
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    return view;
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
    if (self.block) {
        self.block();
    }
    [self removeFromSuperview];
}




+ (void)creatCallAlert {
    XYFAlertView *view = [[XYFAlertView alloc]init];
    [view callAlertSet];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}
- (void)callAlertSet {
    self.userInteractionEnabled  = YES;
    self.frame = [UIApplication sharedApplication].keyWindow.frame;
    
    self.backgroundColor = UIColorFromRGBWithAlpha(0, .5);
    
    UIView *alertView = [[UIView alloc] init];
    alertView.userInteractionEnabled = YES;
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.masksToBounds = YES;
    alertView.layer.cornerRadius = 3;
    [self addSubview:alertView];
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(GetFloatWithPXSIX(293), GetFloatWithHightPXSIX(136)));
        make.center.mas_equalTo(self);
    }];
    
    UILabel *numberLabel = [UILabel labelWithTextColor:[UIColor blackColor] font:18 aligment:NSTextAlignmentCenter];
    numberLabel.text = @"400-0888-2234";
    [alertView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(38);
        make.height.mas_equalTo(25);
    }];
    
    
    UIButton *cancel = [UIButton buttonWithTitle:@"取消" font:15 titleColor:WordDeepGray backGroundColor:nil aligment:0];
    [alertView addSubview:cancel];
    [cancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.height.mas_equalTo(39);
        make.width.mas_equalTo(GetFloatWithPXSIX(293)/2);
    }];
    
    UIButton *call = [UIButton buttonWithTitle:@"拨打" font:15 titleColor:WordGreen backGroundColor:nil aligment:0];
    [call addTarget:self action:@selector(callClick:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:call];
    [call mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(39);
        make.width.mas_equalTo(GetFloatWithPXSIX(293)/2);
    }];
    
    
    UILabel *line1 = [[UILabel alloc]init];
    [alertView addSubview:line1];
    line1.backgroundColor = SegGray;;
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-39);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *line2 = [[UILabel alloc]init];
    [alertView addSubview:line2];
    line2.backgroundColor = SegGray;;
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(alertView);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(39);
        make.width.mas_equalTo(1);
    }];
}

- (void)callClick: (UIButton *)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"40008882234"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:nil completionHandler:nil];
    
}

+ (id)showVersionUpdateView:(BOOL)isUpdate{
    XYFAlertView *view = [[XYFAlertView alloc] init];
    [view loadVersionUpdateView:isUpdate];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    return view;
}

-(void)loadVersionUpdateView:(BOOL)isUpdate{
    self.frame = [UIApplication sharedApplication].keyWindow.frame;
    
    self.backgroundColor = UIColorFromRGBWithAlpha(0, .5);

    UIView *backView = [[UIView alloc] init];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(309, 316));
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:GetImage(@"gengxin")];
    [backView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UILabel *title = [UILabel labelWithTextColor:WordCloseBlack font:18 aligment:NSTextAlignmentCenter];
    title.text = @"版本更新";
    [backView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(168);
        make.centerX.mas_equalTo(backView);
        make.height.mas_equalTo(26);
    }];
    
    UILabel *content = [UILabel labelWithTextColor:AlertGray font:16 aligment:NSTextAlignmentCenter];
    [backView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(16);
        make.centerX.mas_equalTo(title);
        make.height.mas_equalTo(22);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:GetImage(@"jianbianxaio") forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(backView.mas_bottom).offset(-14);
        make.centerX.mas_equalTo(backView);
        make.size.mas_equalTo(CGSizeMake(240, 40));
    }];
    
    if (isUpdate) {
        content.text = @"发现新版本，升级后体验更顺畅";
        [button setTitle:@"立即更新" forState:UIControlStateNormal];
    }else{
        content.text = @"已是最新版本";
        [button setTitle:@"确定" forState:UIControlStateNormal];
    }
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setBackgroundImage:GetImage(@"shanchu") forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_bottom).offset(22);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
}

- (void)closeAction:(UIButton *)sender{
    [self removeFromSuperview];
}

@end
