//
//  CashierStatusModel.h
//  XinYiFu
//
//  Created by apple on 2019/1/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CashierStatusModel : JSONModel
@property (nonatomic, copy)NSString *name;//店铺名称
@property (nonatomic, copy)NSString *mobile;//手机号
@property (nonatomic, copy)NSString *userName;//用户姓名
@property (nonatomic, copy)NSString *cashQr;//门店首款码
@property (nonatomic, copy)NSString *agreementStatus;//'审核状态：0 未认证  1：认证中 2：认证失败 3：认证成功',
@end

NS_ASSUME_NONNULL_END
