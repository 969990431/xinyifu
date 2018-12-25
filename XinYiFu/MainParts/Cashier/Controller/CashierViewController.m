//
//  CashierViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CashierViewController.h"
#import "LoginViewController.h"

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
}

- (void)pushLogin {
    [self presentViewController:[[LoginViewController alloc]init] animated:YES completion:nil];
}

@end
