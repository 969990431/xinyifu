//
//  EditInfoTableViewCell.h
//  XinYiFu
//
//  Created by apple on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol EditInfoTableViewCellDelegate <NSObject>



@end
@interface EditInfoTableViewCell : UITableViewCell


/**
 <#Description#>

 @param tableView <#tableView description#>
 @param indexPath <#indexPath description#>
 @param delegate <#delegate description#>
 @param type  0 输入框右对齐 1 输入框左对齐 2 可跳转
 
 @param title <#title description#>
 @param placeHolderString <#placeHolderString description#>
 @return <#return value description#>
 */
+ (instancetype)cellWithTableView: (UITableView *)tableView indexPath: (NSIndexPath *)indexPath delegate: (id<EditInfoTableViewCellDelegate>)delegate type: (NSInteger)type title: (NSString *)title placeHolder: (NSString *)placeHolderString;

@property (nonatomic, strong)UITextField *textField;
@end

NS_ASSUME_NONNULL_END
