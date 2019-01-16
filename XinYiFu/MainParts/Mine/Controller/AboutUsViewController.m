//
//  AboutUsViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/28.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AboutUsViewController.h"
#import "GeneralWebViewController.h"

@interface AboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *backTableView;

@property (nonatomic ,strong) UILabel *versionLabel;
@property (nonatomic ,strong) UILabel *detailLabel;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于薪易付";
    [self prepareViews];
}

- (void)prepareViews{
    self.backTableView = [[UITableView alloc]init];
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    self.backTableView.delegate = self;
    self.backTableView.dataSource = self;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 210)];
    self.backTableView.tableHeaderView = backView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:GetImage(@"guanyuxinyifu")];
    [backView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(72);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(168);
        make.height.mas_equalTo(58);
    }];

    self.versionLabel = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"030303"] font:18 aligment:NSTextAlignmentCenter];
    self.versionLabel.text = @"v 1.0.0";
    [backView addSubview:self.versionLabel];
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(imageView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(imageView);
        make.height.mas_equalTo(26);
    }];
//
//    UILabel *detailTitle = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentLeft];
//    detailTitle.text = @"版本说明：";
//    [self.backTableView addSubview:detailTitle];
//    [detailTitle mas_makeConstraints:^(MASConstraintMaker *make){
//        make.top.mas_equalTo(self.versionLabel.mas_bottom).offset(24);
//        make.left.mas_equalTo(34);
//    }];
//
//    self.detailLabel = [UILabel labelWithTextColor:AlertGray font:16 aligment:NSTextAlignmentLeft];
//    self.detailLabel.text = @"版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明";
//    [self.backTableView addSubview:self.detailLabel];
//    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make){
//        make.top.mas_equalTo(detailTitle.mas_bottom);
//        make.left.mas_equalTo(34);
//        make.right.mas_equalTo(self.view.mas_right).offset(-34);
//    }];
//
//    UILabel *copyright = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentCenter];
//    copyright.text = @"copyright 2019";
//    [self.backTableView addSubview:copyright];
//    [copyright mas_makeConstraints:^(MASConstraintMaker *make){
//        make.centerX.mas_equalTo(self.view);
//        make.height.mas_equalTo(22);
//        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-18);
//    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = NO;
    UILabel *label = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentCenter];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26);
        make.height.mas_equalTo(22);
        make.centerY.mas_equalTo(cell.contentView);
    }];
    if (indexPath.row == 0) {
        label.text = @"版本更新";
        [self addsegLine:cell];
    }else{
        label.text = @"版本说明";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [XYFAlertView showVersionUpdateView:YES];
    }else{
        GeneralWebViewController *webVC = [[GeneralWebViewController alloc]init];
        webVC.url = @"http://118.31.79.1:8081/money.html";
        webVC.title = @"版本说明";
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

- (void)addsegLine:(UITableViewCell *)cell{
    UILabel *segLine = [[UILabel alloc]init];
    segLine.backgroundColor = SegGray;
    [cell.contentView addSubview:segLine];
    [segLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(cell.mas_right);
        make.bottom.mas_equalTo(cell.contentView.mas_bottom);
        make.height.mas_equalTo(1);
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
