//
//  MessageListModel.h
//  XinYiFu
//
//  Created by apple on 2019/1/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageListModel : JSONModel
@property (nonatomic, copy)NSString *messageId;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *createTime;
@property (nonatomic, assign)NSInteger isRead;

@end

NS_ASSUME_NONNULL_END
