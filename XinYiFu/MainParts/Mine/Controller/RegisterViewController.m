//
//  RegisterViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//


#import "RegisterViewController.h"
#import "RegisterSureViewController.h"

@interface RegisterViewController ()
@property (nonatomic, strong)UITableView *backTableView;
@property (nonatomic, strong)UIButton *backBtn;

@property (nonatomic, strong)UIImageView *logoImageV;
@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)UILabel *phoneLabel;
@property (nonatomic, strong)UITextField *phoneTF;

@property (nonatomic, strong)UILabel *codeLabel;
@property (nonatomic, strong)UITextField *codeTF;

@property (nonatomic, strong)UIButton *codeBtn;
@property (nonatomic, strong)UIButton *completeBtn;
@property (nonatomic , assign) int time;
@end

@implementation RegisterViewController

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
//        make.size.mas_equalTo(CGSizeMake(10, 20));
//    }];
    
//    UIButton *bigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [bigBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
////    bigBtn.backgroundColor = RandomColor;
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
    
    
    self.phoneLabel = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
    self.phoneLabel.text = @"手机号";
    [self.backTableView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(51);
        make.height.mas_equalTo(22);
    }];
    
    self.phoneTF = [UITextField textFieldWithPlaceHolder:@"请输入手机号"];
    [self.phoneTF addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.backTableView addSubview:self.phoneTF];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.phoneLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(43);
    }];
    
    UILabel *segLine1 = [[UILabel alloc]init];
    segLine1.backgroundColor = SegGray;
    [self.backTableView addSubview:segLine1];
    [segLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.phoneTF.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.codeLabel = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
    self.codeLabel.text = @"验证码";
    [self.backTableView addSubview:self.codeLabel];
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(segLine1.mas_bottom).offset(20);
        make.height.mas_equalTo(22);
    }];
    
    self.codeTF = [UITextField textFieldWithPlaceHolder:@"请输入验证码"];
    [self.codeTF addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.backTableView addSubview:self.codeTF];
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.codeLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-130);
        make.height.mas_equalTo(43);
    }];
    
    UILabel *segLine2 = [[UILabel alloc]init];
    segLine2.backgroundColor = SegGray;
    [self.backTableView addSubview:segLine2];
    [segLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.codeTF.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.codeBtn = [UIButton buttonWithTitle:@"获取验证码" font:15 titleColor:WordGreen backGroundColor:nil aligment:UIControlContentHorizontalAlignmentRight];
    [self.codeBtn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.backTableView addSubview:self.codeBtn];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(segLine2.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.codeTF);
        make.size.mas_equalTo(CGSizeMake(100, 21));
    }];
    
    
    
    self.completeBtn = [UIButton buttonWithTitle:@"下一步" font:18 titleColor:[UIColor whiteColor] backGroundColor:nil aligment:0];
    self.completeBtn.enabled = NO;
    [self.completeBtn addTarget:self action:@selector(completeClick:) forControlEvents:UIControlEventTouchUpInside];
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
- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendCode: (UIButton *)sender {
    if (self.phoneTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    sender.enabled = NO;
    [[RequestTool shareManager]sendRequestWithAPI:@"/api/sms/send" withVC:self withParams:@{@"mobile":self.phoneTF.text} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        
    }];
}

- (void)getCodeAction:(UIButton *)sender{
    [sender setTitle:@"60s" forState:UIControlStateNormal];
    sender.titleLabel.text = @"60s";
    sender.userInteractionEnabled = NO;
    self.time = 60;
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer){
        self.time--;
        [sender setTitle:[NSString stringWithFormat:@"%ds",self.time] forState:UIControlStateNormal];
        if (self.time <= 0) {
            [timer invalidate];
            timer = nil;
            sender.userInteractionEnabled = YES;
            [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
        }
    }];
}

- (void)textfieldChanged: (UITextField *)textField {
    if (self.phoneTF.text.length>=11) {
        [self.codeTF becomeFirstResponder];
    }
    if (![self.phoneTF.text isNullString] && ![self.codeTF.text isNullString]) {
        [self.completeBtn setBackgroundImage:GetImage(@"jianbianda") forState:UIControlStateNormal];
        [self.completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.completeBtn.enabled = YES;
    }else {
        [self.completeBtn setBackgroundImage:GetImage(@"hui") forState:UIControlStateNormal];
        [self.completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.completeBtn.enabled = NO;
    }
}

- (void)completeClick: (UIButton *)button {
    
    [[RequestTool shareManager]sendRequestWithAPI:@"/api/sms/valid" withVC:self withParams:@{@"mobile":self.phoneTF.text, @"valid":self.codeTF.text} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            RegisterSureViewController *registerVC = [[RegisterSureViewController alloc]init];
            registerVC.mobile = self.phoneTF.text;
            [self presentViewController:registerVC animated:YES completion:nil];
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
}

@end
