//
//  UserHeaderTableViewCell.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UserHeaderTableViewCell.h"

@interface UserHeaderTableViewCell ()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *headerImageV;
@property (nonatomic, strong)UIImageView *nextImageV;
@end
@implementation UserHeaderTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView headerImage: (UIImage *)image{
    UserHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserHeaderTableViewCell"];
    if (!cell) {
        cell = [[UserHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserHeaderTableViewCell"];
        cell.selectionStyle = NO;
    }
    
    cell.titleLabel.text = @"头像";
    [cell.headerImageV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:GetImage(@"touxiang")];
    [cell.headerImageV setImage:image];
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [UILabel labelWithTextColor:WordDeepGray font:15 aligment:NSTextAlignmentLeft];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(21);
        }];
        
        self.headerImageV = [[UIImageView alloc]init];
        self.headerImageV.layer.masksToBounds = 1;
        self.headerImageV.layer.cornerRadius = 22.5;
        [self addSubview:self.headerImageV];
        [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-26);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(45);
        }];
        
        self.nextImageV = [[UIImageView alloc]initWithImage:GetImage(@"youjaintou")];
        [self addSubview:self.nextImageV];
        [self.nextImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-18);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(5, 10));
        }];
    }
    return self;
}

@end
