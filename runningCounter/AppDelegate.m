//
//  AppDelegate.m
//  runningCounter
//
//  Created by Longfatown on 1/20/15.
//  Copyright (c) 2015 Longfatown. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)ReOderBadgeNumber {
    //重新安排應用程式的按鈕的提示數字
    //查看目前剩餘的通知數
    NSArray *notifys = [[UIApplication sharedApplication] scheduledLocalNotifications];
    int index = 1;
    for (_notify in notifys) {
        
        _notify.applicationIconBadgeNumber = index; //安排新的badge number給每一筆資料
        
        [[UIApplication sharedApplication] scheduleLocalNotification:_notify]; //重新安排
        index++;
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //====== 裝置版本判斷，註冊LocalNotification
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
            [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil ]];
        }
    }
    //====== 裝置版本判斷
    
    //====== Parse
//    [Parse enableLocalDatastore];   //允許本地儲存
//    
//    // Initialize Parse(初始化)
//    [Parse setApplicationId:@"37sMr08M1ovb6en1nQ7mm6wMa0wZS9w8EBrb8203"
//                  clientKey:@"VPIfQhgqixZKALeTzbhIurFTwYOrLZZPqRYS9oRn"];
//    
//    // [Optional] Track statistics around application opens.
//    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    //====== Parse
    
    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //系統送過來的本地通知，ＡＰＰ執行時或使用中都會進來這邊
    //或ＡＰＰ在背景，沒有使用時，點選橫幅．提醒都會進來
    _notify.applicationIconBadgeNumber = 0;
    [self ReOderBadgeNumber];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    _notify.applicationIconBadgeNumber = 0;
    [self ReOderBadgeNumber];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {//程序到前景時
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    _notify.applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
    [self ReOderBadgeNumber];
}

- (void)applicationWillTerminate:(UIApplication *)application { //當程式被結束時
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody = @"You close App, can't step counter.";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

}

@end
