//
//  MoneyDetailCell.h
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoneyDetailCell : UITableViewCell
+ (instancetype)cellWithTableView: (UITableView *)tableView indexPath: (NSIndexPath *)indexPath time:(NSString *)time totalMoney:(NSString *)totalMoney fee:(NSString *)fee actualMoney:(NSString *)actualMoney;
@end

NS_ASSUME_NONNULL_END
