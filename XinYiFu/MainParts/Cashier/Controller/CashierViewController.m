//
//  CashierViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CashierViewController.h"
#import "LoginViewController.h"
#import "UserServiceViewController.h"

#import "CashierFirstTableViewCell.h"
#import "CashierSecondTableViewCell.h"

#import "PersonalAuthViewController.h"
#import "CompanyAuthenViewController.h"

#import "SetMoneyViewController.h"
#import "AuthStatusViewController.h"
#import "NavViewController.h"
#import "IncomeRecordViewController.h"

#import "CashierStatusModel.h"

@interface CashierViewController ()<UITableViewDelegate, UITableViewDataSource, CashierFirstTableViewCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/**
 显示类型
 0:未认证
 1:审核中
 2:审核失败
 3:已认证，可以扫码
 4:已认证，有二维码，有金额
 */
@property (nonatomic, assign)NSInteger type;

@property (nonatomic, strong)UITableView *backTableView;
@property (nonatomic, strong)UIImage *headerImage;

@property (nonatomic, strong)CashierStatusModel *model;
@end

@implementation CashierViewController
- (NSInteger)type {
    if (!_type) {
        _type = 0;
    }
    return _type;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
//    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if (![UserPreferenceModel shareManager].token) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[NavViewController alloc]initWithRootViewController:loginVC];
    }else {
//        [self loadUserData];
        [self loadData];
    }
}
//用户信息请求
- (void)loadUserData {
    [[RequestTool shareManager]sendRequestWithAPI:@"/api/" withVC:self withParams:nil withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)prepareViews {
    self.view.backgroundColor = UIColorFromRGB(248, 248, 248);
    
    UIImageView *backImageV = [[UIImageView alloc]initWithImage:GetImage(@"shouyinbeijing")];
    [self.view addSubview:backImageV];
    [backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(GetFloatWithHightPXSIX(324));
    }];
    
    self.backTableView = [[UITableView alloc]init];
    self.backTableView.delegate = self;
    self.backTableView.dataSource = self;
    self.backTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    self.backTableView.showsVerticalScrollIndicator = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.backTableView.showsVerticalScrollIndicator = NO;
}

- (void)loadData {
//    [[RequestTool shareManager]sendRequestWithAPI:@"/api/home_page" withVC:self withParams:@{@"token":[UserPreferenceModel shareManager].token} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
//        if (errorCode == 1) {
//            
//        }else {
//            [SVProgressHUD showErrorWithStatus:errorMessage];
//        }
//    }];
    NSLog(@"========%@", [UserPreferenceModel shareManager].token);
    if ([UserPreferenceModel shareManager].token) {
        [[RequestTool shareManager]sendRequestWithAPI:@"/api/store/info" withVC:self withParams:@{@"token":[UserPreferenceModel shareManager].token} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
            if (errorCode == 1) {
                self.model = [[CashierStatusModel alloc]initWithDictionary:response[@"data"] error:nil];
                
                [UserPreferenceModel shareManager].name = self.model.name;
                [UserPreferenceModel shareManager].mobile = self.model.mobile;
                [UserPreferenceModel shareManager].userName = self.model.userName;
                [UserPreferenceModel shareManager].cashQr = self.model.cashQr;
                [UserPreferenceModel shareManager].agreementStatus = self.model.agreementStatus;
//                [UserPreferenceModel shareManager].agreementStatus = @"0";
                
            }else {
                [SVProgressHUD showErrorWithStatus:errorMessage];
            }
            
            [self.backTableView reloadData];
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.type == 0 || self.type == 4) {
        return 2;
    }else {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.type == 4) {
            return 538+113;
        }else {
            return 449+113;
        }
    }else {
        return 45;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc]init];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [CashierFirstTableViewCell cellWithTableView:tableView indexPath:indexPath type:[UserPreferenceModel shareManager].agreementStatus.integerValue delegate:self];
    }else {
        return [[CashierSecondTableViewCell alloc]init];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
//        商家服务
        [self userService];
    }
}

//认证确认跳转
- (void)authenWithType:(NSInteger)type {
    if (type == 0) {
        PersonalAuthViewController *vc = [[PersonalAuthViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        CompanyAuthenViewController *vc = [[CompanyAuthenViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
//设置金额
- (void)setMoney {
    SetMoneyViewController *vc = [[SetMoneyViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//保存首款吗
- (void)savePic {
    [SVProgressHUD showSuccessWithStatus:@"已保存二维码至相册"];
}
//收款记录
- (void)gotoRecord {
    IncomeRecordViewController *vc = [[IncomeRecordViewController alloc]init];
    vc.hidesBottomBarWhenPushed = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)userService{
    UserServiceViewController *view = [[UserServiceViewController alloc] init];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
//    AuthStatusViewController *authVC = [[AuthStatusViewController alloc]init];
//    [self.navigationController pushViewController:authVC animated:YES];
}
//点击头像
- (void)clickTheHeader {
    [self addImage];
}


- (void)addImage{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.mediaTypes = temp_MediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
            picker.mediaTypes = temp_MediaTypes;
            picker.delegate = self;
            picker.allowsEditing = NO;
        }
        [self presentViewController:picker animated:YES completion:nil];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        
    }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.headerImage = info[@"UIImagePickerControllerOriginalImage"];
    [self.backTableView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
