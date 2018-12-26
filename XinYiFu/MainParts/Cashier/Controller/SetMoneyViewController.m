//
//  SetMoneyViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "SetMoneyViewController.h"
#import "EditInfoTableViewCell.h"

@interface SetMoneyViewController ()<UITableViewDelegate, UITableViewDataSource,EditInfoTableViewCellDelegate>
@property (nonatomic, strong)UITableView *backTableView;
@property (nonatomic, strong)UIButton *submitBtn;

@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, strong)NSArray *placeHolderArray;

@property (nonatomic, copy)NSString *money;
@property (nonatomic, copy)NSString *remark;

@end

@implementation SetMoneyViewController

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"金额", @"备注"];
    }
    return _titleArray;
}
- (NSArray *)placeHolderArray {
    if (!_placeHolderArray) {
        _placeHolderArray = @[@"收款金额", @"20字以内（可不填）"];
    }
    return _placeHolderArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
}

- (void)prepareViews {
    self.view.backgroundColor = BackGrayColor;
    self.title = @"设置金额";
    
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
        self.submitBtn = [UIButton buttonWithTitle:@"确认" textColor:[UIColor whiteColor] backGroundColor:UIColorFromRGB(254, 173, 148) font:18];
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
    EditInfoTableViewCell *cell = [EditInfoTableViewCell cellWithTableView:tableView indexPath:indexPath delegate:self type:1 title:self.titleArray[indexPath.section] placeHolder:self.placeHolderArray[indexPath.section]];
    if (indexPath.section == 0) {
        self.money = cell.textField.text;
    }else {
        self.remark = cell.textField.text;
    }
    cell.textField.tag = indexPath.section + 100;
    [cell.textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    return cell;
}
- (void)textChange: (UITextField *)textField {
    if (textField.tag == 100) {
        self.money = textField.text;
    }else if (textField.tag == 101) {
        self.remark = textField.text;
    }
    
    if (![self.money isNullString]) {
        [self.submitBtn setBackgroundImage:GetImage(@"keyidianji") forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = YES;
    }else {
        [self.submitBtn setBackgroundImage:GetImage(@"jinemeidianji") forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = NO;
    }
}
- (void)submitAction: (UIButton *)sender {
    
}

@end
