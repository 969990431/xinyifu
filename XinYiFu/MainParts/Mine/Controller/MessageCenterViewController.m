//
//  MessageCenterViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MessageCenterTableViewCell.h"
#import "MessageContentViewController.h"
#import "MessageListModel.h"

@interface MessageCenterViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *backTableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, assign)NSInteger pageNo;
@end

@implementation MessageCenterViewController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
    [self loadData];
}
- (void)prepareViews {
    self.pageNo = 1;
    self.title = @"消息中心";
    self.view.backgroundColor = UIColorFromRGB(248, 248, 248);
    
    self.backTableView = [[UITableView alloc]init];
    self.backTableView.delegate = self;
    self.backTableView.dataSource = self;
    self.backTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.backTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataSource removeAllObjects];
        self.pageNo = 1;
        [self loadData];
    }];
    self.backTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.pageNo++;
        [self loadData];
    }];
    
}

- (void)loadData {
    [[RequestTool shareManager]sendNewRequestWithAPI:@"/api/message/list" withVC:self withParams:@{@"page":[NSString stringWithFormat:@"%ld", self.pageNo], @"limit":@"10"} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            NSArray *array = response[@"data"][@"list"];
            for (NSDictionary *dic in array) {
                MessageListModel *model = [[MessageListModel alloc]initWithDictionary:dic error:nil];
                [self.dataSource addObject:model];
            }
//            if (array.count == 0) {
//                [self.backTableView.mj_footer endRefreshingWithNoMoreData];
//            }
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
        [self.backTableView.mj_header endRefreshing];
        [self.backTableView.mj_footer endRefreshing];
        [self.backTableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 6:10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MessageCenterTableViewCell cellWithTableView:tableView indexPath:indexPath dataSource:self.dataSource];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageContentViewController *vc = [[MessageContentViewController alloc]init];
    MessageListModel *model = self.dataSource[indexPath.section];
    vc.messageId = model.messageId;
    model.isRead = 1;
    [self.backTableView reloadData];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.backTableView beginUpdates];
        
//        [self.backTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
//        [self.backTableView endUpdates];
        [self deleteActionWithIndex:indexPath.section]; 
    }
}

- (void)deleteActionWithIndex: (NSInteger)index {
    MessageListModel *model = self.dataSource[index];
    [[RequestTool shareManager]sendNewRequestWithAPI:@"/api/message/delete" withVC:self withParams:@{@"messageId":model.messageId} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            [SVProgressHUD showSuccessWithStatus:@"已删除"];
            [self.dataSource removeObjectAtIndex:index];
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
        [self.backTableView reloadData];
    }];
}
@end
