//
//  MoneyDetailCell.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MoneyDetailCell.h"

@interface MoneyDetailCell ()
@property (nonatomic ,strong) UILabel *timeLabel;
@property (nonatomic ,strong) UILabel *totalMoneyLabel;
@property (nonatomic ,strong) UILabel *feeLabel;
@property (nonatomic ,strong) UILabel *actualMoneyLabel;
@end
@implementation MoneyDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath time:(NSString *)time totalMoney:(NSString *)totalMoney fee:(NSString *)fee actualMoney:(NSString *)actualMoney{
    MoneyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyDetailCell"];
    if (!cell) {
        cell = [[MoneyDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoneyDetailCell"];
        cell.selectionStyle = NO;
    }
    cell.timeLabel.text = time;
    cell.totalMoneyLabel.text = totalMoney;
    cell.feeLabel.text = fee;
    cell.actualMoneyLabel.text = actualMoney;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *titleView = [[UIView alloc] init];
        titleView.backgroundColor = ThemeColor;
        [self.contentView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        
        self.timeLabel = [UILabel labelWithTextColor:AlertGray font:16 aligment:NSTextAlignmentLeft];
        [titleView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.mas_equalTo(titleView);
            make.left.mas_equalTo(16);
        }];
        
        UILabel *totalMoneyTitle = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
        totalMoneyTitle.text = @"收款总额";
        [self.contentView addSubview:totalMoneyTitle];
        [totalMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(titleView.mas_bottom).offset(16);
            make.height.mas_equalTo(22);
        }];
        
        self.totalMoneyLabel = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"#F04D1A"] font:16 aligment:NSTextAlignmentRight];
        [self.contentView addSubview:self.totalMoneyLabel];
        [self.totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(-16);
            make.centerY.mas_equalTo(totalMoneyTitle);
            make.height.mas_equalTo(22);
        }];
        
        UILabel *feeTitle = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
        feeTitle.text = @"手续费";
        [self.contentView addSubview:feeTitle];
        [feeTitle mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(totalMoneyTitle.mas_bottom).offset(18);
            make.height.mas_equalTo(22);
        }];
        
        self.feeLabel = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentRight];
        [self.contentView addSubview:self.feeLabel];
        [self.feeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(-16);
            make.centerY.mas_equalTo(feeTitle);
            make.height.mas_equalTo(22);
        }];
        
        UILabel *actualMoneyTitle = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
        actualMoneyTitle.text = @"实际到账金额";
        [self.contentView addSubview:actualMoneyTitle];
        [actualMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(feeTitle.mas_bottom).offset(18);
            make.height.mas_equalTo(22);
        }];
        
        self.actualMoneyLabel = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentRight];
        [self.contentView addSubview:self.actualMoneyLabel];
        [self.actualMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(-16);
            make.centerY.mas_equalTo(actualMoneyTitle);
            make.height.mas_equalTo(22);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
