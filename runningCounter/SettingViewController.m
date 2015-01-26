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
    
    content = [[NSMutableArray alloc]initWithObjects:@"個人資料",@"世界地圖",@"連線對戰",@"藍芽對戰",@"圖鑑",@"音量", nil];
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
    
    switch (indexPath.row) {
            
        case 0:   // 個人資料
            
            [self ToPersonalID];
            
            break;
            
        case 1:  // 世界地圖
            
            [self ToWorldMap];
            
            break;
            
        case 2:  // 連線對戰
            //
            break;
            
        case 3:  // 藍芽對戰
            //
            break;
            
        case 4:  //圖鑑
            //
            break;
            
        case 5: // 音量
            
            [self VoiceChange];
            
            break;
            
        default:
            break;
    }

}



#pragma mark - switch method

- (void)ToPersonalID {
    
    PersonalIDViewController *ID = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonalID"];
    
    [self presentViewController:ID animated:YES completion:nil];
    
}


- (void)ToWorldMap {
    
    WorldMapViewController *wmvc = [self.storyboard instantiateViewControllerWithIdentifier:@"WorldMap"];
    
    [self presentViewController:wmvc animated:YES completion:nil];
    
}




- (void)VoiceChange {
    
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
