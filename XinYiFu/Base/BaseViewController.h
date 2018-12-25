//
//  BaseViewController.h
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, naviType){
    type1 = 0,
    type2,
    type3,
    type4
};
@interface BaseViewController : UIViewController
@property (nonatomic, assign)naviType naviType;

@end

NS_ASSUME_NONNULL_END
