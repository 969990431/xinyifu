//
//  AppDelegate.m
//  XinYiFu
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabViewController.h"
#import "LoginViewController.h"
#import "NavViewController.h"
#import "BDSSpeechSynthesizer.h"
#import <AVFoundation/AVFoundation.h>
#import "GuideViewController.h"

#import <UMCommon/UMCommon.h>
#import <UMPush/UMessage.h>
#import <UserNotifications/UserNotifications.h>

#define UMAppKey @"5c36afe5b465f50b26000d7c"


@interface AppDelegate ()<BDSSpeechSynthesizerDelegate,UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

-(void)configureBDS{
    //    [BDSSpeechSynthesizer setLogLevel:BDS_PUBLIC_LOG_VERBOSE];
    [[BDSSpeechSynthesizer sharedInstance] setSynthesizerDelegate:self];
    
    //configureOnlineTTS
    [[BDSSpeechSynthesizer sharedInstance] setApiKey:@"rAhdMLuyaoEMxGwRfGaTMINK" withSecretKey:@"Adb5QnVZTU4vWUXPpWPNPPypjrN4eVes"];
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //configureOfflineTTS
    NSError *err = nil;
    // 在这里选择不同的离线音库（请在XCode中Add相应的资源文件），同一时间只能load一个离线音库。根据网络状况和配置，SDK可能会自动切换到离线合成。
    NSString* offlineEngineSpeechData = [[NSBundle mainBundle] pathForResource:@"Chinese_And_English_Speech_Female" ofType:@"dat"];
    
    NSString* offlineChineseAndEnglishTextData = [[NSBundle mainBundle] pathForResource:@"Chinese_And_English_Text" ofType:@"dat"];
    
    err = [[BDSSpeechSynthesizer sharedInstance] loadOfflineEngine:offlineChineseAndEnglishTextData speechDataPath:offlineEngineSpeechData licenseFilePath:nil withAppCode:@"15260621"];
    if(err){
        //        [self displayError:err withTitle:@"Offline TTS init failed"];
        return;
    }
}

- (void)playVideo{
    NSAttributedString* string = [[NSAttributedString alloc] initWithString:@"薪易付已到账1.23元"];
    NSError* err = nil;
    [[BDSSpeechSynthesizer sharedInstance] speakSentence:[string string] withError:&err];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = [UIColor whiteColor];
    [NSThread sleepForTimeInterval:2.0];
    
    // 配置友盟SDK产品并并统一初始化
    
    [UMConfigure initWithAppkey:UMAppKey channel:@"App Store"];
    
    // Push组件基本功能配置
    
    [UNUserNotificationCenter currentNotificationCenter].delegate= self;
    
    UMessageRegisterEntity* entity = [[UMessageRegisterEntity alloc] init];
    
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标等
    
    entity.types= UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert;
    
    [UNUserNotificationCenter currentNotificationCenter].delegate= self;
    
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError* _Nullableerror) {
        
        if(granted) {
            
            // 用户选择了接收Push消息
        }else{
            // 用户拒绝接收Push消息
        }
    }];
    
    [self configureBDS];
    
//    [self playVideo];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    
    if ([UserPreferenceModel shareManager].guideViewHidden == 0) {
        [UserPreferenceModel shareManager].guideViewHidden = 1;
        self.window.rootViewController = [[GuideViewController alloc]init];
    }else {
        self.window.rootViewController = [[MainTabViewController alloc]init];
    }
    
    // Override point for customization after application launch.
    return YES;
}


/************************************************推送**************************************************/

//iOS10以下使用这两个方法接收通知，
-(void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo fetchCompletionHandler:(void(^)(UIBackgroundFetchResult))completionHandler

{
    [self configureBDS];
    [[BDSSpeechSynthesizer sharedInstance] speakSentence:userInfo[@"aps"][@"alert"][@"body"] withError:nil];
    
    [UMessage setAutoAlert:NO];
    //统计点击数
    [UMessage didReceiveRemoteNotification:userInfo];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
        completionHandler(UIBackgroundFetchResultNewData);
    }
    
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter*)center willPresentNotification:(UNNotification*)notification withCompletionHandler:(void(^)(UNNotificationPresentationOptions))completionHandler{
    
    NSDictionary* userInfo = notification.request.content.userInfo;
    NSLog(@"====%@", userInfo);
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        //应用处于前台时的远程推送接受
        
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:YES];
        //（前台、后台）的消息处理
        [UMessage didReceiveRemoteNotification:userInfo];
//        [[BDSSpeechSynthesizer sharedInstance] speakSentence:userInfo[@"aps"][@"alert"][@"body"] withError:nil];
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSDictionary* userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        //应用处于后台时的远程推送接受
        
        //（前台、后台）的消息处理
        [UMessage didReceiveRemoteNotification:userInfo];
        if(userInfo.count>0){
            //消息处理
            NSLog(@"跳转到你想要的");
        }
    }
    else{ //应用处于后台时的本地推送接受
        
    }
    
}

//打印设备注册码，需要在友盟测试设备上自己添加deviceToken
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken

{
    
    [UMessage registerDeviceToken:deviceToken];
    
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken success");
    
    NSLog(@"deviceToken————>>>%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<"withString: @""]stringByReplacingOccurrencesOfString: @">"withString: @""]stringByReplacingOccurrencesOfString: @" "withString: @""]);
    
    [UserPreferenceModel shareManager].deviceToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<"withString: @""]stringByReplacingOccurrencesOfString: @">"withString: @""]stringByReplacingOccurrencesOfString: @" "withString: @""];
    
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
