//
//  dataliedResultsViewController.m
//  iDragBlackBoard
//
//  Created by Max on 2/21/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "dataliedResultsViewController.h"
#import <math.h>

@interface dataliedResultsViewController ()<JBLineChartViewDataSource,JBLineChartViewDelegate,UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet JBLineChartView *lineChartView;

@property (weak, nonatomic) IBOutlet UILabel *labelWhere;
//@property (nonatomic) NSMutableArray *result;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSString *titleOfChart;
@property (nonatomic) NSArray *chartDataSource;


//@property (weak, nonatomic) IBOutlet UIImageView *UiImageView;

@end

@implementation dataliedResultsViewController


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chartDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CLLocation *location =[[CLLocation alloc]init];
    location = [self.chartDataSource objectAtIndex:indexPath.row];
    CLLocation *firstLocation =[[CLLocation alloc]init];
    firstLocation = self.chartDataSource.firstObject;
    
    NSString *label = [NSString stringWithFormat:@"sec %.2f",[location.timestamp timeIntervalSinceDate:firstLocation.timestamp]];
    
    
    NSString *detailed =[NSString stringWithFormat:@"speed %.2f",location.speed*3.6];
    
    
    
    cell.textLabel.text = label;
    cell.detailTextLabel.text = detailed;
    
    return cell;
}


//pressed cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
}


- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView{
    return 1;
    
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex{
        return self.chartDataSource.count;
    
}


- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex{
   
    CLLocation *location =[[CLLocation alloc]init];
   location = [self.chartDataSource objectAtIndex:horizontalIndex];
    
    return fabs ((CGFloat)location.speed*3.6);
    
    
    
};


- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex{
    return 3;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex{
    return YES;
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView selectionColorForLineAtLineIndex:(NSUInteger)lineIndex{
    return [UIColor blueColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.chartDataSource = [[NSArray alloc]initWithArray:self.curentResults.results];
    self.titleOfChart =self.curentResults.nameOfCar;
    
//    self.result =[[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    self.labelWhere.text = self.curentResults.nameOfCar;
   // NSLog(@"%@",self.result);
    //[self.imageView setImage:[CFCar sharedInstance].image] ;
    
  
    [self.lineChartView setDataSource:self];
    [self.lineChartView setDelegate:self] ;
    [self.lineChartView reloadData];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    self.imageView.image= self.curentResults.imageCar;
  //  self.imageView.image = [CFCar sharedInstance].image;
    self.navigationItem.title =self.curentResults.nameOfCar;
//    for (CLLocation *obj in self.chartDataSource) {
//        NSLog(@"%f",obj.speed);
//    }
  //  self.lineChartView.showsVerticalSelection =NO;
    
    
    
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
