//
//  GradeViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "GradeViewController.h"

@interface GradeViewController ()
@property (nonatomic, strong)UILabel *gradeLabel;
@property (nonatomic, strong)UILabel *rateLabel;

@property (nonatomic, strong)UIImageView *allGradeImageV;
@end

@implementation GradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
}
- (void)prepareViews {
    UIView *whiteBackView = [[UIView alloc]init];
    [self.view addSubview:whiteBackView];
    [whiteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(71);
        make.height.mas_equalTo(100);
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
