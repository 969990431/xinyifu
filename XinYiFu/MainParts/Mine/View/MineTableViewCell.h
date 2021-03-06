//
//  MineTableViewCell.h
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView: (UITableView *)tableView indexPath: (NSIndexPath *)indexPath imageName: (NSString *)imageName title: (NSString *)title;
@end

NS_ASSUME_NONNULL_END
