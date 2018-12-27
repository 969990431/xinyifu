//
//  IncomeRecordContentCell.h
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IncomeRecordContentCell : UITableViewCell
+ (instancetype)cellWithTableView: (UITableView *)tableView indexPath: (NSIndexPath *)indexPath name:(NSString *)name time:(NSString *)time money:(NSString *)money;
@end

NS_ASSUME_NONNULL_END
