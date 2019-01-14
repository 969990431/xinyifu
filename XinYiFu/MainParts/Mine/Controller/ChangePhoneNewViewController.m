//
//  ChangePhoneNewViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ChangePhoneNewViewController.h"

@interface ChangePhoneNewViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *backTableView;
@property (nonatomic, strong)UIButton *submitBtn;

@property (nonatomic, strong)UITextField *phoneNoTF;
@property (nonatomic, strong)UITextField *codeTF;
@property (nonatomic, strong)UIButton *codeBtn;

@property (nonatomic, strong)NSString *phoneNo;
@property (nonatomic, strong)NSString *code;
@property (nonatomic , assign) int time;


@end

@implementation ChangePhoneNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
}

- (void)prepareViews {
    self.view.backgroundColor = BackGrayColor;
    self.title = @"更换手机号";
    
    self.backTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.backTableView.delegate = self;
    self.backTableView.dataSource = self;
    self.backTableView.backgroundColor = BackGrayColor;
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }else{
        return 0.5;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 1 ? 70:0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        self.submitBtn = [UIButton buttonWithTitle:@"确定更换" textColor:[UIColor whiteColor] backGroundColor:UIColorFromRGB(254, 173, 148) font:18];
        [self.submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
        self.submitBtn.layer.masksToBounds = YES;
        self.submitBtn.layer.cornerRadius = 4;
        self.submitBtn.userInteractionEnabled = NO;
        [self.submitBtn setBackgroundImage:GetImage(@"jinemeidianji") forState:UIControlStateNormal];
        [footer addSubview:self.submitBtn];
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        
        return footer;
    }else {
        return nil;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [[UITableViewCell alloc]init];
        UILabel *titlelabel = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentLeft];
        titlelabel.text = @"新手机号";
        [cell addSubview:titlelabel];
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(70);
            make.centerY.mas_equalTo(cell);
            make.height.mas_equalTo(22);
        }];
        
        self.phoneNoTF = [UITextField textFieldWithPlaceHolder:@"请输入手机号"];
        self.phoneNoTF.tag = 100;
        [self.phoneNoTF addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        [cell addSubview:self.phoneNoTF];
        [self.phoneNoTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titlelabel.mas_right).offset(20);
            make.centerY.mas_equalTo(cell);
            make.height.mas_equalTo(22);
            make.right.mas_equalTo(-20);
        }];
        
    }else {
        cell = [[UITableViewCell alloc]init];
        UILabel *titlelabel = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentLeft];
        titlelabel.text = @"验证码";
        [cell addSubview:titlelabel];
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(70);
            make.centerY.mas_equalTo(cell);
            make.height.mas_equalTo(22);
        }];
        
        self.codeTF = [UITextField textFieldWithPlaceHolder:@"请输入验证码"];
        self.codeTF.tag = 101;
        [self.codeTF addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        [cell addSubview:self.codeTF];
        [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titlelabel.mas_right).offset(20);
            make.centerY.mas_equalTo(cell);
            make.height.mas_equalTo(22);
            make.right.mas_equalTo(-100);
        }];
        
        self.codeBtn = [UIButton buttonWithTitle:@"获取验证码" font:15 titleColor:WordGreen backGroundColor:nil aligment:UIControlContentHorizontalAlignmentCenter];
        [self.codeBtn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.codeBtn];
        [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(cell);
            make.size.mas_equalTo(CGSizeMake(80, 22));
        }];
    }
    cell.selectionStyle = NO;
    return cell;
}
- (void)textChange: (UITextField *)textField {
    if (self.phoneNoTF.text.length>=11) {
        [self.codeTF becomeFirstResponder];
    }
    
    if (textField.tag == 100) {
        self.phoneNo = textField.text;
    }else {
        self.code = textField.text;
    }
    
    if (![self.code isNullString] && ![self.phoneNo isNullString]) {
        [self.submitBtn setBackgroundImage:GetImage(@"keyidianji") forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = YES;
    }else {
        [self.submitBtn setBackgroundImage:GetImage(@"jinemeidianji") forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = NO;
    }
}
- (void)sendCode: (UIButton *)sender {
    
    sender.userInteractionEnabled = NO;
    [[RequestTool shareManager]sendNewRequestWithAPI:@"/api/sms/send" withVC:self withParams:@{@"mobile":self.phoneNoTF.text} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            [self getCodeAction:self.codeBtn];
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
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

- (void)submitAction: (UIButton *)sender {
    [[RequestTool shareManager]sendNewRequestWithAPI:@"/api/reset/mobile" withVC:self withParams:@{@"mobile":self.phoneNoTF.text, @"valid":self.codeTF.text} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            [SVProgressHUD showSuccessWithStatus:@"更换手机号成功"];
            [UserPreferenceModel shareManager].mobile = self.phoneNoTF.text;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
}

@end
