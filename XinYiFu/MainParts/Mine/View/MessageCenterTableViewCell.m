//
//  MessageCenterTableViewCell.m
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import "MessageCenterTableViewCell.h"
#import "MessageListModel.h"

@interface MessageCenterTableViewCell ()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *redPointImageV;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UIImageView *nextImageV;
@end
@implementation MessageCenterTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath dataSource:(NSArray *)dataSource {
    MessageCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCenterTableViewCell"];
    if (!cell) {
        cell = [[MessageCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageCenterTableViewCell"];
        cell.selectionStyle = NO;
    }
    
    MessageListModel *model = dataSource[indexPath.section];
    cell.titleLabel.text = model.title;
    cell.contentLabel.text = model.content;
    cell.timeLabel.text = model.createTime;
    cell.redPointImageV.hidden = model.isRead;
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [UILabel labelWithTextColor:WordCloseBlack font:15 aligment:NSTextAlignmentLeft];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(17);
            make.top.mas_equalTo(9);
            make.height.mas_equalTo(21);
        }];
        
        self.redPointImageV = [[UIImageView alloc]init];
        self.redPointImageV.backgroundColor = [UIColor colorWithHexString:@"#F04D1A"];
        self.redPointImageV.layer.masksToBounds = 1;
        self.redPointImageV.layer.cornerRadius = 5;
        [self addSubview:self.redPointImageV];
        [self.redPointImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
            make.centerY.mas_equalTo(self.titleLabel);
            make.size.mas_equalTo(10);
        }];
        
        self.contentLabel = [UILabel labelWithTextColor:AlertGray font:14 aligment:NSTextAlignmentLeft];
        [self addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel);
            make.bottom.mas_equalTo(-14);
            make.right.mas_equalTo(-40);
            make.height.mas_equalTo(20);
        }];
        
        self.timeLabel = [UILabel labelWithTextColor:WordDeepGray font:13 aligment:NSTextAlignmentRight];
        [self addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.redPointImageV);
            make.height.mas_equalTo(18);
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
