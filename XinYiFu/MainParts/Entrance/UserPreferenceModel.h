//
//  UserPreferenceModel.h
//  XinYiFu
//
//  Created by apple on 2018/12/29.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserPreferenceModel : NSObject
+ (instancetype)shareManager;
- (void)loginOut;

@property (nonatomic, assign)BOOL guideViewHidden;//是否显示引导页
@property (nonatomic, copy)NSString *token;//用户token

@property (nonatomic, copy)NSString *account;
@property (nonatomic, copy)NSString *password;

@property (nonatomic, copy)NSString *logo;//企业头像
@property (nonatomic, copy)NSString *picUrl;//个人头像
@property (nonatomic, copy)NSString *name;//店铺名称
@property (nonatomic, copy)NSString *mobile;//手机号
@property (nonatomic, copy)NSString *userName;//用户姓名
@property (nonatomic, copy)NSString *cashQr;//门店首款码
@property (nonatomic, copy)NSString *agreementStatus;//认证状态：1未认证 2审核中 3审核失败 4认证成功

@end

