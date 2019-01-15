//
//  MineViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "MineHeaderView.h"

#import "UserInfoViewController.h"
#import "UserSetViewController.h"
#import "UserAuthTypeViewController.h"
#import "FeedbackProblemViewController.h"
#import "MessageCenterViewController.h"
#import "GradeViewController.h"
#import "GeneralWebViewController.h"
#import "BDSSpeechSynthesizer.h"
#import "AuthStatusViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *backTableView;
@property (nonatomic, strong)NSArray *titleImageNameArray;
@property (nonatomic, strong)NSArray *titleArray;
@end

@implementation MineViewController
- (NSArray *)titleImageNameArray {
    if (!_titleImageNameArray) {
        _titleImageNameArray = @[@"xiaoxi", @"shimingrenzheng", @"dengji", @"fankui", @"bangzhuzhongxin"];
    }
    return _titleImageNameArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"消息中心", @"实名认证", @"等级/费率", @"反馈问题", @"帮助中心"];
    }
    return _titleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)prepareViews {
    self.view.backgroundColor = UIColorFromRGB(248, 248, 248);
    
    self.backTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.backTableView.delegate = self;
    self.backTableView.dataSource = self;
    self.backTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(iPhoneX?-44 : -20, 0, 0, 0));
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 211;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [MineHeaderView mineHeaderViewWithSetClick:^{
//        设置
        UserSetViewController *vc = [[UserSetViewController alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        [self.navigationController pushViewController:vc animated:YES];
    } userCenterClick:^{
//        个人信息
        UserInfoViewController *vc = [[UserInfoViewController alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        [self.navigationController pushViewController:vc animated:YES];
    } messageCenter:^{
//        消息中心
        MessageCenterViewController *vc = [[MessageCenterViewController alloc]init];
        vc.hidesBottomBarWhenPushed = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MineTableViewCell cellWithTableView:tableView indexPath:indexPath imageName:self.titleImageNameArray[indexPath.row+1] title:self.titleArray[indexPath.row+1]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //认证状态：1未认证 2审核中 3审核失败 4认证成功
        
        if ([UserPreferenceModel shareManager].agreementStatus.integerValue == 1) {
            UserAuthTypeViewController *vc = [[UserAuthTypeViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            AuthStatusViewController *vc = [[AuthStatusViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.row == 2) {
        if (indexPath.row == 2) {
            FeedbackProblemViewController *vc = [[FeedbackProblemViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.row == 1) {
        GradeViewController *vc = [[GradeViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    if (indexPath.row == 3) {
        GeneralWebViewController *webVC = [[GeneralWebViewController alloc]init];
        webVC.hidesBottomBarWhenPushed = 1;
        webVC.url = @"http://xyfapi.ycw580.com/question.html";
        webVC.title = @"帮助中心";
        [self.navigationController pushViewController:webVC animated:YES];
        
//        [[BDSSpeechSynthesizer sharedInstance]speakSentence:@"123123123123" withError:nil];
    }
}


@end
