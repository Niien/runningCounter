//
//  SettingViewController.m
//  runningCounter
//
//  Created by chiawei on 2015/1/25.
//  Copyright (c) 2015年 Longfatown. All rights reserved.
//

#import "SettingViewController.h"



@interface SettingViewController ()<UITabBarDelegate,UITabBarControllerDelegate>
{
    NSMutableArray *content;
    
    NSString *Acount;
    NSString *Password;
    NSString *height;
    NSString *weight;
    NSString *age;
    
    UIView *myView;
    
}


@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    content = [[NSMutableArray alloc]initWithObjects:@"個人資料",@"個人帳戶",@"世界地圖",@"對戰",@"音量", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [content count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [content objectAtIndex:indexPath.row];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //
    }];
    
    UIAlertAction *checkButton = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //
    }];
    
    
    
    if (indexPath.row == 0) { // 個人資料
        
        [alert setTitle:@"個人資料"];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            textField.placeholder = @"輸入你的身高";
            height = textField.text;
            
        }];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"輸入你的體重";
            weight = textField.text;
        }];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"輸入你的年齡";
        }];
        
        [self presentViewController:alert animated:YES completion:^{
            //
        }];
        
        [alert addAction:cancelButton];
        [alert addAction:checkButton];
        
    }
    else if (indexPath.row == 1) { // 個人帳戶
        
        [alert setTitle:@"個人帳戶"];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"輸入你的帳號";
        }];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"輸入你的密碼";
            textField.secureTextEntry = YES;
        }];
        
        [self presentViewController:alert animated:YES completion:^{
            //
        }];
        
        [alert addAction:cancelButton];
        [alert addAction:checkButton];
        
    }
    else if (indexPath.row == 2) { // 世界地圖
        
        WorldMapViewController *wmvc = [self.storyboard instantiateViewControllerWithIdentifier:@"WorldMap"];
        
        [self presentViewController:wmvc animated:YES completion:^{
            //
        }];
        
    }
    
    else if (indexPath.row == 3) { // 對戰
        
        
        
    }
    else if (indexPath.row == 4) { // 音量
        
        myView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, self.view.frame.size.height/3, 200, 100)];
        
        myView.backgroundColor = [UIColor grayColor];
        
        UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(0, myView.frame.size.height/2-10, 200, 30)];
        
        [myView addSubview:slider];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(myView.frame.size.width/3, myView.frame.size.height/2+30, 50, 20)];
        
        [button setTitle:@"ok" forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        
        button.backgroundColor = [UIColor blueColor];
        
        [myView addSubview:button];
        
        [self.view addSubview:myView];
        
    }
    
}



#pragma mark - button action
- (IBAction)click:(id)sender {
    
    myView.hidden = YES;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
