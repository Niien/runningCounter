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

@interface MapViewController : ViewController

@property (strong, nonatomic) IBOutlet UIImageView *pokemonImage;

@property (assign, nonatomic) NSInteger indexPathNumber;



@end
