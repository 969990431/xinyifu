//
//  IncomeRecordHeadCell.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "IncomeRecordHeadCell.h"

@interface IncomeRecordHeadCell ()
@property (nonatomic , strong) UILabel *countValueLabel;
@property (nonatomic , strong) UILabel *totalValue;
@end

@implementation IncomeRecordHeadCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath count:(NSString *)count total:(NSString *)total{
    IncomeRecordHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IncomeRecordHeadCell"];
    if (!cell) {
        cell = [[IncomeRecordHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IncomeRecordHeadCell"];
        cell.selectionStyle = NO;
    }
    cell.countValueLabel.text = count;
    cell.totalValue.text = total;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *incomeCountLabel = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"999999"] font:16 aligment:NSTextAlignmentLeft];
        incomeCountLabel.text = @"收款笔数";
        [self.contentView addSubview:incomeCountLabel];
        [incomeCountLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(16);
            make.left.mas_equalTo(16);
            make.height.mas_equalTo(22);
        }];
        
        self.countValueLabel = [UILabel labelWithTextColor:WordCloseBlack font:24 aligment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.countValueLabel];
        [self.countValueLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(incomeCountLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(16);
            make.height.mas_equalTo(34);
        }];
        
        UILabel *totalTitle = [UILabel labelWithTextColor:[UIColor colorWithHexString:@"999999"] font:16 aligment:NSTextAlignmentRight];
        totalTitle.text = @"合计";
        [self.contentView addSubview:totalTitle];
        [totalTitle mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(16);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
            make.height.mas_equalTo(22);
        }];
        
        self.totalValue = [UILabel labelWithTextColor:WordCloseBlack font:24 aligment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.totalValue];
        [self.totalValue mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(totalTitle.mas_bottom).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
            make.height.mas_equalTo(34);
        }];

        UILabel *segLine = [[UILabel alloc] init];
        segLine.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
        [self.contentView addSubview:segLine];
        [segLine mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(1);
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
