//
//  TabBarViewController.m
//  iDragBlackBoard
//
//  Created by Max on 2/24/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()
@property (nonatomic) NSArray *barImagesArray;
@property (nonatomic) NSArray *barImagesSelectedArray;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor= [UIColor colorWithRed:20.0/256.0 green:164.0/256.0 blue:202.0/256.0 alpha:1];
//    
//    
//    self.barImagesArray = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"mainMenu.png"],
//    [UIImage imageNamed:@"garage.png"],
//    [UIImage imageNamed:@"resutls.png"],
//    [UIImage imageNamed:@"rase.png"], nil];
////    self.barImagesSelectedArray = @[[UIImage imageNamed:@"mainMenuSelected.png"],
////                                    [UIImage imageNamed:@"garageSelected.png"],
////                                    [UIImage imageNamed:@"resultsSelected.png"],
////                                    [UIImage imageNamed:@"raseSelected.png"]];
//   NSLog(@"%@",self.barImagesArray);
////
//
//    
//    // Do any additional setup after loading the view
// 
//    //заполенение названий табок
//   /*
//    for (int i=0; i<self.viewControllers.count; i++) {
//        [[self.tabBar.items objectAtIndex:i]setTitle:[[self.viewControllers objectAtIndex:i]title]];
//       
//          }
//    */
//    
//    //  UITabBarItem *barButtonItem = [[UITabBarItem alloc]initWithTitle:@"qasdfg" image:[self.barImagesArray objectAtIndex:1] selectedImage:[self.barImagesSelectedArray objectAtIndex:1]];
////    NSLog(@"%@",barButtonItem);
//    
//    
//   
//    
//    
}





//метод вызываемый при переключении между табами
/*
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
}

-(void)viewDidDisappear:(BOOL)animated
{
  
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
