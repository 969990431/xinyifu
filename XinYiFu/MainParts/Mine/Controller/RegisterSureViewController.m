//
//  RegisterSureViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018 apple. All rights reserved.
//

#import "RegisterSureViewController.h"

@interface RegisterSureViewController ()
@property (nonatomic, strong)UITableView *backTableView;
@property (nonatomic, strong)UIButton *backBtn;

@property (nonatomic, strong)UIImageView *logoImageV;
@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)UILabel *passwdLabel;
@property (nonatomic, strong)UITextField *passwdTF;
@property (nonatomic, strong)UIButton *firstEyeBtn;
@property (nonatomic, strong)UILabel *contentLabel;

@property (nonatomic, strong)UILabel *passwdAgainLabel;
@property (nonatomic, strong)UITextField *passwdAgainTF;
@property (nonatomic, strong)UIButton *secondEyeBtn;


@property (nonatomic, strong)UIButton *completeBtn;

@property (nonatomic, assign)BOOL firstSecure;
@property (nonatomic, assign)BOOL secondSecure;
@end

@implementation RegisterSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}

- (void)prepareViews {
    
    
    self.backTableView = [[UITableView alloc]init];
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
//    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.backBtn setBackgroundImage:GetImage(@"back") forState:UIControlStateNormal];
//    [self.backTableView addSubview:self.backBtn];
//    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(20);
//        make.top.mas_equalTo(33);
//        make.size.mas_equalTo(CGSizeMake(8, 16));
//    }];
//
//    UIButton *bigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [bigBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//    //    bigBtn.backgroundColor = RandomColor;
//    [self.backTableView addSubview:bigBtn];
//    [bigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_equalTo(0);
//        make.size.mas_equalTo(100);
//    }];
    
    self.titleLabel = [UILabel labelWithTextColor:[UIColor blackColor] font:24 aligment:NSTextAlignmentLeft];
    self.titleLabel.text = @"注册";
    [self.backTableView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(76);
        make.height.mas_equalTo(33);
    }];
    
    self.logoImageV = [[UIImageView alloc]initWithImage:GetImage(@"2zhucelogo")];
    [self.backTableView addSubview:self.logoImageV];
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    
    self.passwdLabel = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
    self.passwdLabel.text = @"密码";
    [self.backTableView addSubview:self.passwdLabel];
    [self.passwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(51);
        make.height.mas_equalTo(22);
    }];
    
    self.passwdTF = [UITextField textFieldWithPlaceHolder:@"请输入新密码"];
    [self.passwdTF addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.backTableView addSubview:self.passwdTF];
    [self.passwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.passwdLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-75);
        make.height.mas_equalTo(43);
    }];
    
    
    UILabel *segLine1 = [[UILabel alloc]init];
    segLine1.backgroundColor = SegGray;
    [self.backTableView addSubview:segLine1];
    [segLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.passwdTF.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.firstEyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.firstEyeBtn addTarget:self action:@selector(clickEye:) forControlEvents:UIControlEventTouchUpInside];
    self.firstEyeBtn.tag = 100;
    [self.firstEyeBtn setBackgroundImage:GetImage(@"5眼睛睁") forState:UIControlStateNormal];
    [self.backTableView addSubview:self.firstEyeBtn];
    [self.firstEyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(segLine1.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.passwdTF);
        make.size.mas_equalTo(CGSizeMake(22, 12));
    }];
    
    
    self.contentLabel = [UILabel labelWithTextColor:WordGray font:13 aligment:NSTextAlignmentLeft];
    self.contentLabel.text = @"长度为8-16位，必须包含字母和数字";
    [self.backTableView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(segLine1.mas_bottom).offset(5);
        make.height.mas_equalTo(18);
    }];
    
    self.passwdAgainLabel = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
    self.passwdAgainLabel.text = @"确认密码";
    [self.backTableView addSubview:self.passwdAgainLabel];
    [self.passwdAgainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(segLine1.mas_bottom).offset(50);
        make.height.mas_equalTo(22);
    }];
    
    self.passwdAgainTF = [UITextField textFieldWithPlaceHolder:@"请在此输入新密码"];
    [self.passwdAgainTF addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.backTableView addSubview:self.passwdAgainTF];
    [self.passwdAgainTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.passwdAgainLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-75);
        make.height.mas_equalTo(43);
    }];
    
    UILabel *segLine2 = [[UILabel alloc]init];
    segLine2.backgroundColor = SegGray;
    [self.backTableView addSubview:segLine2];
    [segLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.passwdAgainTF.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.secondEyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.secondEyeBtn addTarget:self action:@selector(clickEye:) forControlEvents:UIControlEventTouchUpInside];
    self.secondEyeBtn.tag = 101;
    [self.secondEyeBtn setBackgroundImage:GetImage(@"5眼睛睁") forState:UIControlStateNormal];
    [self.backTableView addSubview:self.secondEyeBtn];
    [self.secondEyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(segLine2.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.passwdAgainTF);
        make.size.mas_equalTo(CGSizeMake(22, 12));
    }];
    
    self.completeBtn = [UIButton buttonWithTitle:@"确定" font:18 titleColor:[UIColor whiteColor] backGroundColor:nil aligment:0];
    [self.completeBtn addTarget:self action:@selector(completeClick:) forControlEvents:UIControlEventTouchUpInside];
    self.completeBtn.enabled = NO;
    self.completeBtn.layer.masksToBounds = 1;
    self.completeBtn.layer.cornerRadius = 20;
    [self.completeBtn setBackgroundImage:GetImage(@"hui") forState:UIControlStateNormal];
    [self.backTableView addSubview:self.completeBtn];
    [self.completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(segLine2.mas_bottom).offset(40);
    }];
    
    
    
    
}

- (void)clickEye: (UIButton *)sender {
    if (sender.tag == 100) {
        self.firstSecure = !self.firstSecure;
        self.passwdTF.secureTextEntry = self.firstSecure;
        if (!self.firstSecure) {
            [self.firstEyeBtn setBackgroundImage:GetImage(@"5眼睛睁") forState:UIControlStateNormal];
        }else {
            [self.firstEyeBtn setBackgroundImage:GetImage(@"4眼睛闭") forState:UIControlStateNormal];
        }
    }else {
        self.secondSecure = !self.secondSecure;
        self.passwdAgainTF.secureTextEntry = self.secondSecure;
        if (!self.secondSecure) {
            [self.secondEyeBtn setBackgroundImage:GetImage(@"5眼睛睁") forState:UIControlStateNormal];
        }else {
            [self.secondEyeBtn setBackgroundImage:GetImage(@"4眼睛闭") forState:UIControlStateNormal];
        }
    }
}

- (void)textfieldChanged: (UITextField *)textField {
    if (![self.passwdTF.text isNullString] && ![self.passwdAgainTF.text isNullString]) {
        [self.completeBtn setBackgroundImage:GetImage(@"jianbianda") forState:UIControlStateNormal];
        [self.completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.completeBtn.enabled = YES;
    }else {
        [self.completeBtn setBackgroundImage:GetImage(@"hui") forState:UIControlStateNormal];
        [self.completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.completeBtn.enabled = NO;
    }
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)completeClick: (UIButton *)button {
    if (![self.passwdTF.text isEqualToString:self.passwdAgainTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码不一致"];
    }
    [[RequestTool shareManager]sendNewRequestWithAPI:@"/api/register" withVC:self withParams:@{@"mobile":self.mobile, @"password":self.passwdTF.text} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
}
@end
