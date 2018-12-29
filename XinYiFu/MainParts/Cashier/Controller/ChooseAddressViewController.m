//
//  ChooseAddressViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ChooseAddressViewController.h"
#import "AddAddressViewController.h"

@interface ChooseAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *backTableView;
@property (nonatomic , strong) UIButton *submitBtn;
@end

@implementation ChooseAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择地址";
    [self prepareViews];
}

- (void)prepareViews{
    self.backTableView = [[UITableView alloc]initWithFrame:CGRectNull style:UITableViewStyleGrouped];
    self.backTableView.dataSource = self;
    self.backTableView.delegate = self;
    self.backTableView.backgroundColor = ThemeColor;
    self.backTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    self.backTableView.sectionHeaderHeight = CGFLOAT_MIN;
    self.backTableView.sectionFooterHeight = 6.f;
    self.backTableView.separatorStyle = NO;
    [self.view addSubview:self.backTableView];
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100)];
    self.backTableView.tableFooterView = footerView;
    
    self.submitBtn = [UIButton buttonWithTitle:@"使用其他地址" font:18 titleColor:[UIColor whiteColor] backGroundColor:nil aligment:0];
    [self.submitBtn setBackgroundImage:GetImage(@"keyidianji") forState:UIControlStateNormal];
    [self.submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    UILabel *name = [UILabel labelWithTextColor:WordCloseBlack font:18 aligment:NSTextAlignmentLeft];
    name.text = @"李梦龙";
    [cell.contentView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(6);
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(26);
    }];
    
    UILabel *phone = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentLeft];
    phone.text = @"15061473870";
    [cell.contentView addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(name);
        make.left.mas_equalTo(name.mas_right).offset(18);
        make.height.mas_equalTo(22);
    }];

    UILabel *address = [UILabel labelWithTextColor:WordDeepGray font:14 aligment:NSTextAlignmentLeft];
    address.text = @"江苏省无锡市新吴区机场路100号原日报社";
    [cell.contentView addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(name.mas_bottom).offset(6);
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(20);
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64.f;
}

- (void)submitBtnAction:(UIButton *)sender{
    [self.navigationController pushViewController:[[AddAddressViewController alloc] init] animated:YES];
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
