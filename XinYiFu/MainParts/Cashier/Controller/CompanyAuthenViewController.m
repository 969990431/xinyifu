//
//  CompanyAuthenViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CompanyAuthenViewController.h"
#import "EditInfoTableViewCell.h"
#import "AuthStatusViewController.h"

@interface CompanyAuthenViewController ()<UITableViewDelegate, UITableViewDataSource,EditInfoTableViewCellDelegate>
@property (nonatomic, strong)UITableView *backTableView;
@property (nonatomic, strong)UIButton *submitBtn;

@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, strong)NSArray *placeHolderArray;

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *idNumber;
@property (nonatomic, copy)NSString *creditNumber;
@property (nonatomic, copy)NSString *bankNumber;
@property (nonatomic, copy)NSString *telNumber;

@end

@implementation CompanyAuthenViewController

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"法人姓名", @"法人身份证",@"营业执照统一代码", @"开户行帐号",@"手机号"];
    }
    return _titleArray;
}
- (NSArray *)placeHolderArray {
    if (!_placeHolderArray) {
        _placeHolderArray = @[@"请输入真实姓名", @"请输入法人身份证号", @"请输入统一征信代码",@"请输入开户行帐号", @"请输入开户行预留手机号"];
    }
    return _placeHolderArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
}

- (void)prepareViews {
    self.view.backgroundColor = BackGrayColor;
    self.title = @"企业认证";
    
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
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }else if (section == 1 || section == 4) {
        return 0.5;
    }else {
        return 10;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        UIImageView *imageV = [[UIImageView alloc]initWithImage:GetImage(@"3提示号")];
        [header addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(header);
            make.left.mas_equalTo(20);
            make.size.mas_equalTo(13);
        }];
        
        UILabel *label = [UILabel labelWithTextColor:UIColorFromRGB(246, 170, 18) font:12 aligment:NSTextAlignmentLeft];
        [header addSubview:label];
        label.text = @"温馨提示：请仔细填写信息哦！";
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageV.mas_right).offset(15);
            make.centerY.mas_equalTo(header);
            make.height.mas_equalTo(17);
        }];
        return header;
    }else {
        return [[UIView alloc]init];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 4 ? 70:0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 4) {
        UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        self.submitBtn = [UIButton buttonWithTitle:@"提交" textColor:[UIColor whiteColor] backGroundColor:UIColorFromRGB(254, 173, 148) font:18];
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
    EditInfoTableViewCell *cell = [EditInfoTableViewCell cellWithTableView:tableView indexPath:indexPath delegate:self type:0 title:self.titleArray[indexPath.section] placeHolder:self.placeHolderArray[indexPath.section]];
    if (indexPath.section == 0) {
        self.name = cell.textField.text;
    }else if (indexPath.section == 1) {
        self.idNumber = cell.textField.text;
    }else if (indexPath.section == 2) {
        self.creditNumber = cell.textField.text;
    }else if (indexPath.section == 3) {
        self.bankNumber = cell.textField.text;
    }else if (indexPath.section == 4) {
        self.telNumber = cell.textField.text;
    }
    cell.textField.tag = indexPath.section + 100;
    [cell.textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    return cell;
}
- (void)textChange: (UITextField *)textField {
    if (textField.tag == 100) {
        self.name = textField.text;
    }else if (textField.tag == 101) {
        self.idNumber = textField.text;
    }else if (textField.tag == 102) {
        self.creditNumber = textField.text;
    }else if (textField.tag == 103) {
        self.bankNumber = textField.text;
    }else if (textField.tag == 104) {
        self.telNumber = textField.text;
    }
    
    if (![self.name isNullString] && ![self.idNumber isNullString] && ![self.bankNumber isNullString] && ![self.telNumber isNullString] && ![self.creditNumber isNullString]) {
        [self.submitBtn setBackgroundImage:GetImage(@"keyidianji") forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = YES;
    }else {
        [self.submitBtn setBackgroundImage:GetImage(@"jinemeidianji") forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = NO;
    }
}

- (void)submitAction: (UIButton *)sender {
    [[RequestTool shareManager]sendRequestWithAPI:@"/api/save/company" withVC:self withParams:@{@"token":[UserPreferenceModel shareManager].token,@"legalPersonName":self.name, @"legalCertId":self.idNumber, @"companyCode":self.creditNumber, @"companyBankNo":self.bankNumber, @"companyBankMobile":self.telNumber} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            AuthStatusViewController *authVC = [[AuthStatusViewController alloc]init];
            [self.navigationController pushViewController:authVC animated:YES];
        }else {
            [SVProgressHUD showWithStatus:errorMessage];
        }
    }];
    
}

@end
