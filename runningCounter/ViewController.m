//
//  ViewController.m
//  runningCounter
//
//  Created by Longfatown on 1/20/15.
//  Copyright (c) 2015 Longfatown. All rights reserved.
//

#import "ViewController.h"
#import "StepCounter.h"

@interface ViewController ()
{
    //因為不能直接接parse下來的東西 所以設個用來接的變數
    NSString *username,*useradward,*userLV,*userPower;

    //接parse
    //====== Parse
    PFObject *addInfo;
    PFQuery *getInfo;
    //====== Parse
    
    StepCounter *stepCounter;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //====== Parse
    //初始化
    getInfo = [[PFQuery alloc]initWithClassName:@"BattleUser"];
    //Label 取值
    username = [[getInfo findObjects][0]valueForKey:@"UserName"];
    userLV = [NSString stringWithFormat:@"%@",[[getInfo findObjects][0]valueForKey:@"UserLV"]];
    _power = [NSString stringWithFormat:@"%@",[[getInfo findObjects][0]valueForKey:@"UserPower"]];
    useradward = [[getInfo findObjects][0]valueForKey:@"UserAdward"];
    
    _UserNameLabel.text = username;
    _UserLVLabel.text = userLV;
    _UserPowerLabel.text = userPower;
    _UserAdwardLabel.text = useradward;
    
    
    stepCounter = [StepCounter new];
    [stepCounter startStepCounter];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(powerLabel) name:@"StepCounter" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 增加步數（精力）
-(void) powerLabel
{
    _UserPowerLabel.text = [NSString stringWithFormat:@"%d",stepCounter.stepNB];
}
@end
