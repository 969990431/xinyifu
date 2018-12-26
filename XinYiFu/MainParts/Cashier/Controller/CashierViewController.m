//
//  CashierViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CashierViewController.h"
#import "LoginViewController.h"
#import "UserServiceViewController.h"

#import "CashierFirstTableViewCell.h"
#import "CashierSecondTableViewCell.h"

@interface CashierViewController ()<UITableViewDelegate, UITableViewDataSource, CashierFirstTableViewCellDelegate>

/**
 显示类型
 0:已认证，可以扫码
 1:未认证
 2:审核中
 3:审核失败
 4:已认证，有二维码，有金额
 */
@property (nonatomic, assign)NSInteger type;

@property (nonatomic, strong)UITableView *backTableView;
@property (nonatomic, strong)UIImageView *headerImageV;
@end

@implementation CashierViewController
- (NSInteger)type {
    if (!_type) {
        _type = 0;
    }
    return _type;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
    
}

- (void)prepareViews {
    self.navigationController.navigationBar.hidden = 1;
    self.view.backgroundColor = UIColorFromRGB(248, 248, 248);
    
    UIImageView *backImageV = [[UIImageView alloc]initWithImage:GetImage(@"shouyinbeijing")];
    [self.view addSubview:backImageV];
    [backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(GetFloatWithHightPXSIX(324));
    }];
    
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
    if (self.type == 0 || self.type == 4) {
        return 2;
    }else {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.type == 4) {
            return 538+113;
        }else {
            return 449+113;
        }
    }else {
        return 45;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc]init];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [CashierFirstTableViewCell cellWithTableView:tableView indexPath:indexPath type:self.type delegate:self];
    }else {
        return [[CashierSecondTableViewCell alloc]init];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
//        商家服务
        [self userService];
    }
}

//认证确认跳转
- (void)authenWithType:(NSInteger)type {
    
}
//设置金额
- (void)setMoney {
    
}
//保存首款吗
- (void)savePic {
    
}
//收款记录
- (void)gotoRecord {
    
}

- (void)userService{
    UserServiceViewController *view = [[UserServiceViewController alloc] init];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
}
@end
