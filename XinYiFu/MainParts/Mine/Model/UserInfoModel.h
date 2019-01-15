//
//  UserInfoModel.h
//  XinYiFu
//
//  Created by apple on 2019/1/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : JSONModel
@property (nonatomic, copy)NSString *handPic;
@property (nonatomic, copy)NSString *arrive;
@property (nonatomic, copy)NSString *bankName;
@property (nonatomic, copy)NSString *cardNo;
@end

NS_ASSUME_NONNULL_END
