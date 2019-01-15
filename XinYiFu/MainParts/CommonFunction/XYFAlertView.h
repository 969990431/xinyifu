//
//  XYFAlertView.h
//  XinYiFu
//
//  Created by apple on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYFAlertView : UIView
@property (nonatomic ,copy) void (^block)(void);
+ (void)creatCallAlert;
+ (id)showAlertViewWithTitle:(NSString *)title content:(NSString *)content buttonTitle:(NSString *)buttonTitle;
@end

NS_ASSUME_NONNULL_END
