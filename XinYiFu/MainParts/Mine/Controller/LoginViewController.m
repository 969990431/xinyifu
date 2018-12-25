//
//  LoginViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "FoundPasswordViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()
@property (nonatomic, strong)UITableView *backTableView;

@property (nonatomic, strong)UIImageView *logoImageV;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *contentLabel;

@property (nonatomic, strong)UILabel *phoneLabel;
@property (nonatomic, strong)UITextField *phoneTF;

@property (nonatomic, strong)UILabel *passWordLabel;
@property (nonatomic, strong)UITextField *passWordTF;

@property (nonatomic, strong)UIButton *eyeBtn;
@property (nonatomic, strong)UIButton *memoryBtn;
@property (nonatomic, strong)UILabel *memoryLabel;
@property (nonatomic, strong)UIButton *forgetPasswordBtn;
@property (nonatomic, strong)UIButton *loginBtn;
@property (nonatomic, strong)UILabel *agreementLabel;
@property (nonatomic, strong)UILabel *registerLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
}

- (void)prepareViews {
    self.backTableView = [[UITableView alloc]init];
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.logoImageV = [[UIImageView alloc]initWithImage:GetImage(@"1denglulogo")];
    [self.backTableView addSubview:self.logoImageV];
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.top.mas_equalTo(72);
        make.size.mas_equalTo(48);
    }];
    
    self.titleLabel = [UILabel labelWithTextColor:[UIColor blackColor] font:24 aligment:NSTextAlignmentLeft];
    self.titleLabel.text = @"欢迎登录，薪易付！";
    [self.backTableView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.top.mas_equalTo(self.logoImageV.mas_bottom).offset(8);
        make.height.mas_equalTo(33);
    }];
    
    self.contentLabel = [UILabel labelWithTextColor:WordGray font:15 aligment:NSTextAlignmentLeft];
    self.contentLabel.text = @"一“码”管理多“码”的账";
    [self.backTableView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(3);
        make.height.mas_equalTo(21);
    }];
    
    self.phoneLabel = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
    self.phoneLabel.text = @"手机号";
    [self.backTableView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(49);
        make.height.mas_equalTo(22);
    }];
    
    self.phoneTF = [UITextField textFieldWithPlaceHolder:@"请输入手机号"];
    [self.phoneTF addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.backTableView addSubview:self.phoneTF];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.top.mas_equalTo(self.phoneLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-35);
        make.height.mas_equalTo(43);
    }];
    
    UILabel *segLine1 = [[UILabel alloc]init];
    segLine1.backgroundColor = SegGray;
    [self.backTableView addSubview:segLine1];
    [segLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(self.view.mas_right).offset(-35);
        make.top.mas_equalTo(self.phoneTF.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.passWordLabel = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
    self.passWordLabel.text = @"密码";
    [self.backTableView addSubview:self.passWordLabel];
    [self.passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.top.mas_equalTo(segLine1.mas_bottom).offset(20);
        make.height.mas_equalTo(22);
    }];
    
    self.passWordTF = [UITextField textFieldWithPlaceHolder:@"请输入密码"];
    [self.passWordTF addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.backTableView addSubview:self.passWordTF];
    [self.passWordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.top.mas_equalTo(self.passWordLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-85);
        make.height.mas_equalTo(43);
    }];
    
    UILabel *segLine2 = [[UILabel alloc]init];
    segLine2.backgroundColor = SegGray;
    [self.backTableView addSubview:segLine2];
    [segLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(self.view.mas_right).offset(-35);
        make.top.mas_equalTo(self.passWordTF.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.eyeBtn setBackgroundImage:GetImage(@"5眼睛睁") forState:UIControlStateNormal];
    [self.backTableView addSubview:self.eyeBtn];
    [self.eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(segLine2.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.passWordTF);
        make.size.mas_equalTo(CGSizeMake(22, 12));
    }];
    
    self.memoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.memoryBtn setBackgroundImage:GetImage(@"9已选择") forState:UIControlStateNormal];
    [self.backTableView addSubview:self.memoryBtn];
    [self.memoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.top.mas_equalTo(segLine2.mas_bottom).offset(13);
        make.size.mas_equalTo(13);
    }];
    
    self.memoryLabel = [UILabel labelWithTextColor:WordDeepGray font:13 aligment:NSTextAlignmentLeft];
    self.memoryLabel.text = @"记住密码";
    [self.backTableView addSubview:self.memoryLabel];
    [self.memoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.memoryBtn.mas_right).offset(15);
        make.centerY.mas_equalTo(self.memoryBtn);
        make.height.mas_equalTo(22);
    }];
    
    self.forgetPasswordBtn = [UIButton buttonWithTitle:@"忘记密码？" font:13 titleColor:WordDeepGray backGroundColor:nil aligment:UIControlContentHorizontalAlignmentRight];
    [self.forgetPasswordBtn addTarget:self action:@selector(forgetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backTableView addSubview:self.forgetPasswordBtn];
    [self.forgetPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.memoryLabel);
        make.right.mas_equalTo(segLine2.mas_right);;
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    
    self.loginBtn = [UIButton buttonWithTitle:@"登录" font:18 titleColor:[UIColor grayColor] backGroundColor:nil aligment:0];
    self.loginBtn.layer.masksToBounds = 1;
    self.loginBtn.layer.cornerRadius = 20;
    [self.loginBtn setBackgroundImage:GetImage(@"hui") forState:UIControlStateNormal];
    [self.backTableView addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(self.view.mas_right).offset(-35);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(segLine2.mas_bottom).offset(62);
    }];
    
    self.agreementLabel = [UILabel labelWithTextColor:WordDeepGray font:12 aligment:NSTextAlignmentCenter];
    [self.backTableView addSubview:self.agreementLabel];
    [self.agreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(6);
        make.height.mas_equalTo(17);
    }];
    self.agreementLabel.attributedText = [@"登录薪易付，就表示您同意了《用户协议》"changeColor:WordRed andRange:NSMakeRange(13, 6)];
    
    self.registerLabel = [UILabel labelWithTextColor:WordDeepGray font:15 aligment:NSTextAlignmentCenter];
    [self.backTableView addSubview:self.registerLabel];
    [self.registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-27);
        make.height.mas_equalTo(21);
    }];
    self.registerLabel.attributedText = [@"还没有账号？立即注册"changeColor:WordOrange andRange:NSMakeRange(6, 4)];
    
    self.registerLabel.userInteractionEnabled = 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickRegister)];
    [self.registerLabel addGestureRecognizer:tap];
}

- (void)textfieldChanged: (UITextField *)textField {
    if (![self.phoneTF.text isNullString] && ![self.passWordTF.text isNullString]) {
        [self.loginBtn setBackgroundImage:GetImage(@"jianbianda") forState:UIControlStateNormal];
        [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else {
        [self.loginBtn setBackgroundImage:GetImage(@"hui") forState:UIControlStateNormal];
        [self.loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

- (void)forgetPasswordAction:(UIButton *)sender{
    [self presentViewController:[[FoundPasswordViewController alloc]init] animated:YES completion:nil];
//    [self.navigationController pushViewController:[[FoundPasswordViewController alloc]init] animated:YES];
}

- (void)clickRegister {
    [self presentViewController:[[RegisterViewController alloc]init] animated:YES completion:nil];
}

@end