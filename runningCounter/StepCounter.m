//
//  StepCounter.m
//  runningCounter
//
//  Created by ChingHua on 2015/1/24.
//  Copyright (c) 2015年 Longfatown. All rights reserved.
//

#import "AppDelegate.h"
#import "StepCounter.h"
#import "ViewController.h"
#import "MissionTableViewController.h"
#import "UserProfileSingleton.h"


@interface StepCounter ()
{
    // 新iphone5s up
    CMPedometer *pedometer;
    NSDate *nowDate;
    ViewController *viewController;
    
    //  舊
    double accelX;
    double accelY;
    double accelZ;
        
    CMMotionManager *motionManager;
    NSTimer *timerMonitor;
        
    MissionTableViewController *mission;
        
    NSMutableArray *dateArray;

    //通知的數量
    int badgeNB;
}

@end


@implementation StepCounter

-(void)startStepCounter
{
    badgeNB = 0;
    if ([CMPedometer isStepCountingAvailable]) {
        pedometer = [[CMPedometer alloc] init];
        [self UsePedometer];
    }
    else
    {
        UIAlertView *noUsePedometer = [[UIAlertView alloc] initWithTitle:@"Can't use" message:@"You need iphone 5s UP" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noUsePedometer show];
        
        [self UseAcceleration];
    }
    
}

-(void)stopStepCounter
{
    //新
    [pedometer stopPedometerUpdates];
    
    // 舊 Stop the timer
    [timerMonitor invalidate];
    timerMonitor=nil;
    
    // Stop the Accelermeter
    [motionManager stopAccelerometerUpdates];
    motionManager=nil;
}

// 新 iphone 5s UP
-(void)UsePedometer
{
    [self nowTime];
    [pedometer startPedometerUpdatesFromDate:nowDate withHandler:^(CMPedometerData *pedometerData, NSError *error) {
        
        
        viewController.stepNumber = [NSString stringWithFormat:@"%@",pedometerData.numberOfSteps];
        
        // 步數存入UserDefaults
        NSUserDefaults *step = [NSUserDefaults standardUserDefaults];
        [step setInteger:pedometerData.numberOfSteps.integerValue forKey:@"stepcounter"];
        [step synchronize];
        
        if ([viewController.stepNumber intValue]%20==0)
        {
            [self notifyAndMission];
        }
    }];
    
}

#define UPDATE_HZ 100
#define kFilteringFactor 0.1

// 舊 的記步方式
-(void) UseAcceleration
{
    if(motionManager==nil)
    {
        motionManager=[[CMMotionManager alloc] init];
        
        if([motionManager isAccelerometerAvailable]==YES)
        {
            motionManager.accelerometerUpdateInterval = (float)1/UPDATE_HZ;
            [motionManager startAccelerometerUpdates];
            
            if(timerMonitor==nil)
            {
                timerMonitor = [NSTimer scheduledTimerWithTimeInterval: motionManager.accelerometerUpdateInterval
                                                                target: self
                                                              selector: @selector(handleTimer)
                                                              userInfo: nil
                                                               repeats: YES];
            }
            
        }
        else
        {
            NSLog(@"Device don't support Accelerometer!");
        }
    }
}

-(void) handleTimer
{
    CMAccelerometerData *newestAccel = motionManager.accelerometerData;
    CMAcceleration acceleration=newestAccel.acceleration;
    
    // Hight Pass Filter
    
    accelX = acceleration.x - ( (acceleration.x * kFilteringFactor) + (accelX * (1.0 - kFilteringFactor)) );
    accelY = acceleration.y - ( (acceleration.y * kFilteringFactor) + (accelY * (1.0 - kFilteringFactor)) );
    accelZ = acceleration.z - ( (acceleration.z * kFilteringFactor) + (accelZ * (1.0 - kFilteringFactor)) );

    const float violence = 1.1;
    static BOOL beenhere;
    BOOL shake = FALSE;
    
    if (beenhere)return;
    beenhere = TRUE;
    if (accelX > violence || accelX < (-1*violence))
        shake = TRUE;
    if (accelY > violence || accelY < (-1* violence)) shake = TRUE;
    if (accelZ > violence || accelZ <(-1*violence))
        shake = TRUE;
    if (shake==TRUE) {
        _stepNB ++;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"www" object:nil];
        
        if (_stepNB %20==0)
        {
            [self notifyAndMission];
        }
    }
    beenhere = false;
    //    NSLog(@"%@,%@,%@",stringResultX,stringResultY,stringResultZ);
}


// 現在時間
-(void) nowTime
{
    NSTimeZone *zone = [NSTimeZone defaultTimeZone];//獲得當前應用程序的時區
    NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];//以秒為單位返回當前應用程序與世界標準時間（格林威尼時間）的時差
    nowDate = [[NSDate date] dateByAddingTimeInterval:interval];
}


// 通知數量傳遞
-(void) notifyAndMission
{
    [self nowTime];
    // 通知
    UILocalNotification *loc = [[UILocalNotification alloc] init];
    badgeNB++;
    loc.alertBody = @"You meet the poke !";
    loc.soundName = UILocalNotificationDefaultSoundName;
    loc.applicationIconBadgeNumber = badgeNB;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:loc];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate ReOderBadgeNumber];
    
    if (dateArray == nil) {
        dateArray = [NSMutableArray new];
        [dateArray addObject:nowDate];
    }else [dateArray addObject:nowDate];
    
    [[UserProfileSingleton shareUserProfile] setNotifydateArray:dateArray];
}



@end
