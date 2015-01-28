//
//  MapViewController.h
//  runningCounter
//
//  Created by chiawei on 2015/1/20.
//  Copyright (c) 2015年 Longfatown. All rights reserved.
//


@import MapKit;
@import CoreLocation;
#import "ViewController.h"
#import "CollectionViewCell.h"
#import "MyCustomPin.h"
#import "myPlist.h"
#import "test.h"

@interface MapViewController : ViewController

@property (assign, nonatomic) NSInteger Lv;

@property NSString *pictureName;

@property NSString *iconName;

@property (assign, nonatomic) double lat;
@property (assign, nonatomic) double lon;

@end
