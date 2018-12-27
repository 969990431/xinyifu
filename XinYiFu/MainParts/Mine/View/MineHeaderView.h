//
//  MineHeaderView.h
//  XinYiFu
//
//  Created by apple on 2018/12/27.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ClickCallBack)();

@interface MineHeaderView : UIView
+ (instancetype)mineHeaderViewWithSetClick: (ClickCallBack)setClick userCenterClick: (ClickCallBack)userCenterClick messageCenter: (ClickCallBack)messageCenterClick;
@end

NS_ASSUME_NONNULL_END
