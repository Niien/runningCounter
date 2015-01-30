//
//  LoginVC.m
//  runningCounter
//
//  Created by Longfatown on 1/29/15.
//  Copyright (c) 2015 Longfatown. All rights reserved.
//

#import "LoginVC.h"


@interface LoginVC ()<PFLogInViewControllerDelegate,PFSignUpViewControllerDelegate>{
    BOOL didLogInUser : YES;
}

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // Initialize Parse(初始化)
    [Parse setApplicationId:@"37sMr08M1ovb6en1nQ7mm6wMa0wZS9w8EBrb8203"
                  clientKey:@"VPIfQhgqixZKALeTzbhIurFTwYOrLZZPqRYS9oRn"];
    // [Optional] Track statistics around application opens.
//    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //註冊
//    PFSignUpViewController *signUpController = [[PFSignUpViewController alloc] init];
////    signUpController.delegate = self;
//    
//    signUpController.fields = (PFSignUpFieldsUsernameAndPassword
//                               | PFSignUpFieldsSignUpButton
//                               | PFSignUpFieldsDismissButton);
//    

}
-(void)viewWillAppear:(BOOL)animated{
    
    PFLogInViewController *logInController = [[PFLogInViewController alloc] init];

    logInController.fields = (PFLogInFieldsUsernameAndPassword
                              | PFLogInFieldsLogInButton
                              | PFLogInFieldsSignUpButton
                              | PFLogInFieldsPasswordForgotten
                              | PFLogInFieldsDismissButton);
    
    logInController.delegate = self;
    
    //
//    logInController.signUpController.fields = (PFSignUpFieldsUsernameAndPassword
//       | PFSignUpFieldsSignUpButton | PFSignUpFieldsDismissButton);
//    
//    logInController.signUpController.delegate = self;
    
    [self presentViewController:logInController animated:YES completion:nil];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
   
    //    self.logInView.logInButton.frame = CGRectMake(100,30, 30, 200);
        UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"500.png"]];
        self.logInView.logo = logoView; // logo can be any UIView
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)logInViewController:(PFLogInViewController *)controller
               didLogInUser:(PFUser *)user {
    NSLog(@"Login");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"cancel login");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    NSLog(@"did sign");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"cancel sign");
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
