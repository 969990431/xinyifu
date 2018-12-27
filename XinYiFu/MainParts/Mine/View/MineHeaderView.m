//
//  MineHeaderView.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MineHeaderView.h"

@interface MineHeaderView ()
@property (nonatomic, strong)UIImageView *headerImageV;
@property (nonatomic, strong)UILabel *companyNameLabel;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIImageView *nextImageV;
@property (nonatomic, strong)UIImageView *setImageV;
@property (nonatomic, strong)UILabel *setLabel;

@property (nonatomic, strong)UIView *messageCenterV;

@property (nonatomic, copy)ClickCallBack setClick;
@property (nonatomic, copy)ClickCallBack userCenterClick;
@property (nonatomic, copy)ClickCallBack messageCenterClick;
@end

@implementation MineHeaderView
+ (instancetype)mineHeaderViewWithSetClick:(ClickCallBack)setClick userCenterClick:(ClickCallBack)userCenterClick messageCenter:(ClickCallBack)messageCenterClick{
    MineHeaderView *view = [[MineHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 211)];
    view.setClick = setClick;
    view.userCenterClick = userCenterClick;
    view.messageCenterClick = messageCenterClick;
    
    [view.headerImageV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:GetImage(@"bianjitouxiang")];
    view.companyNameLabel.text = @"公司名字";
    view.nameLabel.text = @"姓名 123123123";
    return view;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *backImageV = [[UIImageView alloc]initWithImage:GetImage(@"gerenbeijng")];
        backImageV.backgroundColor = RandomColor;
        [self addSubview:backImageV];
        [backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(159);
        }];
        
        self.headerImageV = [[UIImageView alloc]init];
        self.headerImageV.layer.masksToBounds = 1;
        self.headerImageV.layer.cornerRadius = 35;
        self.headerImageV.layer.borderColor = [UIColor whiteColor].CGColor;
        self.headerImageV.layer.borderWidth = 2;
        self.headerImageV.backgroundColor = RandomColor;
        [self addSubview:self.headerImageV];
        [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(61);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(70);
        }];
        
        self.companyNameLabel = [UILabel labelWithTextColor:[UIColor whiteColor] font:16 aligment:NSTextAlignmentLeft];
        [self addSubview:self.companyNameLabel];
        [self.companyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headerImageV.mas_right).offset(13);
            make.top.mas_equalTo(self.headerImageV.mas_top).offset(13);
            make.height.mas_equalTo(22);
        }];
        
        self.nameLabel = [UILabel labelWithTextColor:[UIColor whiteColor] font:14 aligment:NSTextAlignmentLeft];
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.companyNameLabel);
            make.bottom.mas_equalTo(self.headerImageV.mas_bottom).offset(-8);
            make.height.mas_equalTo(20);
        }];
        
        self.nextImageV = [[UIImageView alloc]initWithImage:GetImage(@"baijiantou")];
        [self addSubview:self.nextImageV];
        [self.nextImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.headerImageV);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(6, 12));
        }];
        
        self.setImageV = [[UIImageView alloc]initWithImage:GetImage(@"shezhi")];
        [self addSubview:self.setImageV];
        [self.setImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(31);
            make.right.mas_equalTo(-57);
            make.size.mas_equalTo(18);
        }];
        
        self.setLabel = [UILabel labelWithTextColor:[UIColor whiteColor] font:16 aligment:NSTextAlignmentLeft];
        self.setLabel.text = @"设置";
        [self addSubview:self.setLabel];
        [self.setLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.setImageV.mas_right).offset(5);
            make.centerY.mas_equalTo(self.setImageV);
            make.height.mas_equalTo(22);
        }];
        
        self.messageCenterV = [[UIView alloc]init];
        self.messageCenterV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoMessageClick)];
        [self.messageCenterV addGestureRecognizer:tap];
        self.messageCenterV.backgroundColor = [UIColor whiteColor];
//        self.messageCenterV.layer.masksToBounds = 1;
        self.messageCenterV.layer.cornerRadius = 5;
        self.messageCenterV.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.messageCenterV.layer.shadowOffset = CGSizeMake(10, 30);
        self.messageCenterV.layer.shadowOpacity = 0.2;
        self.messageCenterV.layer.shadowRadius = 30;
        
        [self addSubview:self.messageCenterV];
        [self.messageCenterV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-15);
            make.height.mas_equalTo(45);
        }];
        
        UIImageView *imageV = [[UIImageView alloc]initWithImage:GetImage(@"xiaoxi")];
        [self.messageCenterV addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.messageCenterV);
            make.size.mas_equalTo(CGSizeMake(17, 19));
            
        }];
        
        UILabel *label = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentLeft];
        label.text = @"消息中心";
        [self.messageCenterV addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageV.mas_right).offset(10);
            make.centerY.mas_equalTo(imageV);
            make.height.mas_equalTo(22);
        }];
        
        UIImageView *nextImageV = [[UIImageView alloc]initWithImage:GetImage(@"youjaintou")];
        [self.messageCenterV addSubview:nextImageV];
        [nextImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imageV);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(5, 10));
        }];
        
        
        UIButton *gotoUserCenterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:gotoUserCenterBtn];
        [gotoUserCenterBtn addTarget:self action:@selector(gotoUserCenterClick) forControlEvents:UIControlEventTouchUpInside];
        [gotoUserCenterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.headerImageV);
            make.bottom.mas_equalTo(self.headerImageV);
        }];
        
        UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:setBtn];
        [setBtn addTarget:self action:@selector(gotoSetClick) forControlEvents:UIControlEventTouchUpInside];
        [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(100, 60));
        }];
    }
    return self;
}

- (void)gotoUserCenterClick {
    if (self.userCenterClick) {
        self.userCenterClick();
    }
}
- (void)gotoSetClick {
    if (self.setClick) {
        self.setClick();
    }
}
- (void)gotoMessageClick {
    if (self.messageCenterClick) {
        self.messageCenterClick();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
