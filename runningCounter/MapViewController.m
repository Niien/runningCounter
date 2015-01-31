//
//  MapViewController.m
//  runningCounter
//
//  Created by chiawei on 2015/1/20.
//  Copyright (c) 2015年 Longfatown. All rights reserved.
//



#import "MapViewController.h"


@interface MapViewController () <MKMapViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>
{
    
    CLLocationManager *locationManager;
    
    CLLocation *userLocation;
    
    BOOL isfirstLocation;
    
    NSMutableArray *data;
    
    NSMutableDictionary *pokemonDict;
    
    UITextField *textfield;
    
    NSInteger exp;
}

@property (weak, nonatomic) IBOutlet MKMapView *myMapView;

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;

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
    
    pokemonDict = [NSMutableDictionary new];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    
    data = [[myPlist shareInstanceWithplistName:@"MyPokemon"]getDataFromPlist];
    //NSLog(@"data:%@",data);
    
    pokemonDict = [data objectAtIndex:self.numberofIndex];
    
    self.pokemonImage.image = [UIImage imageNamed:[pokemonDict objectForKey:@"image"]];
    
    self.NameLabel.text = [pokemonDict objectForKey:@"name"];
    
    self.LvLabel.text = [NSString stringWithFormat:@"等級%@",[pokemonDict objectForKey:@"Lv"]];
    
    exp = [[pokemonDict objectForKey:@"exp"]integerValue];
    
    [self addAnnotation];
}


// hide status bar
- (BOOL)prefersStatusBarHidden {
    
    return YES;
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
    
    
    MyCustomPin *AnnotationView = (MyCustomPin *)[self.myMapView dequeueReusableAnnotationViewWithIdentifier:[pokemonDict objectForKey:@"iconName"]];
        
    if (AnnotationView == nil) {
            
        AnnotationView = [[MyCustomPin alloc]initWithAnnotation:annotation reuseIdentifier:[pokemonDict objectForKey:@"iconName"]];
            
    }
    else {
            
        AnnotationView.annotation = annotation;
    }
        
    
    AnnotationView.canShowCallout = YES;
    
    
    return AnnotationView;
    
}


#pragma mark - addAnnotation
- (void)addAnnotation {
    
    for (NSDictionary *dict in data) {
        
        if ([[dict objectForKey:@"image"]isEqualToString:[pokemonDict objectForKey:@"image"]]) {
            
            double lat = [[dict objectForKey:@"lat"]doubleValue];
            double lon = [[dict objectForKey:@"lon"]doubleValue];
            //NSLog(@"lat:%f",lat);
            //NSLog(@"lon:%f",lon);
            
            CLLocationCoordinate2D annotationCoordinate = CLLocationCoordinate2DMake(lat,lon);
            
            MKPointAnnotation *annotation = [MKPointAnnotation new];
            
            annotation.coordinate = annotationCoordinate;
            
            [self.myMapView addAnnotation:annotation];
            
        }
        
    }

}


#pragma mark - alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSInteger Lv = [[pokemonDict objectForKey:@"Lv"] integerValue];
    
    if (alertView.tag == 1) {
        
        NSInteger inputNumber = [textfield.text integerValue];
        
//            if (inputNumber <= [StepCounter shareStepCounter].power) {
//        
//                [StepCounter shareStepCounter].power -= inputNumber;
//                exp += inputNumber;
//        
//                if (exp > 2000) {
//        
//                    Lv += (exp /2000);
//                    exp = exp % 2000;
//        
//                }
//            } else {
//                
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"精力不夠" message:nil delegate:self cancelButtonTitle:@"確定" otherButtonTitles: nil];
//                [alert show];
//                
//            }
        
        exp += inputNumber;
        
        if (exp >= 2000) {
            
            Lv += (exp /2000);
            exp = exp % 2000;
        }
        
        NSString *EXP = [NSString stringWithFormat:@"%d",exp];
        NSString *LvStr = [NSString stringWithFormat:@"%d",Lv];
        
        [pokemonDict setObject:EXP forKey:@"exp"];
        [pokemonDict setObject:LvStr forKey:@"Lv"];
        
        [[myPlist shareInstanceWithplistName:@"MyPokemon"]saveDataByOverRide:data];
        
        self.LvLabel.text = [NSString stringWithFormat:@"等級%@",LvStr];
    }
    else if (alertView.tag == 2) {
        
        if (buttonIndex == 1) {
            
            [data removeObject:pokemonDict];
            
            [StepCounter shareStepCounter].power += (Lv*1000);
            
            [[myPlist shareInstanceWithplistName:@"MyPokemon"]saveDataByOverRide:data];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }
    
}



#pragma mark - button Action

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)expButton:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"輸入給予的精力" message:nil delegate:self cancelButtonTitle:@"確定" otherButtonTitles: nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 1;
    [alert show];
    
    textfield = [alert textFieldAtIndex:0];
}


- (IBAction)SaleButton:(id)sender {
    
    NSInteger Lv = [[pokemonDict objectForKey:@"Lv"] integerValue];
    NSString *message = [NSString stringWithFormat:@"可回收%d精力",Lv*1000];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"確定要賣掉" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"確定", nil];
    alert.tag = 2;
    [alert show];
    
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
