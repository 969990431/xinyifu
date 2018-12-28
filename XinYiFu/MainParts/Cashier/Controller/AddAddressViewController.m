//
//  AddAddressViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AddAddressViewController.h"

@interface AddAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *backTableView;
@property (nonatomic , strong) UIButton *submitBtn;
@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加收货地址";
    [self prepareViews];
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
    [self.submitBtn setBackgroundImage:GetImage(@"keyidianji") forState:UIControlStateNormal];
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
        if (indexPath.row == 0) {
            cell = [self cellWithTitle:@"收件人" placeHolder:@"收件人姓名"];
            [self addsegLine:cell];
        }else{
            cell = [self cellWithTitle:@"手机号" placeHolder:@"收件人手机号"];
        }
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
            
            UILabel *content = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"cccccc"] font:16 aligment:NSTextAlignmentLeft];
            content.tag = 1001;
            content.text = @"请选择";
            [cell.contentView addSubview:content];
            [content mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.contentView);
                make.left.mas_equalTo(100);
            }];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self addsegLine:cell];
        }else{
            cell = [self cellWithTitle:@"详细地址" placeHolder:@"如楼层、门牌等"];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48.f;
}

- (UITableViewCell *)cellWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    UILabel *titleLabel = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
    titleLabel.text = title;
    [cell.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cell.contentView);
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(22);
    }];
    
    UITextField *contentTF = [UITextField textFieldWithPlaceHolder:placeHolder];
    contentTF.font = [UIFont systemFontOfSize:16.f];
    [cell.contentView addSubview:contentTF];
    [contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cell.contentView);
        make.left.mas_equalTo(100);
        make.right.mas_equalTo(cell.contentView.mas_right).offset(-10);
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
