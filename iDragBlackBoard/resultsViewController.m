//
//  resultsViewController.m
//  iDragBlackBoard
//
//  Created by Max on 2/21/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "resultsViewController.h"
#import "dataliedResultsViewController.h"

@interface resultsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSMutableArray *allResults;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSInteger indexResult;



@end

@implementation resultsViewController



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allResults.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.indexResult = indexPath.row;
    
    [self performSegueWithIdentifier:@"toDetaliedResultsFromResults" sender:tableView];

    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Resuls *tmpRes =[[Resuls alloc]init];
    tmpRes = [self.allResults objectAtIndex:indexPath.row];
    NSString *label =[NSString stringWithFormat:@"%@",tmpRes.nameOfCar];
    CLLocation *location =[[CLLocation alloc]init];
    location = tmpRes.results.firstObject;
    NSString *detailed =[NSString stringWithFormat:@"%@",location.timestamp];
     cell.textLabel.text = label;
  cell.detailTextLabel.text = detailed;
    cell.imageView.image = tmpRes.imageCar;
    
    return cell;
}




- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    
   // NSLog(@"%@",[self applicationDocumentsDirectory]);
    
    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.allResults =[[NSMutableArray alloc]init];
    NSMutableArray *tempArray =[[NSMutableArray alloc]initWithContentsOfURL:[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"results.plist"]];
    for (NSData *obj in tempArray) {
        NSData *data = [[NSData alloc] initWithData:obj];
        Resuls *tmpRes =[NSKeyedUnarchiver unarchiveObjectWithData:data];
        [self.allResults addObject:tmpRes];
        
    }
    [self.tableView reloadData];
}
- (IBAction)btnPressed:(UIButton *)sender {
    NSLog(@"%@",[sender currentTitle]);
    
    [self performSegueWithIdentifier:@"toDetaliedResultsFromResults" sender:sender];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toDetaliedResultsFromResults"]) {
        if ([sender isKindOfClass:[UITableView class]]) {
            if ([segue.destinationViewController isKindOfClass:[dataliedResultsViewController class]]) {

                
      [segue.destinationViewController setCurentResults:[self.allResults objectAtIndex:self.indexResult]];
            }
        }
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.allResults removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
       
        [self  writeToFileArrayOfResults:self.allResults];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

-(NSURL* ) applicationDocumentsDirectory{
    //returns URL for Doc directory
    
    
    return  [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


-(void)writeToFileArrayOfResults:(NSArray *)arrayOfResults{
   // NSMutableArray *tempArray =[[NSMutableArray alloc]initWithContentsOfURL:[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"results.plist"]];
    
    NSMutableArray *tempArray =[[NSMutableArray alloc]init];
    for (Resuls *obj in arrayOfResults) {
      [tempArray addObject:[obj dataWithResults:obj]];
    }
    
    
    [tempArray writeToURL:[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"results.plist"] atomically:NO];
    
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
