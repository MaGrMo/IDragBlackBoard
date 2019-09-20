//
//  GarageNavigationViewController.m
//  iDragBlackBoard
//
//  Created by Max on 3/2/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "GarageNavigationViewController.h"

@interface GarageNavigationViewController ()
@property (strong, nonatomic) IBOutlet UITabBarItem *tb;


@end

@implementation GarageNavigationViewController
-(void)awakeFromNib{
    [super awakeFromNib];
    
    
   
    
    
    // self.barButtonItem.image = [UIImage imageNamed:@"garage.png"];
  //  self.barButtonItem.selectedImage =[UIImage imageNamed:@"garageSelected.png"];
    
   // NSLog(@"%@",self.barButtonIte)
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
      // Do any additional setup after loading the view.
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
