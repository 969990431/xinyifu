//
//  FoundPasswordViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FoundPasswordViewController.h"
#import "SetNewPasswordViewController.h"

@interface FoundPasswordViewController()
@property (nonatomic , strong) UITableView *backTableView;
@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) UILabel *phoneLabel;
@property (nonatomic , strong) UITextField *phoneTF;

@property (nonatomic , strong) UILabel *codeLabel;
@property (nonatomic , strong) UITextField *codeTF;

@property (nonatomic , strong) UIButton *getCodeBtn;
@property (nonatomic , assign) int time;

@property (nonatomic , strong) UIButton *nextStepBtn;

@end

@implementation FoundPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
}

- (void)prepareViews{
    self.backTableView = [[UITableView alloc]init];
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.titleLabel = [UILabel labelWithTextColor:[UIColor blackColor] font:24 aligment:NSTextAlignmentLeft];
    self.titleLabel.text = @"找回密码";
    [self.backTableView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(76);
        make.height.mas_equalTo(34);
    }];

    self.phoneLabel = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
    self.phoneLabel.text = @"手机号";
    [self.backTableView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(52);
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
        make.right.mas_equalTo(self.view.mas_right).offset(-120);
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

    self.getCodeBtn = [UIButton buttonWithTitle:@"获取验证码" font:16 titleColor:WordGreen backGroundColor:nil aligment:0];
    [self.getCodeBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backTableView addSubview:self.getCodeBtn];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.codeTF);
        make.right.mas_equalTo(segLine2.mas_right).offset(-6);;
        make.size.mas_equalTo(CGSizeMake(85, 22));
    }];

    self.nextStepBtn = [UIButton buttonWithTitle:@"下一步" font:18 titleColor:WordDeepGray backGroundColor:nil aligment:0];
    self.nextStepBtn.userInteractionEnabled = NO;
    self.nextStepBtn.layer.masksToBounds = 1;
    self.nextStepBtn.layer.cornerRadius = 20;
    [self.nextStepBtn addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextStepBtn setBackgroundImage:GetImage(@"hui") forState:UIControlStateNormal];
    [self.backTableView addSubview:self.nextStepBtn];
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(segLine2.mas_bottom).offset(40);
    }];
}

- (void)textfieldChanged: (UITextField *)textField {
    if (![self.phoneTF.text isNullString] && ![self.codeTF.text isNullString]) {
        [self.nextStepBtn setBackgroundImage:GetImage(@"jianbianda") forState:UIControlStateNormal];
        [self.nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.nextStepBtn.userInteractionEnabled = YES;
    }else {
        [self.nextStepBtn setBackgroundImage:GetImage(@"hui") forState:UIControlStateNormal];
        [self.nextStepBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.nextStepBtn.userInteractionEnabled = NO;
    }
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

- (void)nextStepAction:(UIButton *)sender{
    [self presentViewController:[[SetNewPasswordViewController alloc] init] animated:YES completion:nil];
}

@end
