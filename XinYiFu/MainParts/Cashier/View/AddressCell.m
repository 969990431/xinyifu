//
//  AddressCell.m
//  XinYiFu
//
//  Created by apple on 2019/1/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AddressCell.h"

@interface AddressCell ()
@property (nonatomic ,retain) UILabel *nameLabel;
@property (nonatomic ,retain) UILabel *phoneNumLabel;
@property (nonatomic ,retain) UILabel *addressLabel;
@end
@implementation AddressCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath name:(nonnull NSString *)name phoneNum:(nonnull NSString *)phoneNum address:(nonnull NSString *)address{
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADDRESSCELL"];
    if (!cell) {
        cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ADDRESSCELL"];
    }
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",name];
    cell.phoneNumLabel.text = [NSString stringWithFormat:@"%@",phoneNum];
    cell.addressLabel.text = [NSString stringWithFormat:@"%@",address];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.nameLabel = [UILabel labelWithTextColor:WordCloseBlack font:18 aligment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(6);
            make.left.mas_equalTo(16);
            make.height.mas_equalTo(26);
        }];
        
        self.phoneNumLabel = [UILabel labelWithTextColor:WordCloseBlack font:16 aligment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.phoneNumLabel];
        [self.phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.nameLabel);
            make.left.mas_equalTo(self.nameLabel.mas_right).offset(18);
            make.height.mas_equalTo(22);
        }];
        
        self.addressLabel = [UILabel labelWithTextColor:WordDeepGray font:14 aligment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(6);
            make.left.mas_equalTo(16);
            make.height.mas_equalTo(20);
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
