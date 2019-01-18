//
//  CashierFirstTableViewCell.m
//  XinYiFu
//
//  Created by apple on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CashierFirstTableViewCell.h"

@interface CashierFirstTableViewCell ()
@property (nonatomic, assign)id<CashierFirstTableViewCellDelegate>delegate;
@property (nonatomic, assign)NSInteger authenType;

@property (nonatomic, strong)UIView *backView;

@property (nonatomic, strong)UIImageView *headerImageV;
@property (nonatomic, strong)UILabel *statusLabel;
@property (nonatomic, strong)UILabel *titlelabel;
@property (nonatomic, strong)UIView *orangeV;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UILabel *fingerLabel;

@property (nonatomic, strong)UIImageView *erweimaImageV;
@property (nonatomic, strong)UIButton *setMoneyBtn;
@property (nonatomic, strong)UILabel *middleSepLine;
@property (nonatomic, strong)UIButton *saveErweimaBtn;

@property (nonatomic, strong)UILabel *moneyLabel;
@property (nonatomic, strong)UILabel *moneyTextLabel;

@property (nonatomic, strong)UIView *shoukuanView;

@property (nonatomic, strong)UIImageView *gerenImageV;
@property (nonatomic, strong)UILabel *gerenLabel;
@property (nonatomic, strong)UIImageView *qiyeImageV;
@property (nonatomic, strong)UILabel *qiyeLabel;
@property  (nonatomic, strong)UIButton *gerenBtn;
@property (nonatomic, strong)UIButton * qiyeBtn;
@property (nonatomic, strong)UIButton *sureBtn;

@property (nonatomic, strong)UIImageView *shenhezhongImageV;
@property (nonatomic, strong)UILabel *bottomContentLabel;

@end
@implementation CashierFirstTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath type:(NSInteger)type delegate:(nonnull id<CashierFirstTableViewCellDelegate>)delegate erweimaUrl:(nonnull NSString *)url money:(nonnull NSString *)money erweimaImage:(nonnull UIImage *)erweimaImage remark:(nonnull NSString *)remark{
    CashierFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CashierFirstTableViewCell" ];
    if (!cell) {
        cell = [[CashierFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CashierFirstTableViewCell"];
        cell.selectionStyle = NO;
    }
    cell.delegate = delegate;

    if (type == 5) {
        [cell.setMoneyBtn setTitle:@"取消金额" forState:UIControlStateNormal];
        cell.backView.frame = CGRectMake(20, 113, SCREEN_WIDTH-40, 538);
        [cell.middleSepLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(cell);
            make.top.mas_equalTo(cell.erweimaImageV.mas_bottom).offset(93);
            make.size.mas_equalTo(CGSizeMake(1, 17));
        }];
        cell.moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f", money.floatValue];
        [cell.erweimaImageV sd_setImageWithURL:[NSURL URLWithString:url]];
    }else {
        [cell.setMoneyBtn setTitle:@"设置金额" forState:UIControlStateNormal];
        cell.backView.frame = CGRectMake(20, 113, SCREEN_WIDTH-40, 449);
        [cell.middleSepLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(cell);
            make.top.mas_equalTo(cell.erweimaImageV.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(1, 17));
        }];
    }
    [cell.headerImageV sd_setImageWithURL:[NSURL URLWithString:[UserPreferenceModel shareManager].logo ? [UserPreferenceModel shareManager].logo : [UserPreferenceModel shareManager].picUrl] placeholderImage:GetImage(@"touxiang")];
    cell.titlelabel.text = [UserPreferenceModel shareManager].name;
    cell.contentLabel.text = [NSString stringWithFormat:@"%@  %@", [UserPreferenceModel shareManager].userName, [UserPreferenceModel shareManager].mobile];
    
    
//    cell.moneyLabel.text = @"123123";
    
    if (erweimaImage) {
        [cell.erweimaImageV setImage:erweimaImage];
    }else {
        [cell.erweimaImageV sd_setImageWithURL:[NSURL URLWithString:[UserPreferenceModel shareManager].cashQr]];
    }
    
    if (remark) {
        cell.moneyTextLabel.text = remark;
    }else {
//        cell.moneyTextLabel.text = @"备注";
    }
    
    
    [cell setType:type];
    
    
    return cell;
}

