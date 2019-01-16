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

@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) NSMutableArray *totalArray;
@property (nonatomic ,strong) NSMutableArray *detailArray;

@property (nonatomic ,assign) NSInteger currentPage;
@property (nonatomic ,assign) NSInteger totalPage;
@end

@implementation IncomeRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款记录";
    self.currentPage = 1;
    [self prepareViews];
    [self requestData];
}

- (void)requestData{
    [SVProgressHUD show];
    [[RequestTool shareManager]sendNewRequestWithAPI:@"/api/statistics/detail" withVC:self withParams:@{@"page":[NSNumber numberWithInteger:self.currentPage],@"limit":@10} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        [SVProgressHUD dismiss];
        [self.backTableView.mj_header endRefreshing];
        [self.backTableView.mj_footer endRefreshing];
        if (errorCode == 1) {
            if ([response[@"data"][@"list"] count]) {
                self.totalPage = [response[@"data"][@"totalPage"] integerValue];
                [self loadData:response[@"data"][@"list"]];
            }else{
                [NoDataView showWithSuperView:self.view];
            }
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
}


- (void)loadData:(NSArray *)array{
    [self.dataArray addObjectsFromArray:array];
    [self.totalArray removeAllObjects];
    [self.detailArray removeAllObjects];

    for (NSDictionary *dict in self.dataArray) {
        if ([dict[@"sign"] integerValue] == 0) {
            [self.totalArray addObject:dict];
        }
    }
    for (int i = 0; i < self.totalArray.count; i++) {
        NSMutableArray *subArray = [[NSMutableArray alloc] init];
        for (NSDictionary *subDic in self.dataArray) {
            if ([subDic[@"sign"] integerValue] == 1) {
                NSDictionary *dict = self.totalArray[i];
                if ([dict[@"dateTime"] isEqualToString:[subDic[@"creditTime"] substringToIndex:10]]) {
                    [subArray addObject:subDic];
                }
            }
        }
        [self.detailArray addObject:subArray];
    }
    [self.backTableView reloadData];
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
    
    self.backTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        [self.dataArray removeAllObjects];
        [self requestData];
    }];
    
    self.backTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.currentPage < self.totalPage) {
            self.currentPage ++;
            [self requestData];
        }else{
            [self.backTableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.totalArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.detailArray[section] count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSDictionary *dict = self.totalArray[indexPath.section];
        return [IncomeRecordHeadCell cellWithTableView:tableView indexPath:indexPath count:[NSString stringWithFormat:@"%@",dict[@"order_num"]] total:[NSString stringWithFormat:@"￥%@",dict[@"trans_amt"]]];
    }else {
        NSDictionary *dict = self.detailArray[indexPath.section][indexPath.row-1];
        return [IncomeRecordContentCell cellWithTableView:tableView indexPath:indexPath name:[NSString stringWithFormat:@"%@",dict[@"payType"]] time:[dict[@"creditTime"] substringWithRange:NSMakeRange(11, 8)] money:[NSString stringWithFormat:@"￥%@",dict[@"amount"]]];
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
    
    NSDictionary *dict = self.totalArray[section];
    UILabel *timeLabel = [UILabel labelWithTextColor:AlertGray font:16 aligment:NSTextAlignmentLeft];
    NSString *time = dict[@"dateTime"];
    time = [time stringByReplacingCharactersInRange:NSMakeRange(4, 1) withString:@"年"];
    time = [time stringByReplacingCharactersInRange:NSMakeRange(7, 1) withString:@"月"];
    time = [time stringByAppendingString:@"日"];
    timeLabel.text = time;
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

- (id)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (id)totalArray{
    if (!_totalArray) {
        _totalArray = [[NSMutableArray alloc] init];
    }
    return _totalArray;
}

- (id)detailArray{
    if (!_detailArray) {
        _detailArray = [[NSMutableArray alloc] init];
    }
    return _detailArray;
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
