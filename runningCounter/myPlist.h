//
//  myPlist.h
//  runningCounter
//
//  Created by chiawei on 2015/1/25.
//  Copyright (c) 2015年 Longfatown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myPlist : NSObject


+ (myPlist *)shareInstance;

- (void)getPlistPath;

- (void)saveDataWithArray:(NSArray *)data;

- (NSArray *)getDataFromPlist;

- (NSArray *)getDataWithKey:(NSString *)key;


@end
