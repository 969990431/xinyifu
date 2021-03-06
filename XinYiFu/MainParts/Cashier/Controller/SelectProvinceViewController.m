//
//  SelectProvinceViewController.m
//  XinYiFu
//
//  Created by apple on 2019/1/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SelectProvinceViewController.h"
#import "PersonProvinceModel.h"

@interface SelectProvinceViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *backTableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation SelectProvinceViewController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
    [self loadData];
}
- (void)prepareViews {
    self.title = @"选择省份";
    
    self.view.backgroundColor = UIColorFromRGB(248, 248, 248);
    
    self.backTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.backTableView.delegate = self;
    self.backTableView.dataSource = self;
    self.backTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)loadData {
    
    [[RequestTool shareManager]sendNewRequestWithAPI:@"/api/get/by_reid" withVC:self withParams:@{@"id":@"0"} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            NSArray *array = response[@"data"];
            for (NSDictionary *dic in array) {
                PersonProvinceModel *model = [[PersonProvinceModel alloc]initWithDictionary:dic error:nil];
                [self.dataSource addObject:model];
            }
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
        [self.backTableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 47;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 7;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = NO;
    }
    PersonProvinceModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonProvinceModel *model = self.dataSource[indexPath.row];
    if (self.callBack) {
        self.callBack(model.name,model.id);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
