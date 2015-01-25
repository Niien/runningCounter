//
//  myPlist.m
//  runningCounter
//
//  Created by chiawei on 2015/1/25.
//  Copyright (c) 2015年 Longfatown. All rights reserved.
//

#import "myPlist.h"

@implementation myPlist
{
    NSString *dbPath;
}

myPlist *shareInstance;


- (id)init {
    
    self = [super init];
    
    if (self) {
        
        [self getPlistPath];
        
    }
    
    return self;
}


+ (myPlist *)shareInstance {
    
    if (shareInstance == nil) {
        
        shareInstance = [[myPlist alloc]init];
        
    }
    
    return shareInstance;
}


- (void)getPlistPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths firstObject];
    dbPath = [documentPath stringByAppendingPathComponent:@"MyPokemon.plist"];
    
    NSLog(@"path:%@",dbPath);
}


- (void)saveDataWithArray:(NSArray *)data {
    
    [data writeToFile:dbPath atomically:YES];
    
}


- (NSArray *)getDataFromPlist{
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:dbPath];
    
    return array;
}


- (NSArray *)getDataWithKey:(NSString *)key{
    
    NSArray *array = [[NSArray alloc]initWithArray:[self getDataFromPlist]];
    
    NSMutableArray *data = [NSMutableArray new];
    
    for (NSDictionary *dict in array) {
        
        if ([[dict objectForKey:@"name"]isEqualToString:key]) {
            
            [data addObject:dict];
            
        }
    }
    
    return data;
    
}



@end
