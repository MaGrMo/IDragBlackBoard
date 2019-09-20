//
//  RaceUViewController.m
//  iDragBlackBoard
//
//  Created by Max on 28.03.15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "RaceUViewController.h"

@interface RaceUViewController ()
@property (strong, nonatomic) IBOutlet UITabBarItem *raceTabBarItem;



@end

@implementation RaceUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image =[UIImage imageNamed:@"3.png"];
    NSLog(@"%@",image);
    self.raceTabBarItem = [[UITabBarItem alloc]initWithTitle:@"Race" image:image selectedImage:image];
   
    
}
-(void)awakeFromNib{
    [super awakeFromNib];
  
    
}

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
