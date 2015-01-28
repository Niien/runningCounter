//
//  MapViewController.m
//  runningCounter
//
//  Created by chiawei on 2015/1/20.
//  Copyright (c) 2015年 Longfatown. All rights reserved.
//



#import "MapViewController.h"


@interface MapViewController () <MKMapViewDelegate,CLLocationManagerDelegate>
{
    
    CLLocationManager *locationManager;
    
    CLLocation *userLocation;
    
    BOOL isfirstLocation;
    
    NSArray *data;
}

@property (weak, nonatomic) IBOutlet MKMapView *myMapView;

@property (strong, nonatomic) IBOutlet UIImageView *pokemonImage;

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@property (weak, nonatomic) IBOutlet UILabel *LvLabel;



@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    locationManager = [CLLocationManager new];
    
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        
        [locationManager requestAlwaysAuthorization];
    }
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    //================
    
    _myMapView.userTrackingMode = MKUserTrackingModeFollow;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    
    data = [[myPlist shareInstanceWithplistName:@"MyPokemon"]getDataFromPlist];
    NSLog(@"data:%@",data);
    
    self.pokemonImage.image = [UIImage imageNamed:self.pictureName];
    
    self.NameLabel.text = self.pictureName;
    
    self.LvLabel.text = [NSString stringWithFormat:@"%ld",(long)self.Lv];
    
    [self addAnnotation];
}


// hide status bar
- (BOOL)prefersStatusBarHidden {
    
    return YES;
}



#pragma mark - button Action

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark - locattionManager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    
    userLocation = [locations lastObject];
    
    if (isfirstLocation == NO) {
        
        MKCoordinateRegion region = _myMapView.region;
        
        region.center = userLocation.coordinate;
        
        
        // 縮放比例
        region.span.latitudeDelta = 0.01;
        region.span.longitudeDelta = 0.01;
        
        [_myMapView setRegion:region animated:YES];
        
        isfirstLocation = YES;
        
    }
    
    
}



#pragma mark - mapView delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    
    if (annotation == mapView.userLocation) {
        
        return nil;
    }
    
    
    MyCustomPin *AnnotationView = (MyCustomPin *)[self.myMapView dequeueReusableAnnotationViewWithIdentifier:self.iconName];
        
    if (AnnotationView == nil) {
            
        AnnotationView = [[MyCustomPin alloc]initWithAnnotation:annotation reuseIdentifier:self.iconName];
            
    }
    else {
            
        AnnotationView.annotation = annotation;
    }
        
    
    AnnotationView.canShowCallout = YES;
    
    
    return AnnotationView;
    
}


- (void)addAnnotation {
    
    for (NSDictionary *dict in data) {
        
        if ([[dict objectForKey:@"image"]isEqualToString:self.pictureName]) {
            
            double lat = [[dict objectForKey:@"lat"]doubleValue];
            double lon = [[dict objectForKey:@"lon"]doubleValue];
            NSLog(@"lat:%f",lat);
            NSLog(@"lon:%f",lon);
            
            CLLocationCoordinate2D annotationCoordinate = CLLocationCoordinate2DMake(lat,lon);
            
            MKPointAnnotation *annotation = [MKPointAnnotation new];
            
            annotation.coordinate = annotationCoordinate;
            
            [self.myMapView addAnnotation:annotation];
            
        }
        
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
