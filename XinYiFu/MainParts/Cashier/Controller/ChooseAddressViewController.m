//
//  ChooseAddressViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ChooseAddressViewController.h"
#import "AddAddressViewController.h"
#import "AddressCell.h"

@interface ChooseAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *backTableView;
@property (nonatomic , strong) UIButton *submitBtn;

@property (nonatomic , strong) NSMutableArray *dataArray;
@end

@implementation ChooseAddressViewController

#define NAME @"1"
#define PHONENUM @"2"
#define ADDRESS @"3"
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择地址";
    [self prepareViews];
    self.dataArray = [NSMutableArray arrayWithObjects:@{NAME:@"李梦龙",PHONENUM:@"15061473870",ADDRESS:@"江苏省无锡市新吴区机场路100号原日报社"},@{NAME:@"李龙",PHONENUM:@"15061473871",ADDRESS:@"江苏省无锡市新吴区机场路101号原日报社"},nil];
}

- (id)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)prepareViews{
    self.backTableView = [[UITableView alloc]initWithFrame:CGRectNull style:UITableViewStyleGrouped];
    self.backTableView.dataSource = self;
    self.backTableView.delegate = self;
    self.backTableView.backgroundColor = ThemeColor;
    self.backTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    self.backTableView.sectionHeaderHeight = CGFLOAT_MIN;
    self.backTableView.sectionFooterHeight = 6.f;
    self.backTableView.separatorStyle = NO;
    [self.view addSubview:self.backTableView];
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100)];
    self.backTableView.tableFooterView = footerView;
    
    self.submitBtn = [UIButton buttonWithTitle:@"使用其他地址" font:18 titleColor:[UIColor whiteColor] backGroundColor:nil aligment:0];
    [self.submitBtn setBackgroundImage:GetImage(@"keyidianji") forState:UIControlStateNormal];
    [self.submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(self.view.mas_right).offset(-16);
        make.top.mas_equalTo(22);
        make.height.mas_equalTo(40);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dataDic = self.dataArray[indexPath.section];
    
    return [AddressCell cellWithTableView:tableView indexPath:indexPath name:dataDic[NAME] phoneNum:dataDic[PHONENUM] address:dataDic[ADDRESS]];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您确定删除该地址吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [self.dataArray removeObjectAtIndex:indexPath.section];
            [tableView reloadData];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64.f;
}

- (void)submitBtnAction:(UIButton *)sender{
    [self.navigationController pushViewController:[[AddAddressViewController alloc] init] animated:YES];
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
