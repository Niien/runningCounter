//
//  Game1ViewController.m
//  runningCounter
//
//  Created by Longfatown on 1/21/15.
//  Copyright (c) 2015 Longfatown. All rights reserved.
//

#import "Game1ViewController.h"
#import "ViewController.h"

@interface Game1ViewController (){
    NSTimer *timeCountDown;
    int goal,myPressPoint;
    float time;
}
@property (weak, nonatomic) IBOutlet UIImageView *firstVCImage;
@property (weak, nonatomic) IBOutlet UILabel *targetGoal;
@property (weak, nonatomic) IBOutlet UILabel *myPoint;
@property (weak, nonatomic) IBOutlet UIButton *BtnLabelleft;
@property (weak, nonatomic) IBOutlet UIButton *BtnLabelright;
@property (weak, nonatomic) IBOutlet UILabel *mytimeLabel;

@end

@implementation Game1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *imagePath = [[NSBundle mainBundle]pathForResource:@"battle01-1.jpeg" ofType:nil];
    _firstVCImage.image = [UIImage imageWithContentsOfFile:imagePath];
    
    [_BtnLabelleft setImage:[UIImage imageNamed:@"RedBtn1.png"] forState:UIControlStateNormal];
    [_BtnLabelleft setImage:[UIImage imageNamed:@"RedBtn2.png"] forState:UIControlStateHighlighted];
    [_BtnLabelright setImage:[UIImage imageNamed:@"RedBtn1.png"] forState:UIControlStateNormal];
    [_BtnLabelright setImage:[UIImage imageNamed:@"RedBtn2.png"] forState:UIControlStateHighlighted];
    
}
-(void)viewDidAppear:(BOOL)animated{
    //隨機目標數
    time = 6.0;
    goal = 10;//arc4random()%50+40;
    myPressPoint = 0;
    
    //顯示目標 分數 時間
    _targetGoal.text = [NSString stringWithFormat:@"Mission Target: %ld",(long)goal];
    _myPoint.text = [NSString stringWithFormat:@"%ld",(long)myPressPoint];
    _mytimeLabel.text = [NSString stringWithFormat:@"= %.1f =",time];
    
    //設一個倒數計時器 並在分數達標時停止並響鈴
    timeCountDown = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(myCountDown:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressedBtnleft:(id)sender {
    myPressPoint++;
    _myPoint.text = [NSString stringWithFormat:@"%ld",(long)myPressPoint];
    NSLog(@"%d",myPressPoint);
    
}

- (IBAction)pressedBtnRight:(id)sender {
    myPressPoint++;
    _myPoint.text = [NSString stringWithFormat:@"%ld",(long)myPressPoint];
    NSLog(@"%d",myPressPoint);
    
}

-(void)myCountDown:(NSTimer *)timer{
    
    time -=0.1;
    _mytimeLabel.text = [NSString stringWithFormat:@"= %.1f =",time];
    if (time >= 0) {
        if (myPressPoint >= goal) {
            //還有時間 且 已達標
            [timeCountDown invalidate];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Succeed" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1;  //要分辨多個 Alert 且加動作 就需設tag
            [alert show];
        }
    }else{
        [timeCountDown invalidate];
        UIAlertView *failalert = [[UIAlertView alloc]initWithTitle:@"Failed" message:nil delegate:self cancelButtonTitle:@"QQ" otherButtonTitles:nil];
        failalert.tag = 2;  //要分辨多個 Alert 且加動作 就需設tag
        [failalert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 1:
            if (buttonIndex == 0) {
                ViewController *Home = [ViewController new];
//                NSLog(@"%@",Home.power);
                [self dismissViewControllerAnimated:YES completion:^{
                    NSLog(@"成功過去的");
                }];
                
            }
            break;
        case 2:
            if (buttonIndex == 0) {
                
                [self dismissViewControllerAnimated:YES completion:^{
                    NSLog(@"失敗過去的");
                }];
            }
            break;
        default:
            break;
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [timeCountDown invalidate];
}

@end
