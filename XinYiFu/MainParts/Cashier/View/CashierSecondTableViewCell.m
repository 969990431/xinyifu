//
//  CashierSecondTableViewCell.m
//  XinYiFu
//
//  Created by apple on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CashierSecondTableViewCell.h"

@implementation CashierSecondTableViewCell

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *backView = [[UIView alloc]init];
        [self addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.bottom.mas_equalTo(0);
        }];
        
        backView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
        backView.layer.masksToBounds = YES;
        backView.layer.cornerRadius = 10;
        
        UIImageView *shopImageV = [[UIImageView alloc]initWithImage:GetImage(@"shangjiafuwu")];
        [backView addSubview:shopImageV];
        [shopImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(backView.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
        UILabel *shopLabel = [UILabel labelWithTextColor:UIColorFromRGB(240, 77, 26) font:15 aligment:NSTextAlignmentLeft];
        [backView addSubview:shopLabel];
        shopLabel.text = @"商家服务";
        [shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(shopImageV.mas_right).offset(20);
            make.height.mas_equalTo(21);
        }];
        
        UIImageView *nextImageV = [[UIImageView alloc]initWithImage:GetImage(@"youjaintou")];
        [backView addSubview:nextImageV];
        [nextImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(backView.mas_right).offset(-15);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(5, 10));
        }];
    }
    
    return self;
}

@end
