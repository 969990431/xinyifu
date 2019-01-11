//
//  UserSetViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UserSetViewController.h"
#import "UserSetTableViewCell.h"
#import "ChangePhoneOldViewController.h"
#import "AboutUsViewController.h"
#import "ResetPasswordViewController.h"
#import "XYFAlertView.h"

@interface UserSetViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *backTableView;

@end

@implementation UserSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
}
- (void)prepareViews {
    self.title = @"设置";
    self.view.backgroundColor = UIColorFromRGB(248, 248, 248);
    
    self.backTableView = [[UITableView alloc]init];
    self.backTableView.delegate = self;
    self.backTableView.dataSource = self;
    self.backTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 1 ? 1:2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UserSetTableViewCell cellWithTableView:tableView indexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseViewController *vc;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
//            密码设置
            vc = [[ResetPasswordViewController alloc] init];
        }else {
//            更换手机号
            vc = [[ChangePhoneOldViewController alloc]init];
        }
    }else if (indexPath.section == 1) {
//        用户协议
    }else {
        if (indexPath.row == 0) {
//关于
            vc = [[AboutUsViewController alloc] init];
        }else {
//            联系客服
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"40008882234"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:nil completionHandler:nil];
            return;
        }
    }
    [self.navigationController pushViewController:vc animated:YES];
}
@end