- (void)setType:(NSInteger)type {
    if (type == 4) {
        //        已认证，可以扫码
        self.fingerLabel.text = @"扫一扫，向我付款";
        self.statusLabel.backgroundColor = StatusOrange;
        self.statusLabel.text = @"已认证";
//        self.titlelabel.text = @"";
//        self.contentLabel.text = @"";
        
        self.erweimaImageV.hidden = 0;
        self.setMoneyBtn.hidden = 0;
        self.middleSepLine.hidden = 0;
        self.saveErweimaBtn.hidden = 0;
        self.shoukuanView.hidden = 0;
        
        self.gerenLabel.hidden = 1;
        self.gerenImageV.hidden = 1;
        self.qiyeLabel.hidden = 1;
        self.qiyeImageV.hidden = 1;
        self.sureBtn.hidden = 1;
        
        self.shenhezhongImageV.hidden = 1;
        self.bottomContentLabel.hidden = 1;
        
        self.moneyLabel.hidden = 1;
        self.moneyTextLabel.hidden = 1;
        
    }else if (type == 0) {
        //        未认证
        self.fingerLabel.text = @"选择身份认证";
        self.statusLabel.backgroundColor = AlertGray;
        self.statusLabel.text = @"未认证";
        self.titlelabel.text = @"您尚未实名认证";
        self.contentLabel.text = @"只有认证才可以收钱哦！";
        
        self.erweimaImageV.hidden = 1;
        self.setMoneyBtn.hidden = 1;
        self.middleSepLine.hidden = 1;
        self.saveErweimaBtn.hidden = 1;
        self.shoukuanView.hidden = 1;
        
        self.gerenLabel.hidden = 0;
        self.gerenImageV.hidden = 0;
        self.qiyeLabel.hidden = 0;
        self.qiyeImageV.hidden = 0;
        self.sureBtn.hidden = 0;
        
        self.shenhezhongImageV.hidden = 1;
        self.bottomContentLabel.hidden = 1;
        
        self.moneyLabel.hidden = 1;
        self.moneyTextLabel.hidden = 1;
    }else if (type == 2 || type == 1) {
        //        审核中
        self.fingerLabel.text = @"正在审核中…";
        self.statusLabel.backgroundColor = AlertGray;
        self.statusLabel.text = @"未认证";
        self.titlelabel.text = @"您尚未实名认证";
        self.contentLabel.text = @"只有认证才可以收钱哦！";
        
        self.erweimaImageV.hidden = 1;
        self.setMoneyBtn.hidden = 1;
        self.middleSepLine.hidden = 1;
        self.saveErweimaBtn.hidden = 1;
        self.shoukuanView.hidden = 1;
        
        self.gerenLabel.hidden = 1;
        self.gerenImageV.hidden = 1;
        self.qiyeLabel.hidden = 1;
        self.qiyeImageV.hidden = 1;
        self.sureBtn.hidden = 1;
        
        self.shenhezhongImageV.hidden = 0;
        self.bottomContentLabel.hidden = 0;
        
        self.moneyLabel.hidden = 1;
        self.moneyTextLabel.hidden = 1;
    }else if (type == 3) {
        //        e审核失败
        self.fingerLabel.text = @"审核失败";
        self.statusLabel.backgroundColor = AlertGray;
        self.statusLabel.text = @"未认证";
        self.titlelabel.text = @"您尚未实名认证";
        self.contentLabel.text = @"只有认证才可以收钱哦！";
        
        self.bottomContentLabel.attributedText = [[NSString stringWithFormat:@"您认证的信息有误，导致认证失败，可先联系客服%@或者重新选择身份认证", [UserPreferenceModel shareManager].kefudianhua]changeColor:UIColorFromRGB(51, 51, 51) andColorRang:NSMakeRange(22, [UserPreferenceModel shareManager].kefudianhua.length+10) andFont:[UIFont systemFontOfSize:16] andFontRange:NSMakeRange(22, [UserPreferenceModel shareManager].kefudianhua.length+10)];
        
        self.erweimaImageV.hidden = 1;
        self.setMoneyBtn.hidden = 1;
        self.middleSepLine.hidden = 1;
        self.saveErweimaBtn.hidden = 1;
        self.shoukuanView.hidden = 1;
        
        self.gerenLabel.hidden = 0;
        self.gerenImageV.hidden = 0;
        self.qiyeLabel.hidden = 0;
        self.qiyeImageV.hidden = 0;
        self.sureBtn.hidden = 0;
        [self.sureBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.orangeV);
            make.top.mas_equalTo(self.orangeV.mas_bottom).offset(137);
            make.height.mas_equalTo(40);
        }];
        
        self.shenhezhongImageV.hidden = 1;
        self.bottomContentLabel.hidden = 0;
        
        self.moneyLabel.hidden = 1;
        self.moneyTextLabel.hidden = 1;
    }else {
        //        有二维码，有金额
        self.erweimaImageV.hidden = 0;
        self.setMoneyBtn.hidden = 0;
//        [self.setMoneyBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.middleSepLine);
//            make.height.mas_equalTo(20);
//            make.centerX.mas_equalTo(self.erweimaImageV);
//            make.width.mas_equalTo(self.erweimaImageV);
//        }];
        self.middleSepLine.hidden = 1;
        self.saveErweimaBtn.hidden = 1;
        self.shoukuanView.hidden = 0;
        
        self.gerenLabel.hidden = 1;
        self.gerenImageV.hidden = 1;
        self.qiyeLabel.hidden = 1;
        self.qiyeImageV.hidden = 1;
        self.sureBtn.hidden = 1;
        
        self.shenhezhongImageV.hidden = 1;
        self.bottomContentLabel.hidden = 1;
        
        self.moneyLabel.hidden = 0;
        self.moneyTextLabel.hidden = 0;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.backView = [[UIView alloc]init];
        self.backView.frame = CGRectMake(20, 113, SCREEN_WIDTH-40, 538);
        [self addSubview:self.backView];
        
        self.backView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
        self.backView.layer.masksToBounds = 1;
        self.backView.layer.cornerRadius = 10;
        
            self.headerImageV = [[UIImageView alloc]init];
            [self.headerImageV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:GetImage(@"touxiang")];
            self.headerImageV.layer.masksToBounds = 1;
            self.headerImageV.layer.cornerRadius = 50;
            self.headerImageV.layer.borderColor = [UIColor whiteColor].CGColor;
            self.headerImageV.layer.borderWidth = 2;
        self.headerImageV.userInteractionEnabled = 1;
            [self addSubview:self.headerImageV];
//            self.headerImageV.backgroundColor = RandomColor;
            [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self);
                make.bottom.mas_equalTo(self.backView.mas_top).offset(50);
                make.size.mas_equalTo(100);
            }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeader)];
        [self.headerImageV addGestureRecognizer:tap];
        
        self.statusLabel = [UILabel labelWithTextColor:[UIColor whiteColor] font:13 aligment:NSTextAlignmentCenter];
        self.statusLabel.layer.cornerRadius = 3;
        self.statusLabel.layer.masksToBounds = YES;
