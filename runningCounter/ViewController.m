//
//  ViewController.m
//  runningCounter
//
//  Created by Longfatown on 1/20/15.
//  Copyright (c) 2015 Longfatown. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    //====== Parse
    PFObject *addInfo;
    PFQuery *getInfo;
    //====== Parse
}
//====== User Info
@property (weak, nonatomic) IBOutlet UILabel *UserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *UserLVLabel;
@property (weak, nonatomic) IBOutlet UILabel *UserPowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *UserAdwardLabel;
@property (weak, nonatomic) IBOutlet UIImageView *UserImageView;
//====== User Info
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //====== Parse
    //初始化
//    getInfo = [[PFQuery alloc]initWithClassName:@"BattleUser"];
//    //Label 取值
//    _UserNameLabel.text = [[getInfo findObjects][0]valueForKey:@"UserName"];
//    _UserLVLabel.text = [NSString stringWithFormat:@"%@",[[getInfo findObjects][0]valueForKey:@"UserLV"]];
//    _UserPowerLabel.text = [NSString stringWithFormat:@"%@",[[getInfo findObjects][0]valueForKey:@"UserPower"]];
//    _UserAdwardLabel.text = [[getInfo findObjects][0]valueForKey:@"UserAdward"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
