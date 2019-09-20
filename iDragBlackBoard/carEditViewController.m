//
//  carEditViewController.m
//  iDragBlackBoard
//
//  Created by Max on 2/25/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "carEditViewController.h"
#import "CFCar.h"
#import "SelectModelViewController.h"
@interface carEditViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *listOfBrands;
@property (nonatomic) NSArray *images;

@property (nonatomic) NSString *brandToSend;


@end

@implementation carEditViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listOfBrandsAndImages.allKeys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //сортированный массив
    NSString *carManufak = [self.listOfBrands objectAtIndex:indexPath.row];
    cell.textLabel.text = carManufak;
    cell.detailTextLabel.text = @"Ukraine";
    
    if ([self.listOfBrandsAndImages objectForKey:carManufak] != [NSData new]) {
        cell.imageView.image = [[UIImage alloc]initWithData:[self.listOfBrandsAndImages objectForKey:carManufak]];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"noBrand.png"];
    }
    
    return cell;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    //[self.tableView reloadData];
    //NSLog(@" %@",self.listOfBrandsAndImages);
    if (!self.listOfBrandsAndImages) {
       
        self.listOfBrandsAndImages = [self createListOfBrandsImages];
   }
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.brandToSend = [self.listOfBrands objectAtIndex:indexPath.row];
    
    self.curentImage = [[[tableView cellForRowAtIndexPath:indexPath] imageView ]image ];
    [self performSegueWithIdentifier:@"toSelectModel" sender:tableView];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toSelectModel"]) {
        
        if ([segue.destinationViewController isKindOfClass:[SelectModelViewController class]]) {

            
            [segue.destinationViewController setBrandName:self.brandToSend];
            [segue.destinationViewController setTitle:self.brandToSend];
            
        }
        
    }
}



-(NSDictionary *)createListOfBrandsImages{
    NSMutableDictionary *result =[NSMutableDictionary new];
    NSString *path =[[NSBundle mainBundle]pathForResource:@"cars" ofType:@"plist"];
//зугрузка данных из  Плиста
     NSDictionary *data =[[NSDictionary  alloc]initWithContentsOfFile:path];
    NSMutableArray *tempArray = [[NSMutableArray alloc]initWithArray:[data.allKeys sortedArrayUsingSelector:@selector(compare:)]];
    self.listOfBrands = tempArray;
    
       for (NSString *key in data.allKeys) {
        if ([[data objectForKey:key] count]>1) {
           result[key]= [[data objectForKey:key] lastObject];
        } else{
            result[key]= [NSData new];
            
        }
    }
     return result;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}



@end