//        self.statusLabel.text = @"sdjfljsdlkf";
//        self.statusLabel.backgroundColor = RandomColor;
        [self.backView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(10);
            make.width.mas_equalTo(65);
            make.height.mas_equalTo(20);
        }];
        
        self.titlelabel = [UILabel labelWithTextColor:UIColorFromRGB(51, 51, 51) font:18 aligment:NSTextAlignmentCenter];
//        self.titlelabel.text = @"12312319";
        [self.backView addSubview:self.titlelabel];
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(self.statusLabel.mas_bottom).offset(25);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(25);
        }];
        
        
        self.contentLabel = [UILabel labelWithTextColor:WordDeepGray font:15 aligment:NSTextAlignmentCenter];
//        self.contentLabel.text = @"1231231";
        [self.backView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(self.statusLabel.mas_bottom).offset(57);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(21);
            
        }];
        
        self.orangeV = [[UIView alloc]init];
        self.orangeV.layer.masksToBounds = 1;
        self.orangeV.layer.cornerRadius = 17.5;
        self.orangeV.backgroundColor = UIColorFromRGB(245,156,19);
        [self.backView addSubview:self.orangeV];
        [self.orangeV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(68);
            make.right.mas_equalTo(-68);
            make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(16);
            make.height.mas_equalTo(35);
        }];
        
        UIImageView *fingerImageV = [[UIImageView alloc]initWithImage:GetImage(@"shouzhi")];
        [self.orangeV addSubview:fingerImageV];
        [fingerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(9);
            make.centerY.mas_equalTo(self.orangeV);
            make.size.mas_equalTo(CGSizeMake(18, 22));
        }];
        
        self.fingerLabel = [UILabel labelWithTextColor:[UIColor whiteColor] font:16 aligment:NSTextAlignmentCenter];
        [self.orangeV addSubview:self.fingerLabel];
        self.fingerLabel.text = @"扫一扫，向我付款";
        [self.fingerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(fingerImageV.mas_right).offset(3);
            make.right.mas_equalTo(self.orangeV.mas_right).offset(-10);
            make.centerY.mas_equalTo(self.orangeV);
            make.height.mas_equalTo(20);
        }];
        
        self.erweimaImageV = [[UIImageView alloc]init];
