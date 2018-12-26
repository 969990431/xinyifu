//
//  EditInfoTableViewCell.m
//  XinYiFu
//
//  Created by apple on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "EditInfoTableViewCell.h"

@interface EditInfoTableViewCell()
@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)UIImageView *nextImageV;
@end
@implementation EditInfoTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath delegate:(id<EditInfoTableViewCellDelegate>)delegate type:(NSInteger)type title:(NSString *)title placeHolder:(NSString *)placeHolderString {
    EditInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EditInfoTableViewCell"];
    if (!cell) {
        cell = [[EditInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EditInfoTableViewCell"];
        cell.selectionStyle = NO;
    }
    
    cell.titleLabel.text = title;
    cell.textField.placeholder = placeHolderString;
    
    [cell resetTextFieldWithType:type];
    return cell;
}

- (void)resetTextFieldWithType: (NSInteger)type {
    if (type == 0) {
        self.nextImageV.hidden = 1;
    }
    if (type == 1) {
        self.nextImageV.hidden = 1;
        self.textField.textAlignment = NSTextAlignmentLeft;
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(SCREEN_WIDTH-85);
        }];
    }
    if (type == 2) {
        self.nextImageV.hidden = 0;
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-40);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
        }];
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [UILabel labelWithTextColor:WordDeepGray font:15 aligment:NSTextAlignmentLeft];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(21);
        }];
        
        self.textField = [[UITextField alloc]init];
        self.textField.backgroundColor = [UIColor whiteColor];
        self.textField.textColor = [UIColor blackColor];
        self.textField.font = [UIFont systemFontOfSize:16];
//        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.textField.textAlignment = NSTextAlignmentRight;
//        self.textField.tintColor = [UIColor blackColor];
        [self addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
        }];
        
        self.nextImageV = [[UIImageView alloc]initWithImage:GetImage(@"youjaintou")];
        [self addSubview:self.nextImageV];
        [self.nextImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(5, 10));
        }];
        
        
        
    }
    return self;
}


@end
