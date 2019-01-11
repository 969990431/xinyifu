//
//  SelectProvinceViewController.m
//  XinYiFu
//
//  Created by apple on 2019/1/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SelectProvinceViewController.h"

@interface SelectProvinceViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *backTableView;
@end

@implementation SelectProvinceViewController

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
    
    // 请求头
    NSString *accessPath = @"http://118.31.79.1:8081/api/combo?token=APP:Login:72bf4c0258c84cfb8f367369d16e83f7&type=0";
    // 请求参数字典
    NSDictionary *params = @{@"token":[UserPreferenceModel shareManager].token, @"type":@"0"};
    
    NSLog(@"发送请求url=%@,params=%@",accessPath,params);
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:accessPath parameters:params error:nil];
    request.timeoutInterval = 10.f;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"-----responseObject===%@+++++",responseObject);
        if (!error) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                // 请求成功数据处理
            } else {
                
            }
        } else {
            NSLog(@"请求失败error=%@", error);
        }
    }];
    
    [task resume];
    
    
    
    
    
    
    
//    [[RequestTool shareManager]sendRequestWithAPI:@"/api/combo" withVC:self withParams:@{@"token":[UserPreferenceModel shareManager].token, @"type":@"0"} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
//        if (errorCode == 1) {
//
//        }else {
//            [SVProgressHUD showErrorWithStatus:errorMessage];
//        }
//    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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
    cell.textLabel.text = @"123";
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
