//
//  IncomeRecordViewController.m
//  XinYiFu
//
//  Created by 杨威 on 2018/12/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "IncomeRecordViewController.h"
#import "IncomeRecordHeadCell.h"
#import "IncomeRecordContentCell.h"
#import "CustomQueryViewController.h"

@interface IncomeRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *backTableView;
@end

@implementation IncomeRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款记录";
    [self prepareViews];
    [self requestData];
}

- (void)requestData{
    [[RequestTool shareManager]sendRequestWithAPI:@"/api/statistics/detail" withVC:self withParams:@{@"token":[UserPreferenceModel shareManager].token} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            if ([response[@"data"][@"list"] count]) {
                [self loadData:response[@"data"][@"list"]];
            }else{
                [NoDataView showWithSuperView:self.view];
            }
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
}

- (void)loadData:(NSDictionary *)dict{
    NSLog(@"加载数据");
}

- (void)prepareViews{
    self.backTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.backTableView.delegate = self;
    self.backTableView.dataSource = self;
    self.backTableView.backgroundColor = ThemeColor;
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [IncomeRecordHeadCell cellWithTableView:tableView indexPath:indexPath count:@"2" total:@"￥23.00"];
    }else {
        return [IncomeRecordContentCell cellWithTableView:tableView indexPath:indexPath name:@"zk***夏天" time:@"13：00：89" money:@"￥20.00"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 86.f;
    }
    return 66.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
    
    UILabel *timeLabel = [UILabel labelWithTextColor:AlertGray font:16 aligment:NSTextAlignmentLeft];
    timeLabel.text = @"2018年12月18日";
    [backView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(backView);
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(22);
    }];
    
    if (section == 0) {
        UIButton *queryBtn = [UIButton buttonWithTitle:@"自定义查询" font:16 titleColor:[UIColor colorWithHexString:@"#3FC3C2"] backGroundColor:nil aligment:UIControlContentHorizontalAlignmentRight];
        [queryBtn addTarget:self action:@selector(customQueryAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:queryBtn];
        [queryBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.mas_equalTo(backView);
            make.right.mas_equalTo(backView.mas_right).offset(-16);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(22);
        }];
    }
    
    return backView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (void)customQueryAction:(UIButton *)sender{
    [self.navigationController pushViewController:[[CustomQueryViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
