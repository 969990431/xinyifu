//
//  UserSetTableViewCell.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UserSetTableViewCell.h"

@interface UserSetTableViewCell ()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UIImageView *nextImageV;

@end

@implementation UserSetTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath kefudianhua:(nonnull NSString *)kefudianhua{
    UserSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserSetTableViewCell"];
    if (!cell) {
        cell = [[UserSetTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserSetTableViewCell"];
        cell.selectionStyle = NO;
    }
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"密码设置";
            cell.contentLabel.text = @"";
        }else {
            cell.titleLabel.text = @"更换手机号";
            cell.contentLabel.text = @"";
        }
    }else if (indexPath.section == 1) {
        cell.titleLabel.text = @"用户协议";
        cell.contentLabel.text = @"";
    }else {
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"关于薪易付";
            cell.contentLabel.text = @"";
        }else {
            cell.titleLabel.text = @"联系客服";
            cell.contentLabel.text = kefudianhua;
            cell.contentLabel.textColor = WordGreen;
        }
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
            make.right.mas_equalTo(-34);
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
        
        self.nextImageV = [[UIImageView alloc]initWithImage:GetImage(@"youjaintou")];
        [self addSubview:self.nextImageV];
        [self.nextImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(5, 10));
        }];
    }
    return self;
}

@end
