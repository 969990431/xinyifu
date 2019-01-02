//
//  BaseResponse.h
//  GoldenCatLottery
//
//  Created by Aron on 2017/6/26.
//  Copyright © 2017年 Aron. All rights reserved.
//
#import <JSONModel/JSONModel.h>

@interface BaseResponse : JSONModel
/**
 *  错误码 1成功 0失败
 */
@property (nonatomic, strong)NSString *code;
/**
 *  错误信息
 */
@property (nonatomic, strong)NSString *msg;

@end
