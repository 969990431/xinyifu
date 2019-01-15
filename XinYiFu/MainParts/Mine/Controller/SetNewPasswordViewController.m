//
//  SetNewPasswordViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "SetNewPasswordViewController.h"

@interface SetNewPasswordViewController ()
@property (nonatomic , strong) UITableView *backTableView;
@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) UILabel *passwordLabel;
@property (nonatomic , strong) UITextField *passwordTF;
@property (nonatomic, strong)UIButton *eyeBtn1;
@property (nonatomic , strong) UILabel *alertLabel;

@property (nonatomic , strong) UILabel *checkoutLabel;
@property (nonatomic , strong) UITextField *checkoutTF;
@property (nonatomic, strong)UIButton *eyeBtn2;

@property (nonatomic , strong) UIButton *submitBtn;
@end

@implementation SetNewPasswordViewController

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

- (void)prepareViews{
    self.backTableView = [[UITableView alloc]init];
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.titleLabel = [UILabel labelWithTextColor:[UIColor blackColor] font:24 aligment:NSTextAlignmentLeft];
    self.titleLabel.text = @"设置新密码";
    [self.backTableView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(14);
        make.height.mas_equalTo(34);
    }];
    
    self.passwordLabel = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
    self.passwordLabel.text = @"密码";
    [self.backTableView addSubview:self.passwordLabel];
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(52);
        make.height.mas_equalTo(22);
    }];
    
    self.passwordTF = [UITextField textFieldWithPlaceHolder:@"请输入新密码"];
    self.passwordTF.secureTextEntry = YES;
    [self.passwordTF addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.backTableView addSubview:self.passwordTF];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.passwordLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
        make.height.mas_equalTo(43);
    }];
    
    UILabel *segLine1 = [[UILabel alloc]init];
    segLine1.backgroundColor = SegGray;
    [self.backTableView addSubview:segLine1];
    [segLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.passwordTF.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.eyeBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.eyeBtn1 addTarget:self action:@selector(eyeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.eyeBtn1 setBackgroundImage:GetImage(@"4眼睛闭") forState:UIControlStateNormal];
    [self.eyeBtn1 setBackgroundImage:GetImage(@"5眼睛睁") forState:UIControlStateSelected];
    [self.backTableView addSubview:self.eyeBtn1];
    [self.eyeBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(segLine1.mas_right).offset(-6);
        make.centerY.mas_equalTo(self.passwordTF);
        make.size.mas_equalTo(CGSizeMake(22, 12));
    }];
    
    self.alertLabel = [UILabel labelWithTextColor:AlertGray font:14 aligment:NSTextAlignmentLeft];
    self.alertLabel.text = @"长度为8-16位，必须包含字母和数字";
    [self.backTableView addSubview:self.alertLabel];
    [self.alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(segLine1.mas_bottom).offset(6);
        make.height.mas_equalTo(18);
    }];
    
    self.checkoutLabel = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
    self.checkoutLabel.text = @"确认密码";
    [self.backTableView addSubview:self.checkoutLabel];
    [self.checkoutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(segLine1.mas_bottom).offset(50);
        make.height.mas_equalTo(22);
    }];

    self.checkoutTF = [UITextField textFieldWithPlaceHolder:@"请再次输入新密码"];
    self.checkoutTF.secureTextEntry = YES;
    [self.checkoutTF addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.backTableView addSubview:self.checkoutTF];
    [self.checkoutTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.checkoutLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
        make.height.mas_equalTo(43);
    }];

    UILabel *segLine2 = [[UILabel alloc]init];
    segLine2.backgroundColor = SegGray;
    [self.backTableView addSubview:segLine2];
    [segLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.checkoutTF.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.eyeBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.eyeBtn2 addTarget:self action:@selector(eyeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.eyeBtn2 setBackgroundImage:GetImage(@"4眼睛闭") forState:UIControlStateNormal];
    [self.eyeBtn2 setBackgroundImage:GetImage(@"5眼睛睁") forState:UIControlStateSelected];
    [self.backTableView addSubview:self.eyeBtn2];
    [self.eyeBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(segLine1.mas_right).offset(-6);
        make.centerY.mas_equalTo(self.checkoutTF);
        make.size.mas_equalTo(CGSizeMake(22, 12));
    }];
    
    self.submitBtn = [UIButton buttonWithTitle:@"确认" font:18 titleColor:[UIColor whiteColor] backGroundColor:nil aligment:0];
    [self.submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.submitBtn.userInteractionEnabled = NO;
    self.submitBtn.layer.masksToBounds = 1;
    self.submitBtn.layer.cornerRadius = 20;
    [self.submitBtn setBackgroundImage:GetImage(@"hui") forState:UIControlStateNormal];
    [self.backTableView addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(segLine2.mas_bottom).offset(40);
    }];
}

- (void)textfieldChanged: (UITextField *)textField {
    if (![self.passwordTF.text isNullString] && ![self.checkoutTF.text isNullString]) {
        [self.submitBtn setBackgroundImage:GetImage(@"jianbianda") forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = YES;
    }else {
        [self.submitBtn setBackgroundImage:GetImage(@"hui") forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = NO;
    }
}

- (void)submitBtnAction:(UIButton *)sender{
    if ([self checkIsHaveNumAndLetter:self.passwordTF.text] != 3 || self.passwordTF.text.length < 8 || self.passwordTF.text.length > 16) {
        [SVProgressHUD showInfoWithStatus:@"密码长度为8-16位，必须包含字母和数字"];
        [self.submitBtn setBackgroundImage:GetImage(@"hui") forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = NO;
        return;
    }
    if (![self.passwordTF.text isEqualToString:self.checkoutTF.text]) {
        [SVProgressHUD showInfoWithStatus:@"密码不一致，请重新输入"];
        [self.submitBtn setBackgroundImage:GetImage(@"hui") forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = NO;
        return;
    }
    
    [[RequestTool shareManager]sendNewRequestWithAPI:@"/api/forget/password" withVC:self withParams:@{@"mobile":self.mobile,@"password":self.checkoutTF.text} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            XYFAlertView *view = [XYFAlertView showAlertViewWithTitle:@"设置成功" content:@"密码设置成功，请重新登录密码设置成功，请重新登录密码设置成功，请重新登录" buttonTitle:@"现在登录"];
            view.block = ^(){
                [self.navigationController popToRootViewControllerAnimated:YES];
            };
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
}

-(int)checkIsHaveNumAndLetter:(NSString*)password{
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:password
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, password.length)];
    
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];

    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    if (tNumMatchCount == password.length) {
        //全部符合数字，表示沒有英文
        return 1;
    } else if (tLetterMatchCount == password.length) {
        //全部符合英文，表示沒有数字
        return 2;
    } else if (tNumMatchCount + tLetterMatchCount == password.length) {
        //符合英文和符合数字条件的相加等于密码长度
        return 3;
    } else {
        return 4;
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
    }
}

- (void)eyeBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender == self.eyeBtn1) {
        self.passwordTF.secureTextEntry = !self.passwordTF.secureTextEntry;
    }else{
        self.checkoutTF.secureTextEntry = !self.checkoutTF.secureTextEntry;
    }
}

@end
