//
//  GradeViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "GradeViewController.h"
#import "GradeModel.h"

@interface GradeViewController ()
@property (nonatomic, strong)UILabel *gradeLabel;
@property (nonatomic, strong)UILabel *rateLabel;

@property (nonatomic, strong)UIImageView *allGradeImageV;

@property (nonatomic, copy)NSString *level;
@end

@implementation GradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]};

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:UIColorFromRGB(119,119,119)];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:18]};
}

- (void)loadData {
    [[RequestTool shareManager]sendNewRequestWithAPI:@"/api/tax/level" withVC:self withParams:@{@"token":[UserPreferenceModel shareManager].token} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            GradeModel *model = [[GradeModel alloc]initWithDictionary:response[@"data"] error:nil];
            self.gradeLabel.text = [NSString stringWithFormat:@"%@级", model.level];
            self.rateLabel.text = [NSString stringWithFormat:@"%.1f%%", [model.tax floatValue]/10];
            NSString *imageName = [NSString stringWithFormat:@"dengji%@", model.level];
            [self.allGradeImageV setImage: GetImage(imageName)];
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
}

- (void)prepareViews {
    self.title = @"等级/费率";
    
    UIImageView *backImageV = [[UIImageView alloc]initWithImage:GetImage(@"dengjibeijing")];
    backImageV.backgroundColor = RandomColor;
    [self.view addSubview:backImageV];
    [backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

    
    UIView *whiteBackView = [[UIView alloc]init];
    whiteBackView.layer.cornerRadius = 8;
    whiteBackView.layer.masksToBounds = YES;
    whiteBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteBackView];
    [whiteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(iPhoneX ? 95: 71);
        make.height.mas_equalTo(100);
    }];
    
    UIImageView *gradeImageV = [[UIImageView alloc]initWithImage:GetImage(@"dengjifeilv")];
    [whiteBackView addSubview:gradeImageV];
    [gradeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(29, 40));
    }];
    
    UILabel *gradeTitleLabel = [UILabel labelWithTextColor:WordCloseBlack font:14 aligment:NSTextAlignmentLeft];
    gradeTitleLabel.text = @"当前等级：";
    [whiteBackView addSubview:gradeTitleLabel];
    [gradeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradeImageV.mas_right).offset(10);
        make.top.mas_equalTo(18);
        make.height.mas_equalTo(15);
    }];
    
    self.gradeLabel = [UILabel labelWithTextColor:WordCloseBlack font:18 aligment:NSTextAlignmentLeft];
    self.gradeLabel.text = @"-级";
    [whiteBackView addSubview:self.gradeLabel];
    [self.gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradeTitleLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(gradeTitleLabel);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *rateLabel = [UILabel labelWithTextColor:WordCloseBlack font:14 aligment:NSTextAlignmentLeft];
    rateLabel.text = @"费    率：";
    [whiteBackView addSubview:rateLabel];
    [rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradeImageV.mas_right).offset(10);
        make.bottom.mas_equalTo(-23);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(gradeTitleLabel);
    }];
    
    self.rateLabel = [UILabel labelWithTextColor:UIColorFromRGB(240,77,26) font:18 aligment:NSTextAlignmentLeft];
    self.rateLabel.text = @"-%";
    [whiteBackView addSubview:self.rateLabel];
    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradeTitleLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(rateLabel);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *textLabel1 = [UILabel labelWithTextColor:[UIColor whiteColor] font:16 aligment:NSTextAlignmentLeft];
    textLabel1.text = @"全部等级";
    [self.view addSubview:textLabel1];
    [textLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(whiteBackView.mas_bottom).offset(27);
        make.height.mas_equalTo(20);
    }];
    
    self.allGradeImageV = [[UIImageView alloc]initWithImage:GetImage(@"-")];
    self.allGradeImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.allGradeImageV];
    [self.allGradeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(textLabel1.mas_bottom).offset(0);
        make.height.mas_equalTo(SCREEN_WIDTH*474/775);
    }];
    
    UILabel *textLabel2 = [UILabel labelWithTextColor:[UIColor whiteColor] font:16 aligment:NSTextAlignmentLeft];
    textLabel2.text = @"什么是用户等级?";
    [self.view addSubview:textLabel2];
    [textLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.allGradeImageV.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *textLabel3 = [UILabel labelWithTextColor:[UIColor whiteColor] font:14 aligment:NSTextAlignmentLeft];
    textLabel3.text = @"提高用户等级可享受低费率";
    [self.view addSubview:textLabel3];
    [textLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(textLabel2.mas_bottom).offset(6);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-15);
    }];
    
    UILabel *textLabel4 = [UILabel labelWithTextColor:[UIColor whiteColor] font:16 aligment:NSTextAlignmentCenter];
    textLabel4.text = [NSString stringWithFormat: @"客服电话：%@",[UserPreferenceModel shareManager].kefudianhua];
    [self.view addSubview:textLabel4];
    [textLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        make.height.mas_equalTo(20);
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
