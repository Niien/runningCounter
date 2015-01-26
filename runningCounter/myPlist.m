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


- (id)initWith:(NSString *)name {
    
    self = [super init];
    
    if (self) {
        
        [self getPlistPath:name];
    }
    
    return self;
}


+ (myPlist *)shareInstanceWithplistName:(NSString *)name {
    
    if (shareInstance == nil) {
        
        shareInstance = [[myPlist alloc]initWith:name];
        
    }
    
    return shareInstance;
}


- (void)getPlistPath:(NSString *)name {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths firstObject];
    //dbPath = [documentPath stringByAppendingPathComponent:@"MyPokemon.plist"];
    NSString *plistName = [NSString stringWithFormat:@"%@.plist",name];
    dbPath = [documentPath stringByAppendingPathComponent:plistName];
    NSLog(@"path:%@",dbPath);
}


- (void)saveDataWithArray:(NSArray *)data {
    
    [data writeToFile:dbPath atomically:YES];
    
}


- (NSArray *)getDataFromPlist{
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:dbPath];
    
    return array;
}


- (NSArray *)getDataWithPokemonName:(NSString *)key{
    
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