//        self.erweimaImageV.backgroundColor = RandomColor;
        [self.backView addSubview:self.erweimaImageV];
        [self.erweimaImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.orangeV.mas_bottom).offset(10);
            make.centerX.mas_equalTo(self);
            make.height.mas_equalTo(186);
            make.width.mas_equalTo(190);
        }];
        
        self.moneyLabel = [UILabel labelWithTextColor:[UIColor blackColor] font:24 aligment:NSTextAlignmentCenter];
        [self.backView addSubview:self.moneyLabel];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.erweimaImageV.mas_bottom).offset(5);
            make.height.mas_equalTo(33);
        }];
        
        self.moneyTextLabel = [UILabel labelWithTextColor:WordGray font:14 aligment:NSTextAlignmentCenter];
        [self.backView addSubview:self.moneyTextLabel];
        [self.moneyTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(self.moneyLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(30);
        }];
        
        self.middleSepLine = [[UILabel alloc]init];
        self.middleSepLine.backgroundColor = WordGray;
        [self.backView addSubview:self.middleSepLine];
        [self.middleSepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.erweimaImageV.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(1, 17));
        }];
        
        self.setMoneyBtn = [UIButton buttonWithTitle:@"设置金额" font:14 titleColor:WordGreen backGroundColor:nil aligment:UIControlContentHorizontalAlignmentLeft];
        [self.setMoneyBtn addTarget:self action:@selector(setMoneyClick) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:self.setMoneyBtn];
        [self.setMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.erweimaImageV);
            make.top.mas_equalTo(self.middleSepLine);
            make.right.mas_equalTo(self.middleSepLine.mas_left);
            make.height.mas_equalTo(20);
        }];
        
        self.saveErweimaBtn = [UIButton buttonWithTitle:@"保存收款码" font:14 titleColor:WordGreen backGroundColor:nil aligment:UIControlContentHorizontalAlignmentRight];
        [self.saveErweimaBtn addTarget:self action:@selector(savePicClick) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:self.saveErweimaBtn];
        [self.saveErweimaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.erweimaImageV);
            make.top.mas_equalTo(self.middleSepLine);
            make.left.mas_equalTo(self.middleSepLine.mas_right);
            make.height.mas_equalTo(20);
        }];
        
        self.shoukuanView = [[UIView alloc]init];
        //        self.shoukuanView.backgroundColor = RandomColor;
        [self.backView addSubview:self.shoukuanView];
        [self.shoukuanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.backView);
            make.height.mas_equalTo(47);
        }];
        
        UILabel *bottomLine = [[UILabel alloc]init];
        bottomLine.backgroundColor = SegGray;
        [self.shoukuanView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        UIImageView *shoukuanImageV = [[UIImageView alloc]initWithImage:GetImage(@"shoukuanjilu")];
        [self.shoukuanView addSubview:shoukuanImageV];
        [shoukuanImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.shoukuanView);
            make.left.mas_equalTo(self.shoukuanView.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(15, 20));
        }];
        
        UILabel *shoukuanLabel = [UILabel labelWithTextColor:UIColorFromRGB(51, 51, 51) font:15 aligment:NSTextAlignmentLeft];
        [self.shoukuanView addSubview:shoukuanLabel];
        shoukuanLabel.text = @"收款记录";
        [shoukuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(shoukuanImageV);
            make.left.mas_equalTo(shoukuanImageV.mas_right).offset(20);
            make.height.mas_equalTo(21);
        }];
        
        UIImageView *nextImageV = [[UIImageView alloc]initWithImage:GetImage(@"youjaintou")];
        [self.shoukuanView addSubview:nextImageV];
        [nextImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.backView).offset(-15);
            make.centerY.mas_equalTo(self.shoukuanView);
            make.size.mas_equalTo(CGSizeMake(5, 10));
        }];
        
        UIButton *shoukuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shoukuanBtn addTarget:self action:@selector(gotoRecordClick) forControlEvents:UIControlEventTouchUpInside];
