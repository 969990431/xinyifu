//
//  MessageContentViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MessageContentViewController.h"

@interface MessageContentViewController ()
@property (nonatomic, strong)UITableView *backTableView;

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UITextView *contentTextV;
@end

@implementation MessageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
    [self loadData];
    // Do any additional setup after loading the view.
}
- (void)loadData {
    [[RequestTool shareManager]sendNewRequestWithAPI:@"/api/message/info" withVC:self withParams:@{@"messageId":self.messageId} withClassName:nil responseBlock:^(id response, NSString *errorMessage, NSInteger errorCode) {
        if (errorCode == 1) {
            self.titleLabel.text = response[@"data"][@"title"];
            self.timeLabel.text = response[@"data"][@"createTime"];
            self.contentTextV.text = response[@"data"][@"content"];
        }else {
            [SVProgressHUD showErrorWithStatus:errorMessage];
        }
    }];
}
- (void)prepareViews {
    self.title = @"消息内容";
    self.view.backgroundColor = UIColorFromRGB(248, 248, 248);
    
    self.backTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.backTableView];
    self.backTableView.separatorStyle = NO;
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.titleLabel = [UILabel labelWithTextColor:[UIColor blackColor] font:15 aligment:NSTextAlignmentLeft];
    [self.backTableView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(21);
    }];
    
    self.timeLabel = [UILabel labelWithTextColor:AlertGray font:14 aligment:NSTextAlignmentLeft];
    [self.backTableView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(self.view).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
    self.contentTextV = [[UITextView alloc]init];
    self.contentTextV.backgroundColor = [UIColor clearColor];
    self.contentTextV.font = [UIFont systemFontOfSize:14];
    self.contentTextV.textColor = WordDeepGray;
    [self.backTableView addSubview:self.contentTextV];
    self.contentTextV.userInteractionEnabled = NO;
    [self.contentTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(400);
    }];
    
//    self.titleLabel.text = @"jwoejfoawjeofwa";
//    self.timeLabel.text = @"sljdflskdfs";
//    self.contentTextV.text = @"就哦肉感觉啊额外如果 i 啊 hi 哈佛 i 啊痕迹哦饭机哦京东 v 啊我；加工费 i 啊我就感觉哦啊绝对给你看病了飞机可能会 v 技术 架构 i 啊就和我弟家哦埃及违法 i 哦加";
}

@end
