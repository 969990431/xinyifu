//
//  UserInfoTableViewCell.h
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView: (UITableView *)tableView indexPath: (NSIndexPath *)indexPath dic: (UserInfoModel *)dic;
@end

NS_ASSUME_NONNULL_END
