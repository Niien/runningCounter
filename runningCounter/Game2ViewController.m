//
//  Game2ViewController.m
//  runningCounter
//
//  Created by chiawei on 2015/1/25.
//  Copyright (c) 2015年 Longfatown. All rights reserved.
//

#import "Game2ViewController.h"

@interface Game2ViewController ()
{
    int random,randomNO;        // 隨機取值
    int X;                      // 陣列比對位數
    NSTimer *myCountdowntimer;  //
    float time;                 // 所剩時間
    BOOL GameFinal;             // 判斷遊戲成敗
    NSArray *BaseElementArray;
}
@property (weak, nonatomic) IBOutlet UILabel *showTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *RandomLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *ButtonsLabel;
@property (weak, nonatomic) IBOutlet UILabel *mytimeLabel;

@end

@implementation Game2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

#pragma mark 參數設置
- (void)viewDidAppear:(BOOL)animated{
    //重置
    time = 5.0;
    BaseElementArray = [NSArray new];       // 底層元素(箭頭)
    NumberArray = [NSMutableArray new];     // 數字陣列
    showArrowArray = [NSMutableArray new];  // 箭頭陣列
    keyinArray = [NSMutableArray new];      // 比對陣列
    X = 0;                                  //
    GameFinal = false;                      // 遊戲輸贏判斷
    [self getPokemonAndSave];               // 隨機取怪獸
    
    
    //顯示目標 分數 時間
    _mytimeLabel.text = [NSString stringWithFormat:@"= %.1f =",time];
    _showTextLabel.text = @"";
    //設一個倒數計時器 並在分數達標時停止並響鈴
    [self showRandom];
    myCountdowntimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(myCountDown:) userInfo:nil repeats:YES];
}
#pragma mark 隨機取值
- (void)showRandom{
    //↓←→↑AB
    BaseElementArray = @[@"↑",@"→",@"↓",@"←",@"A",@"B"];
    
    randomNO = arc4random()%4+8;
    _RandomLabel.text = @"";
    //生成 箭頭陣列 與 數字陣列
    for (int i=0; i<randomNO; i++) {
        random = arc4random()%6;
        [NumberArray addObject:[NSString stringWithFormat:@"%d",random]];
        [showArrowArray addObject:[BaseElementArray objectAtIndex:random]];
    }
    NSString *tmp1,*tmp2;
    tmp2 = @"";
    NSLog(@"%@",NumberArray);
    //為了修正前面逗號,變一大串 XDD
    for (int i=0; i<randomNO-1; i++) {
        tmp1 = [NSString stringWithFormat:@"%@",showArrowArray[i]];
        tmp2 = [NSString stringWithFormat:@"%@%@",tmp2,tmp1];
    }
    _RandomLabel.text = [NSString stringWithFormat:@"%@%@",tmp2,[showArrowArray lastObject]];
    
}

#pragma mark 按鈕事件
- (IBAction)Buttons:(UIButton *)sender {
    
    NSString *keytmp = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    NSLog(@"%@",keytmp);
    
    if ([keytmp isEqualToString:NumberArray[X]]) {
        //對的話做的事
        NSLog(@"Correct");
        NSString *correcttmp =
        [NSString stringWithFormat:@"%@",[showArrowArray objectAtIndex:X]];
        _showTextLabel.text = [NSString stringWithFormat:@"%@%@",_showTextLabel.text,correcttmp];
        X++;
        if (X == [NumberArray count]) {
            NSLog(@"end");
            //結束動作
            GameFinal = true;
        }
    }else {NSLog(@"error");}//打錯字做的事
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 倒數計時
-(void)myCountDown:(NSTimer *)timer{
    
    time -=0.1;
    _mytimeLabel.text = [NSString stringWithFormat:@"= %.1f =",time];

    if (time >= 0) {
        if (GameFinal) {
            //還有時間 且 已達標
            [myCountdowntimer invalidate];
            //隱藏按鈕
            for (int i=0; i<6; i++) {
                [[_ButtonsLabel objectAtIndex:i]setEnabled:NO];
            }

            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Succeed" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1;
            [alert show];
        }
    }else{
        _mytimeLabel.text = [NSString stringWithFormat:@"= 0.0 ="];
        [myCountdowntimer invalidate];
        //隱藏按鈕
        for (int i=0; i<6; i++) {
            [[_ButtonsLabel objectAtIndex:i]setEnabled:NO];
        }
        UIAlertView *failalert = [[UIAlertView alloc]initWithTitle:@"Failed" message:nil delegate:self cancelButtonTitle:@"QQ" otherButtonTitles:nil];
        failalert.tag = 2;
        [failalert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 1:     // Successed Alert
            if (buttonIndex == 0) {
                
                [self dismissViewControllerAnimated:YES completion:^{
                    //成功動作
                }];
            }
            break;
        case 2:     // Failed Alert
            if (buttonIndex == 0) {
                [self dismissViewControllerAnimated:YES completion:^{
                    //失敗動作
                }];
            }
            break;
        default:
            break;
    }
}
#pragma mark 畫面消失
-(void)viewDidDisappear:(BOOL)animated{
    [myCountdowntimer invalidate];
}


- (void)getPokemonAndSave {
    
    int i = arc4random()%30+1;
    
    // create a new empty view
//    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height/4, 100, 100)];
//    
    NSString *imageName = [NSString stringWithFormat:@"%d.png",i];
    NSString *iconName = [NSString stringWithFormat:@"%d.png",i];
    NSLog(@"imageName:%@",imageName);
    NSLog(@"iconName:%@",iconName);
    
//    UIImage *image = [UIImage imageNamed:imageName];
//    
//    UIImageView *myImageView = [[UIImageView alloc]initWithImage:image];
//    myImageView.frame = CGRectMake(0, 0, myView.frame.size.width, myView.frame.size.height);
//    
//    // add view
//    [myView addSubview:myImageView];
//    [self.view addSubview:myView];
    
    
    // save data to plist
    NSDictionary *dict = @{@"Name":imageName, @"iconName":iconName, @"Lv":@"1"};
    
    NSArray *array = [[NSArray alloc]initWithObjects:dict ,nil];
    
    [[myPlist shareInstanceWithplistName:@"MyPokemon"]saveDataWithArray:array];
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
