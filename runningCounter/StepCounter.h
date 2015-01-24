//
//  StepCounter.h
//  runningCounter
//
//  Created by ChingHua on 2015/1/24.
//  Copyright (c) 2015年 Longfatown. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreMotion;
@import UIKit;

@interface StepCounter : NSObject

// 舊 的步數
@property int stepNB;


-(void)startStepCounter ;
-(void)stopStepCounter;

@end
