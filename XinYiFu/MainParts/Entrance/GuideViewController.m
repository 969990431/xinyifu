//
//  GuideViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "GuideViewController.h"
#import "MainTabViewController.h"

@interface GuideViewController ()
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
}

- (void)prepareViews {
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, SCREEN_HEIGHT);
    NSArray *imageNames = @[@"huanyingye1", @"huanyingye2"];
    for (int i = 0; i<2; i++) {
        UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageNames[i]]];
        imageV.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.scrollView addSubview:imageV];
        if (i == 2) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoMain)];
            imageV.userInteractionEnabled = YES;
            [imageV addGestureRecognizer:tap];
        }
        
    }
    
    [self.view addSubview:self.scrollView];
}
- (void)gotoMain {
    [self.navigationController pushViewController:[[MainTabViewController alloc]init] animated:YES];
}

@end
