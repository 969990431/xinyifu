//
//  UserPreferenceModel.h
//  XinYiFu
//
//  Created by apple on 2018/12/29.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserPreferenceModel : NSObject
+ (instancetype)shareManager;
- (void)loginOut;

@property (nonatomic, assign)BOOL guideViewHidden;//是否显示引导页
@property (nonatomic, copy)NSString *token;//用户token

@property (nonatomic, copy)NSString *account;
@property (nonatomic, copy)NSString *password;
@end

NS_ASSUME_NONNULL_END
