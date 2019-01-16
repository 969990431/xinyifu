//
//  SetMoneyViewController.h
//  XinYiFu
//
//  Created by apple on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^GetErweimaBlock)(NSString *erweimaUrl, NSString *money, UIImage *erweimaImage, NSString *remark);
@interface SetMoneyViewController : BaseViewController
@property (nonatomic, copy)GetErweimaBlock erweimaCallBack;
@end

NS_ASSUME_NONNULL_END
