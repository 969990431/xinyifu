//
//  UserPreferenceModel.m
//  XinYiFu
//
//  Created by apple on 2018/12/29.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UserPreferenceModel.h"
#import "LoginViewController.h"
#import "NavViewController.h"

@implementation UserPreferenceModel
+ (instancetype)shareManager {
    static UserPreferenceModel *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[UserPreferenceModel alloc]init];
    });
    return model;
}
- (void)loginOut {
    self.token = nil;
    
    
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = [[NavViewController alloc]initWithRootViewController:loginVC];
}
//引导页隐藏属性
- (void)setGuideViewHidden:(BOOL)guideViewHidden {
    [self saveObjWithKey:@"guideHidden" andValue:[NSString stringWithFormat:@"%d", guideViewHidden]];
}
- (BOOL)guideViewHidden {
    return [[self getObjWithKey:@"guideHidden"]boolValue];
}

//用户token
- (void)setToken:(NSString *)token {
    [self archiveString:token withKey:@"token"];
}
- (NSString *)token {
    return [self unArchiveWithKey:@"token"];
}

- (void)setAccount:(NSString *)account {
    [self archiveString:account withKey:@"account"];
}
- (NSString *)account {
    return [self unArchiveWithKey:@"account"];
}

- (void)setPassword:(NSString *)password {
    [self archiveString:password withKey:@"password"];
}
- (NSString *)password {
    return [self unArchiveWithKey:@"password"];
}


- (void)setName:(NSString *)name {
    [self archiveString:name withKey:@"name"];
}
- (NSString *)name {
    return [self unArchiveWithKey:@"name"];
}

- (void)setMobile:(NSString *)mobile {
    [self archiveString:mobile withKey:@"mobile"];
}
- (NSString *)mobile {
    return [self unArchiveWithKey:@"mobile"];
}

- (void)setUserName:(NSString *)userName {
    [self archiveString:userName withKey:@"userName"];
}
- (NSString *)userName {
    return [self unArchiveWithKey:@"userName"];
}

- (void)setCashQr:(NSString *)cashQr {
    [self archiveString:cashQr withKey:@"cashQr"];
}
-(NSString *)cashQr {
    return [self unArchiveWithKey:@"cashQr"];
}


//存入字符串
- (void)archiveString:(NSString *)str withKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//取出字符串
- (NSString *)unArchiveWithKey: (NSString *)key {
    NSString *value = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    return value;
}

//存入对象
- (void)saveObjWithKey:(NSString *)key andValue:(NSObject *)value{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[value copy]];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//取出对象
- (id)getObjWithKey:(NSString *)key{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
@end
