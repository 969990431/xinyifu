//
//  AddressCell.h
//  XinYiFu
//
//  Created by apple on 2019/1/7.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressCell : UITableViewCell
+ (instancetype)cellWithTableView: (UITableView *)tableView indexPath: (NSIndexPath *)indexPath name:(NSString *)name phoneNum:(NSString *)phoneNum address:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
