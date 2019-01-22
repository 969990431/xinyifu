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
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 手机当前APP软件版本  比如：1.0.2
    NSString *nativeVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

    self.versionLabel.text = [NSString stringWithFormat:@"v %@",nativeVersion];
    [backView addSubview:self.versionLabel];
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(imageView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(imageView);
        make.height.mas_equalTo(26);
    }];
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
        [self PostpathAPPStoreVersion];
//        [[RequestTool shareManager] sendNewRequestWithAPI:@"/api/sys/version/valid" withVC:self withParams:@{@"version":@"1.0.0"} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
//            if (errorCode == 1) {
//                if ([response[@"data"][@"status"] integerValue] == 1) {
//                    [XYFAlertView showVersionUpdateView:NO];
//                }else{
//                    [XYFAlertView showVersionUpdateView:YES];
//                }
//            }else{
//                [SVProgressHUD showErrorWithStatus:errorMessage];
//            }
//        }];
    }else{
        GeneralWebViewController *webVC = [[GeneralWebViewController alloc]init];
        webVC.url = @"http://118.31.79.1:8081/version.html";
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


- (void)PostpathAPPStoreVersion{
    [SVProgressHUD show];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",XYFAPPID]]];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        [self receiveData:responseObject[@"results"][0]];
    }];
        
    [task resume];
}

-(void)receiveData:(id)sender{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 手机当前APP软件版本  比如：1.0.2
    NSString *nativeVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *storeVersion  = sender[@"version"];
    
    NSComparisonResult comparisonResult = [nativeVersion compare:storeVersion options:NSNumericSearch];
    
    switch (comparisonResult) {
        case NSOrderedSame:
            [XYFAlertView showVersionUpdateView:NO];
            break;
        case NSOrderedAscending:
        {
            XYFAlertView *view = [XYFAlertView showVersionUpdateView:YES];
            view.block = ^(){
                NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@", XYFAPPID];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES}
                                         completionHandler:^(BOOL success) {
                                             
                                         }];
            };
        }
            break;
        case NSOrderedDescending:
            [XYFAlertView showVersionUpdateView:NO];
            break;
        default:
            break;
    }
    
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
