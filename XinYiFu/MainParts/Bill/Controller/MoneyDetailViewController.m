//
//  MoneyDetailViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MoneyDetailViewController.h"
#import "MoneyDetailCell.h"

@interface MoneyDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *backTableView;
@property (nonatomic ,strong) UIButton *selectedButton;
@property (nonatomic ,strong) UIView *selectedBackView;
@end

@implementation MoneyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资金明细";
    [self prepareViews];
    [self requestDataWithType:1];
}

- (void)requestDataWithType:(NSInteger)type{
    [[RequestTool shareManager]sendRequestWithAPI:@"/api/statistics/record" withVC:self withParams:@{@"token":[UserPreferenceModel shareManager].token,@"type":[NSNumber numberWithInteger:type]} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {

        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
}

- (void)loadData:(NSDictionary *)dict{
    NSLog(@"加载数据");
}


- (void)prepareViews{
    self.backTableView = [[UITableView alloc]init];
    self.backTableView.delegate = self;
    self.backTableView.dataSource = self;
    self.backTableView.backgroundColor = ThemeColor;
    self.backTableView.separatorStyle = NO;
    [self.view addSubview:self.backTableView];
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 52)];
    self.backTableView.tableHeaderView = headView;
    
    UIView *tabBackView = [[UIView alloc] init];
    tabBackView.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
    tabBackView.layer.masksToBounds = YES;
    tabBackView.layer.cornerRadius = 18;
    [headView addSubview:tabBackView];
    [tabBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(headView.mas_right).offset(-16);
        make.height.mas_equalTo(36);
    }];
    
    NSArray *tabItemNameArray = @[@"最近7天",@"最近15天",@"最近30天"];
    CGFloat tabItemWidth = (CGRectGetWidth(self.view.frame) - 32) / 3;
    for (int i = 0; i<tabItemNameArray.count ; i++) {
        UIButton *tabItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [tabItem setTitle:tabItemNameArray[i] forState:UIControlStateNormal];
        [tabItem setTitle:tabItemNameArray[i] forState:UIControlStateSelected];
        [tabItem setTitleColor:AlertGray forState:UIControlStateNormal];
        [tabItem setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        tabItem.titleLabel.font = [UIFont systemFontOfSize:16.f];
        tabItem.tag = 1001+i;
        [tabItem addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            tabItem.selected = YES;
            self.selectedButton = tabItem;
        }
        [tabBackView addSubview:tabItem];
        [tabItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(tabItemWidth*i);
            make.width.mas_equalTo(tabItemWidth);
        }];
    }
    
    self.selectedBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tabItemWidth, 36)];
    self.selectedBackView.layer.masksToBounds = YES;
    self.selectedBackView.layer.cornerRadius = 20;
    // gradient
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = self.selectedBackView.bounds;
    gl.startPoint = CGPointMake(0.07, 0.5);
    gl.endPoint = CGPointMake(1.04, 0.5);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:249/255.0 green:132/255.0 blue:56/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:240/255.0 green:77/255.0 blue:26/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    gl.cornerRadius = 20;
    [self.selectedBackView.layer addSublayer:gl];
    [tabBackView addSubview:self.selectedBackView];
    [tabBackView sendSubviewToBack:self.selectedBackView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [MoneyDetailCell cellWithTableView:tableView indexPath:indexPath time:@"2018年12月18日" totalMoney:@"￥23456.90" fee:@"￥234.90" actualMoney:@"￥23456.90"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 174.f;
}

- (void)selectedButtonAction:(UIButton *)sender{
    self.selectedButton.selected = NO;
    [UIView animateWithDuration:.3 animations:^{
        CGPoint center = sender.center;
        center.x = sender.center.x;
        self.selectedBackView.center = center;
    } completion:^(BOOL finished){
        if (finished) {
            sender.selected = YES;
            self.selectedButton = sender;
        }
    }];
    [self requestDataWithType:sender.tag - 1000];
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
