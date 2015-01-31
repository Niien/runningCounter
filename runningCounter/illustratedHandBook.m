//
//  illustratedHandBook.m
//  runningCounter
//
//  Created by chiawei on 2015/1/31.
//  Copyright (c) 2015年 Longfatown. All rights reserved.
//

#import "illustratedHandBook.h"

@interface illustratedHandBook () <UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *allPokemons;
    NSMutableArray *myPokemons;
    
}

@end

@implementation illustratedHandBook

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    allPokemons = [NSMutableArray new];
    
    for (int i = 1; i <= 30; i++) {
        
        [allPokemons addObject:[NSString stringWithFormat:@"%d.png",i]];
        
    }
    
    
    UINavigationBar *bar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [self.view addSubview:bar];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backIcon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    UINavigationItem * leftItem = [[UINavigationItem alloc]init];
    leftItem.leftBarButtonItem = backButton;
    bar.items = @[leftItem];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    myPokemons = [[NSMutableArray alloc]initWithArray:[[myPlist shareInstanceWithplistName:@"MyPokemon"]getDataFromPlist]];
    [self refresh];
}


- (void)refresh {
    
    [self.collectionView reloadData];
    
}


// hide status bar
- (BOOL)prefersStatusBarHidden {
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [allPokemons count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    int i = 0;
    
    if ([[allPokemons objectAtIndex:indexPath.row]isEqualToString:[[myPokemons objectAtIndex:i] objectForKey:@"image"]]) {
        
        cell.illustrateImage.image = [UIImage imageNamed:[allPokemons objectAtIndex:indexPath.row]];
        i++;
        
    }
    else {
        
        cell.illustrateImage.image = [UIImage imageNamed:@"mystery.png"];
        
    }
    
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(35.0, 0, 10.0, 0);
    
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
