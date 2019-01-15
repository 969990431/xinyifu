//
//  ResetPasswordViewController.m
//  XinYiFu
//
//  Created by apple on 2019/1/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,retain) UITableView *backTableView;

@property (nonatomic ,retain) UITextField *passwordTF;
@property (nonatomic ,retain) UITextField *checkoutTF;

@property (nonatomic ,retain) UIButton *submitBtn;
@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置登录密码";
    [self prepareViews];
}

- (void)prepareViews{
    self.backTableView = [[UITableView alloc]init];
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    self.backTableView.delegate = self;
    self.backTableView.dataSource = self;
    self.backTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    self.backTableView.backgroundColor = ThemeColor;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 80)];
    self.backTableView.tableFooterView = tableFooterView;
    
    self.submitBtn = [UIButton buttonWithTitle:@"保存" font:18 titleColor:[UIColor whiteColor] backGroundColor:nil aligment:0];
    self.submitBtn.userInteractionEnabled = YES;
    [self.submitBtn setBackgroundImage:GetImage(@"jinemeidianji") forState:UIControlStateNormal];
    [self.submitBtn addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [tableFooterView addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(self.view.mas_right).offset(-16);
        make.top.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    UILabel *title = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
    [cell.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(cell.contentView);
        make.height.mas_equalTo(11);
    }];
    
    UIButton *eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [eyeBtn addTarget:self action:@selector(eyeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [eyeBtn setBackgroundImage:GetImage(@"4眼睛闭") forState:UIControlStateNormal];
    [eyeBtn setBackgroundImage:GetImage(@"5眼睛睁") forState:UIControlStateSelected];
    eyeBtn.tag = 20190107+indexPath.row;
    [cell.contentView addSubview:eyeBtn];
    [eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(cell.contentView.mas_right).offset(-20);
        make.centerY.mas_equalTo(cell.contentView);
        make.size.mas_equalTo(CGSizeMake(22, 12));
    }];

    if (indexPath.row == 0) {
        title.text = @"旧密码";
        self.passwordTF = [UITextField textFieldWithPlaceHolder:@"请输入旧密码"];
        self.passwordTF.font = [UIFont systemFontOfSize:16.f];
        self.passwordTF.secureTextEntry = YES;
        [self.passwordTF addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.passwordTF];
        [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(100);
            make.centerY.mas_equalTo(cell.contentView);
            make.right.mas_equalTo(cell.contentView.mas_right).offset(-50);
        }];
    }else{
        title.text = @"新密码";
        self.checkoutTF = [UITextField textFieldWithPlaceHolder:@"请输入新密码"];
        self.checkoutTF.font = [UIFont systemFontOfSize:16.f];
        self.checkoutTF.secureTextEntry = YES;
        [self.checkoutTF addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:self.checkoutTF];
        [self.checkoutTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(100);
            make.centerY.mas_equalTo(cell.contentView);
            make.right.mas_equalTo(cell.contentView.mas_right).offset(-50);
        }];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}

- (void)eyeBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.tag == 20190107) {
        self.passwordTF.secureTextEntry = !self.passwordTF.secureTextEntry;
    }else{
        self.checkoutTF.secureTextEntry = !self.checkoutTF.secureTextEntry;
    }
}

- (void)saveButtonAction:(UIButton *)sender{
    if ([self checkIsHaveNumAndLetter:self.checkoutTF.text] != 3 || self.checkoutTF.text.length < 8 || self.checkoutTF.text.length > 16) {
        [SVProgressHUD showInfoWithStatus:@"密码长度为8-16位，必须包含字母和数字"];
        return;
    }
    
    [[RequestTool shareManager]sendNewRequestWithAPI:@"api/reset/password" withVC:self withParams:@{@"password":self.passwordTF.text,@"newPassword":self.checkoutTF.text} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            [SVProgressHUD showSuccessWithStatus:@"密码修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
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

- (void)textfieldChanged:(UITextField *)sender{
    if (self.passwordTF.text.length && self.checkoutTF.text.length) {
        [self.submitBtn setBackgroundImage:GetImage(@"keyidianji") forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = YES;
    }else {
        [self.submitBtn setBackgroundImage:GetImage(@"jinemeidianji") forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = NO;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
