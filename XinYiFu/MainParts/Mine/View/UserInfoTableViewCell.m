//
//  UserInfoTableViewCell.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UserInfoTableViewCell.h"

@interface UserInfoTableViewCell ()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@end

@implementation UserInfoTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath dic:(UserInfoModel*)model{
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoTableViewCell"];
    if (!cell) {
        cell = [[UserInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserInfoTableViewCell"];
        cell.selectionStyle = NO;
    }
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"银行名称";
        cell.contentLabel.text = model.bankName;
    }else if (indexPath.row == 1) {
        cell.titleLabel.text = @"银行卡号";
        cell.contentLabel.text = model.cardNo;
    }else {
        cell.contentLabel.text = model.arrive;
        cell.titleLabel.text = @"到账周期";
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [UILabel labelWithTextColor:WordDeepGray font:16 aligment:NSTextAlignmentLeft];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(22);
        }];
        
        self.contentLabel = [UILabel labelWithTextColor:WordCloseBlack font:15 aligment:NSTextAlignmentRight];
        [self addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(21);
        }];
        
        UILabel *bottomLine = [[UILabel alloc]init];
        bottomLine.backgroundColor = SegGray;
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
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
