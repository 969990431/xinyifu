//
//  SelectProvinceViewController.h
//  XinYiFu
//
//  Created by apple on 2019/1/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^ProvinceIdBlock)(NSString *name, NSString *pId);
@interface SelectProvinceViewController : BaseViewController
@property (nonatomic, copy)ProvinceIdBlock callBack;
@end

NS_ASSUME_NONNULL_END
