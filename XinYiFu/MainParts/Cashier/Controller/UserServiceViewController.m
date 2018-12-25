//
//  UserServiceViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UserServiceViewController.h"
#import "AddAddressViewController.h"

@interface UserServiceViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIButton *selectedButton;
}
@property (nonatomic , strong) UITableView *backTableView;

@property (nonatomic , strong) UIView *headerView;
@property (nonatomic , strong) UIImageView *headerImgView;

@property (nonatomic , strong) UIView *tabbar;
@property (nonatomic , strong) UIButton *item0;
@property (nonatomic , strong) UIButton *item1;
@end

@implementation UserServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商家服务";
    [self prepareViews];
}

- (void)prepareViews{
    self.backTableView = [[UITableView alloc]init];
    self.backTableView.dataSource = self;
    self.backTableView.delegate = self;
    self.backTableView.backgroundColor = ThemeColor;
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame) / 188 * 146 + 44)];
    self.backTableView.tableHeaderView = self.headerView;
    
    self.headerImgView = [[UIImageView alloc] initWithImage:GetImage(@"guanfangshoukuanma")];
    [self.headerView addSubview:self.headerImgView];
    [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(CGRectGetWidth(self.view.frame) / 188 * 146);
    }];
    
    self.tabbar = [[UIView alloc] init];
    self.tabbar.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:self.tabbar];
    [self.tabbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.headerView.mas_bottom);
    }];
    
    self.item0 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.item0.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self.item0 setTitle:@"官方推送" forState:UIControlStateNormal];
    [self.item0 setTitleColor:WordDeepGray forState:UIControlStateNormal];
    [self.item0 setTitle:@"官方推送" forState:UIControlStateSelected];
    [self.item0 setTitleColor:WordOrange forState:UIControlStateSelected];
    self.item0.selected = YES;
    selectedButton = self.item0;
    [self.backTableView reloadData];
    [self.item0 addTarget:self action:@selector(tabbarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabbar addSubview:self.item0];
    [self.item0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(CGRectGetWidth(self.view.frame) / 2);
    }];

    self.item1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.item1.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self.item1 setTitle:@"自行打印" forState:UIControlStateNormal];
    [self.item1 setTitleColor:WordDeepGray forState:UIControlStateNormal];
    [self.item1 setTitle:@"自行打印" forState:UIControlStateSelected];
    [self.item1 setTitleColor:WordOrange forState:UIControlStateSelected];
    [self.item1 addTarget:self action:@selector(tabbarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabbar addSubview:self.item1];
    [self.item1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo(CGRectGetWidth(self.view.frame) / 2);
    }];

}

- (void)tabbarItemAction:(UIButton *)sender{
    if (selectedButton == sender) {
        return;
    }
    selectedButton.selected = NO;
    sender.selected = YES;
    selectedButton = sender;
    [self.backTableView reloadData];
    if (sender == self.item0) {
        self.headerImgView.image = GetImage(@"guanfangshoukuanma");
    }else{
        self.headerImgView.image = GetImage(@"zixingdayin");
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (selectedButton == self.item0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"state0"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        UILabel *namephone = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentLeft];
        namephone.text = @"李梦龙 15062347667";
        [cell.contentView addSubview:namephone];
        [namephone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(16);
            make.height.mas_equalTo(22);
        }];
        
        UILabel *address = [UILabel labelWithTextColor:WordDeepGray font:14 aligment:NSTextAlignmentLeft];
        address.text = @"江苏省无锡市新吴区机场路100号原日报社";
        [cell.contentView addSubview:address];
        [address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(namephone.mas_bottom).offset(4);
            make.left.mas_equalTo(16);
            make.height.mas_equalTo(20);
        }];
        
        UILabel *addAddress = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentRight];
        addAddress.text = @"添加收货地址";
        [cell.contentView addSubview:addAddress];
        [addAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.right.mas_equalTo(10);
            make.height.mas_equalTo(22);
        }];


    }else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"state1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:GetImage(@"dayinji")];
        [cell.contentView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(16);
            make.width.height.mas_equalTo(70);
        }];
        
        UILabel *title = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentLeft];
        title.text = @"保存收钱码图片即可收钱";
        [cell.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(14);
            make.left.mas_equalTo(imgView.mas_right).offset(16);
            make.height.mas_equalTo(22);
        }];
        
        UILabel *subTitle = [UILabel labelWithTextColor:WordDeepGray font:14 aligment:NSTextAlignmentLeft];
        subTitle.text = @"让您的财务状态更加统一化";
        [cell.contentView addSubview:subTitle];
        [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(title.mas_bottom).offset(2);
            make.left.mas_equalTo(imgView.mas_right).offset(16);
            make.height.mas_equalTo(20);
        }];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (selectedButton == self.item0) {
        [self.navigationController pushViewController:[[AddAddressViewController alloc] init] animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (selectedButton == self.item0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 46.f)];
        UILabel *label = [UILabel labelWithTextColor:WordDeepGray font:14 aligment:NSTextAlignmentLeft];
        label.text = @"海报邮寄到";
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view);
            make.left.mas_equalTo(16);
        }];
        return view;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (selectedButton == self.item0) {
        return 46.f;
    }
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100.f)];
    
    UILabel *label = [UILabel labelWithTextColor:AlertGray font:12 aligment:NSTextAlignmentLeft];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(6);
        make.left.mas_equalTo(18);
    }];
    label.attributedText = [@"查看《薪易付收钱码协议》" changeColor:WordRed andRange:NSMakeRange(2, 10)];

    UIButton *button = nil;
    if (selectedButton == self.item0) {
        button = [UIButton buttonWithTitle:@"确定领取" font:18 titleColor:[UIColor whiteColor] backGroundColor:nil aligment:0];
    }else{
        button = [UIButton buttonWithTitle:@"同意协议并保存图片" font:18 titleColor:[UIColor whiteColor] backGroundColor:nil aligment:0];
    }
    [button setBackgroundImage:GetImage(@"keyidianji") forState:UIControlStateNormal];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(54);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(view.mas_right).offset(-16);
        make.height.mas_equalTo(40);
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.f;
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
