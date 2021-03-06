//
//  UserInfoViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoTableViewCell.h"
#import "UserHeaderTableViewCell.h"
#import "UserInfoModel.h"

#import <UMCommon/UMCommon.h>
#import <UMPush/UMessage.h>
#import <UserNotifications/UserNotifications.h>

@interface UserInfoViewController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong)UITableView *backTableView;
@property (nonatomic, strong)UIImage *headerImage;

@property (nonatomic, strong)UserInfoModel *model;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
    [self loadData];
}

- (void)loadData {
    [[RequestTool shareManager]sendNewRequestWithAPI:@"/api/sys/person/info" withVC:self withParams:@{@"token":[UserPreferenceModel shareManager].token} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            self.model = [[UserInfoModel alloc]initWithDictionary:response[@"data"] error:nil];
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
        [self.backTableView reloadData];
    }];
}
- (void)prepareViews {
    self.title = @"个人信息";
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
    
    UIButton *loginOutBtn = [UIButton buttonWithTitle:@"退出登录" textColor:[UIColor whiteColor] backGroundColor:nil font:18];
    [loginOutBtn setBackgroundImage:GetImage(@"keyidianji") forState:UIControlStateNormal];
    loginOutBtn.layer.masksToBounds = YES;
    loginOutBtn.layer.cornerRadius = 4;
    [self.view addSubview:loginOutBtn];
    [loginOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(iPhoneX ? -54:-20);
        make.height.mas_equalTo(40);
    }];
    [loginOutBtn addTarget:self action:@selector(loginOutAction) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1:3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 4:10;
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
    return indexPath.section == 0 ? [UserHeaderTableViewCell cellWithTableView:tableView headerImage:self.headerImage]:[UserInfoTableViewCell cellWithTableView:tableView indexPath:indexPath dic:self.model];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([UserPreferenceModel shareManager].agreementStatus.integerValue <= 3) {
            [SVProgressHUD showErrorWithStatus:@"您尚未完成实名认证"];
        }else {
            [self addImage];
        }
    }
}
//退出登录
- (void)loginOutAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"确定退出登录？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self postLoginOut];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:sureAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)postLoginOut {
    [[RequestTool shareManager]sendNewRequestWithAPI:@"/api/logout" withVC:self withParams:@{} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            [[UserPreferenceModel shareManager]loginOut];
            //移除别名
            [UMessage removeAlias:[UserPreferenceModel shareManager].token type:@"UMENGTEST" response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
                
            }];
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
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
//            NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
//            picker.mediaTypes = temp_MediaTypes;
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
    
    [[RequestTool shareManager]uploadImageWithUrl:@"api/uploadFile" WithImage:self.headerImage Params:@{@"token":[UserPreferenceModel shareManager].token} Task:^(NSURLSessionUploadTask *task) {

    } Progress:^(float progress, NSString *taskDesc) {

    } Result:^(id response, BOOL isError) {
        NSLog(@"--------%@", response);
        [self saveHeader:response[@"data"][@"filepath"]];
    }];
    
    
    [self.backTableView reloadData];
}

- (void)saveHeader: (NSString *)url {
    [[RequestTool shareManager]sendNewRequestWithAPI:@"/api/sys/save/handPic" withVC:self withParams:@{@"picUrl":url} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        [UserPreferenceModel shareManager].logo = [NSString stringWithFormat:@"http://xinyifu.oss-cn-hangzhou.aliyuncs.com/%@", url];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
