//
//  NSString+MD5.m
//  XiangShengManage_iOS
//
//  Created by Aron on 17/3/9.
//  Copyright © 2017年 XSService. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (MD5)
+ (NSString *)stringToMD5:(NSString *)str {
    const char *fooData = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    NSMutableString *saveResult = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    return saveResult;
}
@end
