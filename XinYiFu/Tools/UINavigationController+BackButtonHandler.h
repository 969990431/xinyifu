//
//  UINavigationController+BackButtonHandler.h
//  GoldenCatLottery
//
//  Created by Aron on 2017/9/11.
//  Copyright © 2017年 Aron. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BackButtonHandlerProtocol <NSObject>
@optional
// 重写下面的方法以拦截导航栏返回按钮点击事件，返回 YES 则 pop，NO 则不 pop
-(BOOL)navigationShouldPopOnBackButton;
@end
@interface UIViewController (BackButtonHandler)<BackButtonHandlerProtocol>

@end
