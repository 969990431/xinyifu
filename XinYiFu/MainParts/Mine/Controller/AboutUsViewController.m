//
//  AboutUsViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/28.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
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
    self.backTableView.backgroundColor = ThemeColor;
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:GetImage(@"guanyuxinyifu")];
    [self.backTableView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(72);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(168);
        make.height.mas_equalTo(58);
    }];
    
    self.versionLabel = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"030303"] font:18 aligment:NSTextAlignmentCenter];
    self.versionLabel.text = @"v 1.0.0";
    [self.backTableView addSubview:self.versionLabel];
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(imageView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(imageView);
        make.height.mas_equalTo(26);
    }];
    
    UILabel *detailTitle = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentLeft];
    detailTitle.text = @"版本说明：";
    [self.backTableView addSubview:detailTitle];
    [detailTitle mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.versionLabel.mas_bottom).offset(24);
        make.left.mas_equalTo(34);
    }];
    
    self.detailLabel = [UILabel labelWithTextColor:AlertGray font:16 aligment:NSTextAlignmentLeft];
    self.detailLabel.text = @"版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明版本说明";
    [self.backTableView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(detailTitle.mas_bottom);
        make.left.mas_equalTo(34);
        make.right.mas_equalTo(self.view.mas_right).offset(-34);
    }];
    
    UILabel *copyright = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentCenter];
    copyright.text = @"copyright 2019";
    [self.backTableView addSubview:copyright];
    [copyright mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(22);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-18);
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
