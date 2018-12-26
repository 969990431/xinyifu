//
//  RGBColors.h
//  GoldenCatLottery
//
//  Created by Aron on 2017/6/26.
//  Copyright © 2017年 Aron. All rights reserved.
//

#ifndef RGBColors_h
#define RGBColors_h

#define UIColorFromRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
//#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//背景灰色
#define BackGrayColor UIColorFromRGB(248, 248, 248)
//字体灰色
#define WordGray UIColorFromRGB(190,192,192)
//字体深灰色
#define WordDeepGray UIColorFromRGB(102,102,102)
//字体红色
#define WordRed UIColorFromRGB(207,2,26)
//字体橙色
#define WordOrange UIColorFromRGB(240,77,26)
//分割线
#define SegGray UIColorFromRGB(244, 244, 244)
//字体绿色
#define WordGreen UIColorFromRGB(20,194,193)
//提示字体灰色
#define AlertGray UIColorFromRGB(153,153,153)
//字体近黑色
#define WordCloseBlack UIColorFromRGB(51,51,51)
//tab红色
#define TabRed UIColorFromRGB(208,2,27)
//tab灰色
#define TabGray UIColorFromRGB(102,102,102)
//tab橙色
#define FingerOrange UIColorFromRGB(245,156,19)
//认证状态
#define StatusOrange UIColorFromRGB(248,126,53)
//

#endif /* RGBColors_h */
