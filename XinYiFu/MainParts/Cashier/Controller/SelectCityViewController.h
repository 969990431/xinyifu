//
//  SelectCityViewController.h
//  XinYiFu
//
//  Created by apple on 2019/1/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^CityBlock)(NSString *);
@interface SelectCityViewController : BaseViewController
@property (nonatomic, copy)NSString *pId;
@property (nonatomic, copy)CityBlock callBack;
@end

NS_ASSUME_NONNULL_END
