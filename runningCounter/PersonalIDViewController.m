//
//  PersonalIDViewController.m
//  runningCounter
//
//  Created by chiawei on 2015/1/26.
//  Copyright (c) 2015年 Longfatown. All rights reserved.
//

#import "PersonalIDViewController.h"
#import "LoginVC.h"

@interface PersonalIDViewController ()<UITextFieldDelegate>
{
    NSArray *personalData;
    
    NSString *status;
    
    BOOL islogin;
    
}

@property (weak, nonatomic) IBOutlet UIButton *LogInButton;

@property (weak, nonatomic) IBOutlet UITextField *heightTextField;

@property (weak, nonatomic) IBOutlet UITextField *weightTextField;

@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@end

@implementation PersonalIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if ([self.LogInButton.titleLabel.text isEqualToString:@"登入"]) {
        islogin = NO;
    } else {
        self.LogInButton.titleLabel.text = @"登出";
        islogin = YES;
    }
    
    personalData = [[myPlist shareInstanceWithplistName:@"MyPersonProfile"]getDataFromPlist];

    NSLog(@"personalData:%@",personalData);
    
    if (personalData != nil) {
        
        self.heightTextField.text = [[personalData objectAtIndex:0]objectForKey:@"height"];
        
        self.weightTextField.text = [[personalData objectAtIndex:0]objectForKey:@"weight"];
        
        self.ageTextField.text = [[personalData objectAtIndex:0]objectForKey:@"age"];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//收鍵盤
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.heightTextField resignFirstResponder];
    [self.weightTextField resignFirstResponder];
    [self.ageTextField resignFirstResponder];
    
}



- (IBAction)LogInButton:(id)sender {
    LoginVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    [self presentViewController:VC animated:YES completion:^{
        //
    }];
    
    
    
}


- (IBAction)okButton:(id)sender {
    
    if (islogin) {
        status = @"YES";
    }else {
        status = @"NO";
    }
    
    personalData = [[NSArray alloc]initWithObjects:@{@"account":@0,
                                                     @"password":@0,
                                                     @"status":status,
                                                     @"height":self.heightTextField.text,
                                                     @"weight":self.weightTextField.text,
                                                     @"age":self.ageTextField.text,
                                                     }, nil];
    
    
    [[myPlist shareInstanceWithplistName:@"MyPersonalProfile"]saveDataWithArray:personalData];
    
    NSLog(@"personalData:%@",personalData);
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
