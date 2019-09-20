//
//  CarEditInGarageViewController.m
//  iDragBlackBoard
//
//  Created by Max on 3/3/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "CarEditInGarageViewController.h"

@interface CarEditInGarageViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CarEditInGarageViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.carToEdit.allKeys.count;
}
- (IBAction)gestureRecognizer:(UITapGestureRecognizer *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *property = [self.carToEdit.allKeys objectAtIndex:indexPath.row];
    NSString *valueForProperty = [NSString new];
    if (![[self.carToEdit.allKeys objectAtIndex:indexPath.row] isEqualToString:@"image"]   ) {
         valueForProperty =[self.carToEdit.allValues objectAtIndex:indexPath.row];
    }
   
    cell.textLabel.text = property;
    cell.detailTextLabel.text = valueForProperty;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //вызывает переход на редактирование модели
   
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [self.carToEdit objectForKey:@"name"];
    self.imageView.image = [[UIImage alloc]initWithData:[self.carToEdit objectForKey:@"image"]];
    // Do any additional setup after loading the view.
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
  
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
