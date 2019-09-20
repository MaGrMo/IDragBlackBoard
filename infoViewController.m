//
//  infoViewController.m
//  iDragBlackBoard
//
//  Created by Max on 2/21/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "infoViewController.h"

@interface infoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation infoViewController
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
  }

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self  setTitle:_strTitle];

    if ([self.strFromButton isEqualToString:@"About"] ) {
        self.label.text= @"фигня ПРО";
     }
         if ([self.strFromButton isEqualToString:@"Help" ]) {
        self.label.text= @"фигня ПОмощь";
    }

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
