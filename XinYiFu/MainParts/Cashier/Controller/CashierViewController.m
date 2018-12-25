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

@interface CashierViewController ()

@end

@implementation CashierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithTitle:@"登陆"];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(pushLogin) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(50);
    }];
    
    UIButton *button1 = [UIButton buttonWithTitle:@"商户服务"];
    [self.view addSubview:button1];
    [button1 addTarget:self action:@selector(userService) forControlEvents:UIControlEventTouchUpInside];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(button.mas_bottom).offset(50);
        make.size.mas_equalTo(50);
    }];
}

- (void)pushLogin {
    [self presentViewController:[[LoginViewController alloc]init] animated:YES completion:nil];
}

- (void)userService{
    UserServiceViewController *view = [[UserServiceViewController alloc] init];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
}
@end
