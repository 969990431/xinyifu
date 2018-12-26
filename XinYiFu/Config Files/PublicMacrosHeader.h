
//
//  PublicMacrosHeader.h
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//

#ifndef PublicMacrosHeader_h
#define PublicMacrosHeader_h

//屏幕的宽高
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height

//判断字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]) || ([(_ref) isEqual:@"<null>"])|| ([(_ref) isEqual:@"(null)"]))

//iPhoneX系列判断
#define iPhoneX (((SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812) || (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 896))? YES:NO)
//获取等比尺寸
#define GetFloatWithPXSIX(pxValue) pxValue/375.0*SCREEN_WIDTH
#define GetFloatWithHightPXSIX(pxValue) pxValue/667.0*SCREEN_HEIGHT

// 防止多次调用
#define kPreventRepeatClickTime(_seconds_) \
static BOOL shouldPrevent; \
if (shouldPrevent) return; \
shouldPrevent = YES; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_seconds_) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
shouldPrevent = NO; \
}); \

//获取图片资源
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
//隐藏tabbar
#define hiddenTabBarWhenPush(pushAction) self.hidesBottomBarWhenPushed = YES;pushAction;self.hidesBottomBarWhenPushed = NO;


#define DEBUGGER 1 //上线版本屏蔽此宏
#ifdef DEBUGGER
/* 自定义log 可以输出所在的类名,方法名,位置(行数)*/
#define VDLog(format, ...) NSLog((@"%s [Line %d] " format), __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define VDLog(...)
#endif



#endif /* PublicMacrosHeader_h */