//        shoukuanBtn.backgroundColor = RandomColor;
        [self.shoukuanView addSubview:shoukuanBtn];
        [shoukuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        self.gerenImageV = [[UIImageView alloc]initWithImage:GetImage(@"9已选择")];
        [self.backView addSubview:self.gerenImageV];
        [self.gerenImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.orangeV.mas_left);
            make.top.mas_equalTo(self.orangeV.mas_bottom).offset(36);
            make.size.mas_equalTo(13);
        }];
        
        self.gerenLabel = [UILabel labelWithTextColor:UIColorFromRGB(51, 51, 51) font:15 aligment:NSTextAlignmentLeft];
        self.gerenLabel.text = @"我是个人（没有营业执照）";
        [self.backView addSubview:self.gerenLabel];
        [self.gerenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.gerenImageV.mas_right).offset(20);
            make.centerY.mas_equalTo(self.gerenImageV);
            make.height.mas_equalTo(21);
        }];
        
        self.gerenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.gerenBtn.tag = 100;
        [self.gerenBtn addTarget:self action:@selector(selectRenzhengType:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:self.gerenBtn];
        [self.gerenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(self.gerenLabel);
            make.height.mas_equalTo(40);
        }];
        
        self.qiyeImageV = [[UIImageView alloc]initWithImage:GetImage(@"8未选择")];
        [self.backView addSubview:self.qiyeImageV];
        [self.qiyeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.orangeV.mas_left);
            make.top.mas_equalTo(self.orangeV.mas_bottom).offset(84);
            make.size.mas_equalTo(13);
        }];
        
        self.qiyeLabel = [UILabel labelWithTextColor:UIColorFromRGB(51, 51, 51) font:15 aligment:NSTextAlignmentLeft];
        self.qiyeLabel.text = @"我是企业（包括个体户）";
        [self.backView addSubview:self.qiyeLabel];
        [self.qiyeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.qiyeImageV.mas_right).offset(20);
            make.centerY.mas_equalTo(self.qiyeImageV);
            make.height.mas_equalTo(21);
        }];
        
        self.qiyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.qiyeBtn.tag = 101;
        [self.qiyeBtn addTarget:self action:@selector(selectRenzhengType:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:self.qiyeBtn];
        [self.qiyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(self.qiyeLabel);
            make.height.mas_equalTo(40);
        }];
        
        self.sureBtn = [UIButton buttonWithTitle:@"确定" font:18 titleColor:[UIColor whiteColor] backGroundColor:nil aligment:0];
        [self.sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        self.sureBtn.layer.masksToBounds = 1;
        self.sureBtn.layer.cornerRadius = 20;
        [self.sureBtn setBackgroundImage:GetImage(@"quedin") forState:UIControlStateNormal];
        [self.backView addSubview:self.sureBtn];
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.orangeV);
            make.top.mas_equalTo(self.orangeV.mas_bottom).offset(177);
            make.height.mas_equalTo(40);
        }];
        
        self.shenhezhongImageV = [[UIImageView alloc]initWithImage:GetImage(@"shenhezhong(1)")];
        [self.backView addSubview:self.shenhezhongImageV];
        [self.shenhezhongImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.orangeV.mas_bottom).offset(18);
            make.centerX.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(168, 157));
        }];
        
        self.bottomContentLabel = [UILabel labelWithTextColor:WordDeepGray font:14 aligment:NSTextAlignmentLeft];
        self.bottomContentLabel.numberOfLines = 0;
        [self.backView addSubview:self.bottomContentLabel];
        [self.bottomContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(35);
            make.right.mas_equalTo(-35);
            make.height.mas_equalTo(80);
            make.top.mas_equalTo(self.shenhezhongImageV.mas_bottom).offset(15);
        }];
        
        self.bottomContentLabel.attributedText = [[NSString stringWithFormat: @"您的认证信息正在审核中，三个工作日内给您回复，请您耐心等待！如有疑问请联系客服%@", [UserPreferenceModel shareManager].kefudianhua]changeColor:UIColorFromRGB(51, 51, 51) andColorRang:NSMakeRange(39, [UserPreferenceModel shareManager].kefudianhua.length) andFont:[UIFont systemFontOfSize:16] andFontRange:NSMakeRange(39, [UserPreferenceModel shareManager].kefudianhua.length)];
    }
    return self;
}

