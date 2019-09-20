//
//  SelectModelViewController.m
//  iDragBlackBoard
//
//  Created by Max on 3/1/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "SelectModelViewController.h"
#import "ModelPropertiesViewController.h"

@interface SelectModelViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSDictionary *listModels;
@property (nonatomic) NSArray *models;
@property (nonatomic) NSString *modelToSend;
@property (nonatomic) NSMutableDictionary *propertyToSend;




@end

@implementation SelectModelViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listModels.allKeys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *model = [self.models objectAtIndex:indexPath.row];
    cell.textLabel.text = model;
 
        return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.modelToSend = [self.models objectAtIndex:indexPath.row];
    self.propertyToSend = [self.listModels objectForKey:self.modelToSend];
    [self performSegueWithIdentifier:@"toModelProperties" sender:tableView];


    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toModelProperties"]) {
        
        if ([segue.destinationViewController isKindOfClass:[ModelPropertiesViewController class]]) {
            [segue.destinationViewController setModel:self.modelToSend];
            [segue.destinationViewController setTitle:self.modelToSend];
            [segue.destinationViewController setBrand:self.title];
            [segue.destinationViewController setPropertyOfModelFrom:self.propertyToSend];
            
  //          NSLog(@"%@",self.propertyToSend);
        }
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.listModels) {
        self.listModels = [[NSDictionary alloc]initWithDictionary:[self CreateListOfModels]];
    }
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    
}


-(NSDictionary *)CreateListOfModels{
    NSString *path =[[NSBundle mainBundle]pathForResource:@"cars" ofType:@"plist"];
    
    NSDictionary *data =[[[[NSDictionary  alloc]initWithContentsOfFile:path]objectForKey:self.brandName] firstObject];
    //NSDictionary *data =[[[[NSDictionary  alloc]initWithContentsOfFile:@"/Users/max/Developer/iDragBlackBoard/data/cars.plist"]objectForKey:self.brandName] firstObject];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc]initWithArray:[data.allKeys sortedArrayUsingSelector:@selector(compare:)]];
    self.models = tempArray;
    return data;
    

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
