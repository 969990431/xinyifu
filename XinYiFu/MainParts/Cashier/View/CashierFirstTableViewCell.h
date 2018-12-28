//
//  CashierFirstTableViewCell.h
//  XinYiFu
//
//  Created by apple on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CashierFirstTableViewCellDelegate <NSObject>
- (void)clickTheHeader;
- (void)authenWithType: (NSInteger)type;

- (void)setMoney;
- (void)savePic;
- (void)gotoRecord;

@end

@interface CashierFirstTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView: (UITableView *)tableView indexPath: (NSIndexPath *)indexPath type: (NSInteger)type delegate: (id<CashierFirstTableViewCellDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
