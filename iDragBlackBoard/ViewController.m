//
//  ViewController.m
//  iDragBlackBoard
//
//  Created by Max on 2/20/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "ViewController.h"
#import "infoViewController.h"
#import "TabBarViewController.h"
#import "CFCar.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UILabel *carNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
         }

-(void)viewDidAppear:(BOOL)animated{
    
    
    if ([CFCar sharedInstance].nameOfCar ) {
    //    [self.carImageView setImage:[CFCar sharedInstance].image];
        self.carNameLabel.text = [CFCar sharedInstance].nameOfCar;
        self.imageView.image =[CFCar sharedInstance].image;
        
    }else{
        self.carNameLabel.text = @"select you car in garage";
    }
    
}
- (IBAction)btnPressed:(UIButton *)sender {
    NSLog(@"%@",[sender currentTitle]);
    
    [self performSegueWithIdentifier:@"toInfoController" sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toInfoController"]) {
        if ([sender isKindOfClass:[UIButton class]]) {
            if ([segue.destinationViewController isKindOfClass:[infoViewController class]]) {
                [segue.destinationViewController setStrFromButton:[sender currentTitle]];
                [segue.destinationViewController setStrTitle:[sender currentTitle]];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
