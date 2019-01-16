//
//  BillViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "BillViewController.h"
#import "IncomeRecordViewController.h"
#import "MoneyDetailViewController.h"

@interface BillViewController ()
@property (nonatomic ,strong) UITableView *backTableView;

@property (nonatomic ,strong) UILabel *totalIncomeValue; //收款总额
@property (nonatomic ,strong) UILabel *customerCountValue; //顾客人数
@property (nonatomic ,strong) UILabel *incomeCountVlaue; //收款笔数
@property (nonatomic ,strong) UILabel *singleAverageValue; //单笔均价

@property (nonatomic ,strong) UILabel *totalIncomeValue1;
@property (nonatomic ,strong) UILabel *serviceChargeValue;//手续费
@property (nonatomic ,strong) UILabel *actualAmountValue;//实际到账
@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
}

- (void)requestData{
    [[RequestTool shareManager]sendRequestWithAPI:@"/api/statistics/all" withVC:self withParams:@{@"token":[UserPreferenceModel shareManager].token} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            NSDictionary *dict = response;
            [self loadData:dict[@"data"]];
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
}

- (void)loadData:(NSDictionary *)dict{
    self.totalIncomeValue.text = self.totalIncomeValue1.text = [NSString stringWithFormat:@"%@",dict[@"totalPayment"]];
    self.customerCountValue.text = [NSString stringWithFormat:@"%@",dict[@"customerNum"]];
    self.incomeCountVlaue.text = [NSString stringWithFormat:@"%@",dict[@"creditScore"]];
    self.singleAverageValue.text = [NSString stringWithFormat:@"%@",dict[@"averagePrice"]];
    
    self.serviceChargeValue.text = [NSString stringWithFormat:@"%@",dict[@"serviceCharge"]];
    self.actualAmountValue.text = [NSString stringWithFormat:@"%@",dict[@"actualAccount"]];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)prepareViews{
    self.backTableView = [[UITableView alloc]init];
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

    UILabel *titleLabel = [UILabel labelWithTextColor:WordCloseBlack font:18 aligment:NSTextAlignmentLeft];
    titleLabel.text = @"收款记录";
    [self.backTableView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(18);
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(26);
    }];
    
    UIView *topBackView = [[UIView alloc] init];
    [self.backTableView addSubview:topBackView];
    [topBackView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(22);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(self.view.mas_right).offset(-16);
        make.height.mas_equalTo(142);
    }];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame) - 32, 142);
    gl.startPoint = CGPointMake(0.07, 0.5);
    gl.endPoint = CGPointMake(1.04, 0.5);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:249/255.0 green:132/255.0 blue:56/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:240/255.0 green:77/255.0 blue:26/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius = 10;
    [topBackView.layer addSublayer:gl];
    topBackView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    topBackView.layer.cornerRadius = 10;
    topBackView.layer.shadowColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0].CGColor;
    topBackView.layer.shadowOffset = CGSizeMake(0,3);
    topBackView.layer.shadowOpacity = 1;
    topBackView.layer.shadowRadius = 11;
    [topBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(incomeRecordAction:)]];
    
    UILabel *todayIncome = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#F3E7E7"] font:14 aligment:NSTextAlignmentLeft];
    todayIncome.text = @"今日收款（元）";
    [topBackView addSubview:todayIncome];
    [todayIncome mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(18);
    }];
    
    self.totalIncomeValue = [UILabel labelWithTextColor:[UIColor whiteColor] font:30 aligment:NSTextAlignmentLeft];
    [topBackView addSubview:self.totalIncomeValue];
    [self.totalIncomeValue  mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(todayIncome.mas_bottom).offset(2);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(42);
    }];
    
    UILabel *segLine = [[UILabel alloc] init];
    segLine.backgroundColor = [UIColor colorWithHexString:@"#F6AF95"];
    [topBackView addSubview:segLine];
    [segLine mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(78);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:GetImage(@"youjaintou")];
    [topBackView addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(48);
        make.right.mas_equalTo(topBackView.mas_right).offset(-12);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(10);
    }];
    
    CGFloat labelWidth = (CGRectGetWidth(self.view.frame) - 34) / 3;
    NSArray *tabTitleArray = @[@"顾客人数",@"收款笔数",@"单笔均价"];
    for (int i = 0; i < tabTitleArray.count; i++) {
        UILabel *tabItem = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#F3E7E7"] font:14 aligment:NSTextAlignmentCenter];
        tabItem.text = tabTitleArray[i];
        [topBackView addSubview:tabItem];
        [tabItem mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(labelWidth*i+i);
            make.top.mas_equalTo(segLine.mas_bottom).offset(8);
            make.height.mas_equalTo(18);
            make.width.mas_equalTo(labelWidth);
        }];
        
        if (i < tabTitleArray.count - 1) {
            UILabel *spaceLine = [[UILabel alloc] init];
            spaceLine.backgroundColor = [UIColor colorWithHexString:@"#F6AF95"];
            [topBackView addSubview:spaceLine];
            [spaceLine mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.mas_equalTo(segLine.mas_bottom).offset(10);
                make.left.mas_equalTo(labelWidth*(i+1)+i);
                make.height.mas_equalTo(14);
                make.width.mas_equalTo(1);
            }];
        }
        
        switch (i) {
            case 0:
            {
                self.customerCountValue = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#F3E7E7"] font:18 aligment:NSTextAlignmentCenter];
                [topBackView addSubview:self.customerCountValue];
                [self.customerCountValue mas_makeConstraints:^(MASConstraintMaker *make){
                    make.top.mas_equalTo(tabItem.mas_bottom).offset(4);
                    make.centerX.mas_equalTo(tabItem);
                    make.height.mas_equalTo(26);
                }];
            }
                break;
            case 1:
            {
                self.incomeCountVlaue = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#F3E7E7"] font:18 aligment:NSTextAlignmentCenter];
                [topBackView addSubview:self.incomeCountVlaue];
                [self.incomeCountVlaue mas_makeConstraints:^(MASConstraintMaker *make){
                    make.top.mas_equalTo(tabItem.mas_bottom).offset(4);
                    make.centerX.mas_equalTo(tabItem);
                    make.height.mas_equalTo(26);
                }];
            }
                break;
            default:
            {
                self.singleAverageValue = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#F3E7E7"] font:18 aligment:NSTextAlignmentCenter];
                [topBackView addSubview:self.singleAverageValue];
                [self.singleAverageValue mas_makeConstraints:^(MASConstraintMaker *make){
                    make.top.mas_equalTo(tabItem.mas_bottom).offset(4);
                    make.centerX.mas_equalTo(tabItem);
                    make.height.mas_equalTo(26);
                }];
            }
                break;
        }
    }
    
    UILabel *titleLabel1 = [UILabel labelWithTextColor:WordCloseBlack font:18 aligment:NSTextAlignmentLeft];
    titleLabel1.text = @"资金明细";
    [self.backTableView addSubview:titleLabel1];
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(topBackView.mas_bottom).offset(12);
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(26);
    }];
    
    UIView *bottomBackView = [[UIView alloc] init];
    [self.backTableView addSubview:bottomBackView];
    [bottomBackView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(titleLabel1.mas_bottom).offset(10);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(self.view.mas_right).offset(-16);
        make.height.mas_equalTo(142);
    }];
    bottomBackView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    bottomBackView.layer.cornerRadius = 10;
    bottomBackView.layer.shadowColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0].CGColor;
    bottomBackView.layer.shadowOffset = CGSizeMake(0,2);
    bottomBackView.layer.shadowOpacity = 1;
    bottomBackView.layer.shadowRadius = 11;
    [bottomBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moneyDetailAction:)]];
    
    todayIncome = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#999999"] font:14 aligment:NSTextAlignmentLeft];
    todayIncome.text = @"今日收款总额（元）";
    [bottomBackView addSubview:todayIncome];
    [todayIncome mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(18);
    }];

    self.totalIncomeValue1 = [UILabel labelWithTextColor:WordCloseBlack font:28 aligment:NSTextAlignmentLeft];
    [bottomBackView addSubview:self.totalIncomeValue1];
    [self.totalIncomeValue1  mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(todayIncome.mas_bottom).offset(2);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(42);
    }];
    
    arrow = [[UIImageView alloc] initWithImage:GetImage(@"youjaintou")];
    [bottomBackView addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(48);
        make.right.mas_equalTo(topBackView.mas_right).offset(-12);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(10);
    }];


    segLine = [[UILabel alloc] init];
    segLine.backgroundColor = [UIColor colorWithHexString:@"#EAEAEA"];
    [bottomBackView addSubview:segLine];
    [segLine mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(74);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];

    labelWidth = (CGRectGetWidth(self.view.frame) - 32) / 2;
    tabTitleArray = @[@"手续费",@"实际到账金额"];
    for (int i = 0; i < tabTitleArray.count; i++) {
        UILabel *tabItem = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#999999"] font:14 aligment:NSTextAlignmentCenter];
        tabItem.text = tabTitleArray[i];
        [bottomBackView addSubview:tabItem];
        [tabItem mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(labelWidth*i);
            make.top.mas_equalTo(segLine.mas_bottom).offset(8);
            make.height.mas_equalTo(18);
            make.width.mas_equalTo(labelWidth);
        }];
        switch (i) {
            case 0:
            {
                self.serviceChargeValue = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#666666"] font:18 aligment:NSTextAlignmentCenter];
                [bottomBackView addSubview:self.serviceChargeValue];
                [self.serviceChargeValue mas_makeConstraints:^(MASConstraintMaker *make){
                    make.top.mas_equalTo(tabItem.mas_bottom).offset(4);
                    make.centerX.mas_equalTo(tabItem);
                    make.height.mas_equalTo(26);
                }];
            }
                break;
            default:
            {
                self.actualAmountValue = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#666666"] font:18 aligment:NSTextAlignmentCenter];
                [bottomBackView addSubview:self.actualAmountValue];
                [self.actualAmountValue mas_makeConstraints:^(MASConstraintMaker *make){
                    make.top.mas_equalTo(tabItem.mas_bottom).offset(4);
                    make.centerX.mas_equalTo(tabItem);
                    make.height.mas_equalTo(26);
                }];
            }
                break;
        }
    }

}

- (void)incomeRecordAction:(UITapGestureRecognizer *)tap{
    IncomeRecordViewController *vc = [[IncomeRecordViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)moneyDetailAction:(UITapGestureRecognizer *)tap{
    MoneyDetailViewController *vc = [[MoneyDetailViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
