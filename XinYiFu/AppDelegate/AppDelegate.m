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


@interface AppDelegate ()<BDSSpeechSynthesizerDelegate>

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
    
    [self configureBDS];
    
    [self playVideo];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    if ([UserPreferenceModel shareManager].token) {
        self.window.rootViewController = [[MainTabViewController alloc]init];
    }else {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        self.window.rootViewController = [[NavViewController alloc]initWithRootViewController:loginVC];
    }
    
    // Override point for customization after application launch.
    return YES;
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
