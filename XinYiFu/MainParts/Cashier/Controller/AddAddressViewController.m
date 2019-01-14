//
//  AddAddressViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AddAddressViewController.h"
#import "AddressPickerView.h"

@interface AddAddressViewController ()<UITableViewDelegate,UITableViewDataSource,AddressViewDelegate>
@property (nonatomic ,strong) UITableView *backTableView;
@property (nonatomic ,strong) UIButton *submitBtn;

@property (nonatomic ,strong) UITextField *nameTF;
@property (nonatomic ,strong) UITextField *mobileTF;
@property (nonatomic ,strong) UITextField *areaTF;
@property (nonatomic ,strong) UITextField *addressTF;

@property (nonatomic ,strong) NSMutableDictionary *addressDict;
@property (nonatomic ,strong) NSArray *addressArray;
@property (nonatomic ,strong) AddressPickerView *addressPicker;
@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加收货地址";
    [self prepareViews];
    [self requestAddressData];
}

- (void)requestAddressData{
    [[RequestTool shareManager]sendNewRequestWithAPI:@"/api/combo" withVC:self withParams:@{@"type":@0} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            self.addressArray = response[@"data"];
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
}

- (NSMutableDictionary *)addressDict{
    if (!_addressDict) {
        _addressDict = [[NSMutableDictionary alloc] init];
    }
    return _addressDict;
}

- (id)addressArray{
    if (!_addressArray) {
        _addressArray = [[NSArray alloc] init];
    }
    return _addressArray;
}

- (void)prepareViews{
    self.backTableView = [[UITableView alloc]initWithFrame:CGRectNull style:UITableViewStyleGrouped];
    self.backTableView.dataSource = self;
    self.backTableView.delegate = self;
    self.backTableView.backgroundColor = BackGrayColor;
    self.backTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    self.backTableView.sectionHeaderHeight = CGFLOAT_MIN;
    self.backTableView.sectionFooterHeight = 12.f;
    self.backTableView.separatorStyle = NO;
    [self.view addSubview:self.backTableView];
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100)];
    self.backTableView.tableFooterView = footerView;
    
    self.submitBtn = [UIButton buttonWithTitle:@"确定" font:18 titleColor:[UIColor whiteColor] backGroundColor:nil aligment:0];
    self.submitBtn.userInteractionEnabled = NO;
    [self.submitBtn setBackgroundImage:GetImage(@"jinemeidianji") forState:UIControlStateNormal];
    [self.submitBtn addTarget:self action:@selector(addAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(self.view.mas_right).offset(-16);
        make.top.mas_equalTo(22);
        make.height.mas_equalTo(40);
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        UILabel *titleLabel = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
        [cell.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.left.mas_equalTo(16);
            make.height.mas_equalTo(22);
        }];
        
        if (indexPath.row == 0) {
            titleLabel.text = @"收件人";
            self.nameTF = [UITextField textFieldWithPlaceHolder:@"收件人姓名"];
            self.nameTF.font = [UIFont systemFontOfSize:16.f];
            [self.nameTF addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
            [cell.contentView addSubview:self.nameTF];
            [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.contentView);
                make.left.mas_equalTo(100);
                make.right.mas_equalTo(cell.contentView.mas_right).offset(-10);
            }];
            [self addsegLine:cell];
        }else{
            titleLabel.text = @"手机号";
            self.mobileTF = [UITextField textFieldWithPlaceHolder:@"收件人手机号"];
            self.mobileTF.font = [UIFont systemFontOfSize:16.f];
            self.mobileTF.keyboardType = UIKeyboardTypePhonePad;
            [self.mobileTF addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
            [cell.contentView addSubview:self.mobileTF];
            [self.mobileTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.contentView);
                make.left.mas_equalTo(100);
                make.right.mas_equalTo(cell.contentView.mas_right).offset(-10);
            }];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        if (indexPath.row == 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            UILabel *titleLabel = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
            titleLabel.text = @"地区";
            [cell.contentView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.contentView);
                make.left.mas_equalTo(16);
                make.height.mas_equalTo(22);
            }];
            
            self.areaTF = [UITextField textFieldWithPlaceHolder:@"请选择"];
            self.areaTF.enabled = NO;
            self.areaTF.font = [UIFont systemFontOfSize:16.f];
            [self.areaTF addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
            [cell.contentView addSubview:self.areaTF];
            [self.areaTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.contentView);
                make.left.mas_equalTo(100);
                make.right.mas_equalTo(cell.contentView.mas_right).offset(-10);
            }];

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self addsegLine:cell];
        }else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            UILabel *titleLabel = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
            titleLabel.text = @"详细地址";
            [cell.contentView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.contentView);
                make.left.mas_equalTo(16);
                make.height.mas_equalTo(22);
            }];
            
            self.addressTF = [UITextField textFieldWithPlaceHolder:@"如楼层、门牌等"];
            self.addressTF.font = [UIFont systemFontOfSize:16.f];
            [self.addressTF addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
            [cell.contentView addSubview:self.addressTF];
            [self.addressTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.contentView);
                make.left.mas_equalTo(100);
                make.right.mas_equalTo(cell.contentView.mas_right).offset(-10);
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self.view endEditing:YES];
        
        [AddressPickerView showWithData:self.addressArray delegate:self];
    }
}

- (void)completingTheSelection:(NSString *)province city:(NSString *)city area:(NSString *)area{
    [self.addressDict setObject:province forKey:@"custProv"];
    [self.addressDict setObject:city forKey:@"city"];
    NSString *text = [NSString stringWithFormat:@"%@ %@",province,city];
    if (area) {
        [self.addressDict setObject:area forKey:@"custArea"];
        text = [text stringByAppendingString:[NSString stringWithFormat:@" %@",area]];
    }
    self.areaTF.text = text;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48.f;
}

- (void)addsegLine:(UITableViewCell *)cell{
    UILabel *segLine = [[UILabel alloc]init];
    segLine.backgroundColor = SegGray;
    [cell.contentView addSubview:segLine];
    [segLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(cell.contentView.mas_right);
        make.bottom.mas_equalTo(cell.contentView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}

- (void)addAddressAction:(UIButton *)sender{
    [self.view endEditing:YES];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"name":self.nameTF.text,@"mobile":self.mobileTF.text,@"custProv":self.addressDict[@"custProv"],@"city":self.addressDict[@"city"],@"address":self.addressTF.text}];
    if (self.addressDict[@"custArea"]) {
        [dict addEntriesFromDictionary:@{@"custArea":self.addressDict[@"custArea"]}];
    }
    [[RequestTool shareManager]sendNewRequestWithAPI:@"/api/address/add" withVC:self withParams:dict withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
}

- (void)textfieldChanged:(UITextField *)sender{
    if (self.nameTF.text.length && self.mobileTF.text.length && self.areaTF.text.length && self.addressTF.text.length) {
        [self.submitBtn setBackgroundImage:GetImage(@"keyidianji") forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = YES;
    }else{
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
