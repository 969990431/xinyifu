//
//  IncomeRecordViewController.m
//  XinYiFu
//
//  Created by 杨威 on 2018/12/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "IncomeRecordViewController.h"

@interface IncomeRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *backTableView;
@end

@implementation IncomeRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款记录";
    [self prepareViews];
    // Do any additional setup after loading the view.
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"title"];
            UILabel *incomeCountLabel = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"999999"] font:16 aligment:NSTextAlignmentLeft];
            incomeCountLabel.text = @"收款笔数";
            [cell.contentView addSubview:incomeCountLabel];
            [incomeCountLabel mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.mas_equalTo(16);
                make.left.mas_equalTo(16);
                make.height.mas_equalTo(22);
            }];
            
            UILabel *countValueLabel = [UILabel labelWithTextColor:WordCloseBlack font:24 aligment:NSTextAlignmentLeft];
            countValueLabel.tag = 1001;
            [cell.contentView addSubview:countValueLabel];
            [countValueLabel mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.mas_equalTo(incomeCountLabel.mas_bottom).offset(10);
                make.left.mas_equalTo(16);
                make.height.mas_equalTo(34);
            }];
            
            UILabel *totalTitle = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"999999"] font:16 aligment:NSTextAlignmentRight];
            totalTitle.text = @"合计";
            [cell.contentView addSubview:totalTitle];
            [totalTitle mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.mas_equalTo(16);
                make.right.mas_equalTo(cell.contentView.mas_right).offset(-16);
                make.height.mas_equalTo(22);
            }];

            UILabel *totalValue = [UILabel labelWithTextColor:WordCloseBlack font:24 aligment:NSTextAlignmentLeft];
            totalValue.tag = 1002;
            [cell.contentView addSubview:totalValue];
            [totalValue mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.mas_equalTo(totalTitle.mas_bottom).offset(10);
                make.right.mas_equalTo(cell.contentView.mas_right).offset(-16);
                make.height.mas_equalTo(34);
            }];
        }
        UILabel *countValueLabel = [cell.contentView viewWithTag:1001];
        countValueLabel.text = @"2";
        
        UILabel *totalValue = [cell.contentView viewWithTag:1002];
        totalValue.text = @"￥23.00";

        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"content"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"content"];
            
            UILabel *name = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
            
            
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 86.f;
    }
    return 66.f;
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
