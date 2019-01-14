//
//  AddressPickerView.h
//  XinYiFu
//
//  Created by apple on 2019/1/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AddressViewDelegate <NSObject>

- (void)completingTheSelection:(NSString *)province city:(NSString *)city area:(NSString *)area;//完成选择

@end


@interface AddressPickerView : UIView
+ (void)showWithData:(NSArray *)array delegate:(id<AddressViewDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
