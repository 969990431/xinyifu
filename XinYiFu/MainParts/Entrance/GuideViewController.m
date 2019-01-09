//
//  GuideViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "GuideViewController.h"
#import "MainTabViewController.h"
#import "LoginViewController.h"
#import "NavViewController.h"

@interface GuideViewController ()
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareGuideViews];
}

- (void)prepareGuideViews {
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = 0;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, SCREEN_HEIGHT);
    NSArray *imageNames;
    if (iPhoneX) {
        imageNames = @[@"欢迎页1-x", @"欢迎页2-x"];
    }else {
        imageNames = @[@"欢迎页1", @"欢迎页2"];
    }
    for (int i = 0; i<2; i++) {
        UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageNames[i]]];
        imageV.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.scrollView addSubview:imageV];
        if (i == 1) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoMain)];
            imageV.userInteractionEnabled = YES;
            [imageV addGestureRecognizer:tap];
        }
        
    }
    
    [self.view addSubview:self.scrollView];
}


- (void)gotoMain {
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = [[NavViewController alloc]initWithRootViewController:loginVC];
}

@end
