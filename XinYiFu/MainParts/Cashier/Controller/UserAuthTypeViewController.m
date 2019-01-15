//
//  UserAuthTypeViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/28.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UserAuthTypeViewController.h"
#import "PersonalAuthViewController.h"
#import "CompanyAuthenViewController.h"

@interface UserAuthTypeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *backTableView;
@property (nonatomic ,strong) NSArray *cellTitleArray;
@end

@implementation UserAuthTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    [self prepareViews];
}

- (NSArray *)cellTitleArray{
    if (!_cellTitleArray) {
        _cellTitleArray = @[@"我是个人（没有营业执照）",@"我是企业（包括个体户）"];
    }
    return _cellTitleArray;
}

- (void)prepareViews{
    self.backTableView = [[UITableView alloc]init];
    self.backTableView.delegate = self;
    self.backTableView.dataSource = self;
    self.backTableView.backgroundColor = ThemeColor;
    self.backTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 12)];
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self createCell:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        PersonalAuthViewController *vc = [[PersonalAuthViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        CompanyAuthenViewController *vc = [[CompanyAuthenViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48.f;
}

- (UITableViewCell *)createCell:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    UILabel *title = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentLeft];
    title.text = self.cellTitleArray[indexPath.row];
    [cell.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(cell.contentView);
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(22);
    }];
    
    if (indexPath.row < self.cellTitleArray.count - 1) {
        UILabel *segLine = [[UILabel alloc] init];
        segLine.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
        [cell.contentView addSubview:segLine];
        [segLine mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(cell.mas_right);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(cell.contentView.mas_bottom);
        }];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
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