- (void)selectRenzhengType: (UIButton *)button {
    if (button.tag == 100) {
        [self.gerenImageV setImage:GetImage(@"9已选择")];
        [self.qiyeImageV setImage:GetImage(@"8未选择")];
        self.authenType = 0;
    }else {
        [self.gerenImageV setImage:GetImage(@"8未选择")];
        [self.qiyeImageV setImage:GetImage(@"9已选择")];
        self.authenType = 1;
    }
}

//选择认证方式，确定按钮，0:个人认证 1:企业认证
- (void)sureClick {
    if ([self.delegate respondsToSelector:@selector(authenWithType:)]) {
        [self.delegate authenWithType:self.authenType];
    }
}
//设置金额
- (void)setMoneyClick {
    if ([self.delegate respondsToSelector:@selector(setMoney)]) {
        [self.delegate setMoney];
    }
}
//保存首款码
- (void)savePicClick {
    if ([self.delegate respondsToSelector:@selector(savePic)]) {
        [self.delegate savePic];
    }
}
//收款记录
- (void)gotoRecordClick {
    if ([self.delegate respondsToSelector:@selector(gotoRecord)]) {
        [self.delegate gotoRecord];
    }
}



- (void)clickHeader {
    if ([self.delegate respondsToSelector:@selector(clickTheHeader)]) {
        [self.delegate clickTheHeader];
    }
}
@end
