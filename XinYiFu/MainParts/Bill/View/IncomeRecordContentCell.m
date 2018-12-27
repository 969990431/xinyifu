//
//  IncomeRecordContentCell.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "IncomeRecordContentCell.h"

@interface IncomeRecordContentCell ()
@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic ,strong) UILabel *timeLabel;
@property (nonatomic ,strong) UILabel *moneyLabel;
@end
@implementation IncomeRecordContentCell


+ (instancetype)cellWithTableView: (UITableView *)tableView indexPath: (NSIndexPath *)indexPath name:(NSString *)name time:(NSString *)time money:(NSString *)money{
    IncomeRecordContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IncomeRecordContentCell"];
    if (!cell) {
        cell = [[IncomeRecordContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IncomeRecordContentCell"];
        cell.selectionStyle = NO;
    }
    cell.nameLabel.text = name;
    cell.timeLabel.text = time;
    cell.moneyLabel.text = money;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *segLine = [[UILabel alloc]init];
        segLine.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
        [self.contentView addSubview:segLine];
        [segLine mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(16);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
            make.height.mas_equalTo(1);
        }];
        
        self.nameLabel = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
        [self.contentView addSubview: self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(16);
            make.height.mas_equalTo(22);
        }];
        
        self.timeLabel = [UILabel labelWithTextColor:AlertGray font:14 aligment:NSTextAlignmentLeft];
        [self.contentView addSubview: self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(6);
            make.left.mas_equalTo(16);
            make.height.mas_equalTo(20);
        }];

        self.moneyLabel = [UILabel labelWithTextColor:WordCloseBlack font:18 aligment:NSTextAlignmentRight];
        [self.contentView addSubview: self.moneyLabel];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(22);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
            make.height.mas_equalTo(26);
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
