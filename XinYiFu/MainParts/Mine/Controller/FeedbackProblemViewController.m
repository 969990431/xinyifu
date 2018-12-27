//
//  FeedbackProblemViewController.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FeedbackProblemViewController.h"

@interface FeedbackProblemViewController ()
@property (nonatomic ,strong) UITableView *backTableView;

@property (nonatomic ,strong) UITextView *textView;

@property (nonatomic ,strong) UIView *imageWallView;
@property (nonatomic ,strong) NSMutableArray *imageArray;
@end

@implementation FeedbackProblemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈问题";
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
    
    UIView *topTitleView = [[UIView alloc]init];
    [self.backTableView addSubview:topTitleView];
    [topTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(44);
    }];
    UILabel *topTitleLabel = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentLeft];
    topTitleLabel.text = @"问题和意见";
    [topTitleView addSubview:topTitleLabel];
    [topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(topTitleView);
        make.height.mas_equalTo(22);
    }];
    
    UIView *textViewBackView = [[UIView alloc] init];
    textViewBackView.backgroundColor = [UIColor whiteColor];
    [self.backTableView addSubview:textViewBackView];
    [textViewBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(topTitleView.mas_bottom);
        make.height.mas_equalTo(180);
    }];
    self.textView = [[UITextView alloc] init];
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"请留下您对我们的不满以及您对我们软件的改良意见";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [self.textView addSubview:placeHolderLabel];
    // same font
    self.textView.font = [UIFont systemFontOfSize:14.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:14.f];
    [self.textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    [textViewBackView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(180);
    }];
    
    UIView *bottomTitleView = [[UIView alloc]init];
    [self.backTableView addSubview:bottomTitleView];
    [bottomTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textViewBackView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(44);
    }];
    UILabel *bottomTitleLabel = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentLeft];
    bottomTitleLabel.text = @"请提供相关问题的截图或照片";
    [bottomTitleView addSubview:bottomTitleLabel];
    [bottomTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(bottomTitleView);
        make.height.mas_equalTo(22);
    }];
    CGFloat imageWidth = (CGRectGetWidth(self.view.frame) - 36 - 20) / 3;
    self.imageWallView = [[UIView alloc] init];
    self.imageWallView.backgroundColor = [UIColor whiteColor];
    [self.backTableView addSubview:self.imageWallView];
    [self.imageWallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomTitleView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(imageWidth + 20);
    }];
    
    [self reloadImageWall];
    
    UIButton *submitButton = [UIButton buttonWithTitle:@"提交" font:18 titleColor:[UIColor whiteColor] backGroundColor:nil aligment:0];
    [submitButton setBackgroundImage:GetImage(@"keyidianji") forState:UIControlStateNormal];
    [self.backTableView addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageWallView.mas_bottom).offset(36);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(self.view.mas_right).offset(-16);
        make.height.mas_equalTo(40);
    }];
}

- (void)reloadImageWall{
    CGFloat imageWidth = (CGRectGetWidth(self.view.frame) - 36 - 20) / 3;
    for (int i = 0; i < self.imageArray.count; i++) {
    }
    
    if (self.imageArray.count < 3) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:GetImage(@"shangchuantupian") forState:UIControlStateNormal];
        [self.imageWallView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(18+imageWidth*self.imageArray.count+10*self.imageArray.count);
            make.width.height.mas_equalTo(imageWidth);
        }];
    }

}

- (void)addImage{
//    UIAlertController *alert = [UIAlertController al]
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