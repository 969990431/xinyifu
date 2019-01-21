//
//  GradeModel.h
//  XinYiFu
//
//  Created by apple on 2019/1/18.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GradeModel : JSONModel
@property (nonatomic, copy)NSString *level;
@property (nonatomic, copy)NSString *tax;
@end

NS_ASSUME_NONNULL_END
