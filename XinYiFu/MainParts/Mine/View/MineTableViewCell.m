//
//  MineTableViewCell.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MineTableViewCell.h"
@interface MineTableViewCell()
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *titleLabel;
@end

@implementation MineTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath imageName:(NSString *)imageName title:(NSString *)title {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell"];
    if (!cell) {
        cell = [[MineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineTableViewCell"];
        cell.selectionStyle = NO;
    }
    
    cell.imageV.image = GetImage(imageName);
    cell.titleLabel.text = title;
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageV = [[UIImageView alloc]init];
        [self addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(19);
        }];
        
        self.titleLabel = [UILabel labelWithTextColor:WordCloseBlack font:15 aligment:NSTextAlignmentLeft];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageV.mas_right).offset(10);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(21);
        }];
        
        UIImageView *nextImageV = [[UIImageView alloc]initWithImage:GetImage(@"youjaintou")];
        [self addSubview:nextImageV];
        [nextImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(5, 10));
        }];
        
        UILabel *bottomLine = [[UILabel alloc]init];
        bottomLine.backgroundColor = SegGray;
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    
    return self;
}


@end
