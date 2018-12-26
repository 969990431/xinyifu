//
//  AuthStatusViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AuthStatusViewController.h"

@interface AuthStatusViewController ()
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *textLabel;
@property (nonatomic, strong)UIButton *sureBtn;
//1 成功 2 失败 3 审核中
@property (nonatomic, assign)NSInteger type;

@end

@implementation AuthStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
}

- (void)prepareViews {
    self.type = 2;
    
    self.imageV = [[UIImageView alloc]init];
    [self.view addSubview:self.imageV];
    
    
    self.textLabel = [UILabel labelWithTextColor:[UIColor blackColor] font:16 aligment:NSTextAlignmentCenter];
    [self.view addSubview:self.textLabel];
    
    self.sureBtn = [UIButton buttonWithTitle:nil font:18 titleColor:[UIColor whiteColor] backGroundColor:nil aligment:0];
    [self.view addSubview:self.sureBtn];
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.layer.cornerRadius = 20;
    
    if (self.type == 0) {
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view).offset(61+ (iPhoneX ? 88:64));
            make.size.mas_equalTo(120);
        }];
        [self.imageV setImage:GetImage(@"shibai")];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(50);
            make.right.mas_equalTo(-50);
            make.top.mas_equalTo(self.imageV.mas_bottom).offset(36);
            make.height.mas_equalTo(80);
        }];
        self.textLabel.numberOfLines = 0;
        self.textLabel.attributedText = [@"您认证的信息有误，导致认证失败，可先联系客服400-000-890或者重新选择身份认证"changeFont:[UIFont systemFontOfSize:18] andRanges:@[[NSValue valueWithRange:NSMakeRange(22, 11)], [NSValue valueWithRange:NSMakeRange(35, 8)]]];
        
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(68);
            make.right.mas_equalTo(-68);
            make.top.mas_equalTo(self.textLabel.mas_bottom).offset(79);
            make.height.mas_equalTo(40);
        }];
        [self.sureBtn setTitle:@"重新认证" forState:UIControlStateNormal];
        [self.sureBtn setBackgroundImage:GetImage(@"keyidianji") forState:UIControlStateNormal];
    }else if (self.type == 1) {
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view).offset(61+ (iPhoneX ? 88:64));
            make.size.mas_equalTo(120);
        }];
        [self.imageV setImage:GetImage(@"chenggong")];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.imageV.mas_bottom).offset(36);
            make.height.mas_equalTo(22);
        }];
        self.textLabel.text = @"认证成功，赶快体验吧";
        
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(68);
            make.right.mas_equalTo(-68);
            make.top.mas_equalTo(self.textLabel.mas_bottom).offset(79);
            make.height.mas_equalTo(40);
        }];
        [self.sureBtn setTitle:@"立即体验" forState:UIControlStateNormal];
        [self.sureBtn setBackgroundImage:GetImage(@"keyidianji") forState:UIControlStateNormal];
    }else {
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view).offset(61+ (iPhoneX ? 88:64));
            make.size.mas_equalTo(CGSizeMake(168, 157));
        }];
        [self.imageV setImage:GetImage(@"shenhezhong(1)")];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(50);
            make.right.mas_equalTo(-50);
            make.top.mas_equalTo(self.imageV.mas_bottom).offset(36);
            make.height.mas_equalTo(80);
        }];
        self.textLabel.numberOfLines = 0;
        self.textLabel.attributedText = [@"您认证的信息正在审核中，三个工作日内给您回复，请您耐心等待！如有疑问请联系客服400-000-890"changeFont:[UIFont systemFontOfSize:18] andRange:NSMakeRange(39, 11)];
        
        self.sureBtn.hidden = 1;
    }
}

@end
