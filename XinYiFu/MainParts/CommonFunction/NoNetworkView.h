//
//  NoNetworkView.h
//  XinYiFu
//
//  Created by apple on 2018/12/29.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NoNetworkViewDelegate <NSObject>
- (void)refreshData;
@end


@interface NoNetworkView : UIView
+ (void)showWithDelegate:(id<NoNetworkViewDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
