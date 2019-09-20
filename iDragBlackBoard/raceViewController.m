//
//  raceViewController.m
//  iDragBlackBoard
//
//  Created by Max on 2/21/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "raceViewController.h"
#import "dataliedResultsViewController.h"
#import "CFCar.h"
#import "Resuls.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>

@interface raceViewController ()<UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *sateliteImageView;
@property (weak, nonatomic) IBOutlet UILabel *curentSpeedLabel;
@property (strong, nonatomic) IBOutlet UIView *workView;
@property (weak, nonatomic) IBOutlet UILabel *curentGLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startStopLabel;
@property (weak, nonatomic) IBOutlet UIView *startStopView;
@property (weak, nonatomic) IBOutlet UILabel *accuraceLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *arrowView;


@property (nonatomic) NSMutableArray *results;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *curentLocation;
@property (nonatomic) CLLocation *startLocation;
@property (nonatomic) BOOL isUpdatingLocations;
@property (nonatomic) CMMotionManager *motionManager;
@property (nonatomic) CMAcceleration curentAcceleration;
@property (nonatomic) NSMutableDictionary *curentResults;
@property (nonatomic) BOOL isAchiveQuater;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) NSArray *arrayImages;
@property (nonatomic) int i ;




@property (nonatomic) BOOL isStart;
@end


@implementation raceViewController

//таблица
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.curentResults.allKeys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
    cell.textLabel.text = [self.curentResults.allKeys objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self.curentResults valueForKey:[self.curentResults.allKeys objectAtIndex:indexPath.row]]];
    return cell;
}
/*
- (IBAction)detailedResults:(UIButton *)sender {
    [self performSegueWithIdentifier:@"toDetaliedResultsFromRace" sender:sender];
}
*/


- (IBAction)tapStartStop:(UITapGestureRecognizer *)sender {
    
    if (!self.isStart) {
         [self stopRace];

      
        self.isStart = !self.isStart;
        
            }else{
     
                [self prapadePictures];
                 self.isStart = !self.isStart;

    
        
        
            }
    
}
-(void)prapadePictures
{
    self.arrayImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"3.png"],
                        [UIImage imageNamed:@"2.png"],
                        [UIImage imageNamed:@"1.png"],nil];
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:self.workView.bounds];
    
    
   
    [self.workView addSubview:imageView];
 //   self.isStart= !self.isStart;
    
    
    self.timer =[NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(changePictures) userInfo:NULL repeats:YES];
                 
    
    NSLog(@"wertyui");
    
   
    
}
-(void)changePictures
{
    if (self.i == 0) {
        [self.workView.subviews.lastObject setBackgroundColor:[UIColor redColor]];
    }
    if (self.i==1) {
        [self.workView.subviews.lastObject setBackgroundColor:[UIColor colorWithRed:224.0/256 green:175.0/256 blue:2.0/256 alpha:1]];
        
    }
    if (self.i==2) {
        [self.workView.subviews.lastObject setBackgroundColor:[UIColor colorWithRed:1.0/256 green:140.0/256 blue:11.0/256 alpha:1]];
    }

    [UIView transitionWithView:self.workView.subviews.lastObject duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
               [self.workView.subviews.lastObject setImage:[self.arrayImages objectAtIndex:self.i]];
    } completion:NULL];
        if (self.i < self.arrayImages.count-1) {
        self.i++;
    }else{
     //  [self.workView.subviews.lastObject removeFromSuperview];
         [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(clearPictures) userInfo:NULL repeats:NO];
        
        
        [self.timer invalidate];
        
        
        
        self.i =0;
        
    }


}
-(void) clearPictures

{
    
        NSLog(@"Clear Pictures");
        self.arrayImages = nil;
        [self.workView.subviews.lastObject removeFromSuperview];
        [self startRace];
    

    
}

//проверка положения девайса
-(NSString*)checkDeviceOrientation{
    float x =fabs(self.motionManager.accelerometerData.acceleration.x), y=fabs(self.motionManager.accelerometerData.acceleration.y),z=fabs(self.motionManager.accelerometerData.acceleration.z);
    if (x>z && x>y) {
        return @"x";
    }
    if (z>x && z>y) {
        return @"z";
    }
    if (y>x && y>z) {
        return @"y";
    }
    return nil;
}


//начало гонки
-(void)startRace{
    self.results = nil;
    self.results = [NSMutableArray new];
 
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CarUpdatedLocationNotification:) name:CAR_LCATION_UPDATED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(carAchevedTheHundretNotification:) name:CAR_ACHIEVED_100_NOTIFICATION object:nil];
    
    
    self.startStopLabel.text = @"STOP";
    self.isUpdatingLocations = YES;
    self.startStopView.backgroundColor =[UIColor colorWithRed:173.0/256.0 green:40.0/256.0 blue:81.0/256.0  alpha:1];
  //  self.isStart =!self.isStart;
    
}

//Конец Гонки
-(void)stopRace{
    

    self.arrowView.transform = CGAffineTransformMakeRotation(0);
    self.startStopLabel.text=@"START";
    self.isUpdatingLocations = NO;
    self.startStopView.backgroundColor =[UIColor colorWithRed:20.0/256.0 green:164.0/256.0 blue:202.0/256.0 alpha:1];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:CAR_LCATION_UPDATED_NOTIFICATION
                                                  object:nil];
  //  self.isStart =!self.isStart;
    [self performSegueWithIdentifier:@"toDetaliedResultsFromRace" sender:nil];
}


//метод выполняемый при том как машина обновила свое  локейшн
-(void)CarUpdatedLocationNotification:(NSNotification *)notification{
    CLLocation *locationBegin = [[CLLocation alloc] init];
    [self.results addObject:[CFCar sharedInstance].curentLocation];
    locationBegin =self.results.firstObject;
    CLLocation *curentlocation = [[CLLocation alloc]init];
    curentlocation = self.results.lastObject;
    self.curentSpeedLabel.text =[NSString stringWithFormat:@"%.2f",curentlocation.speed*3.6];
    float angle = curentlocation.speed*3.6*1.125*M_PI /180;
    self.arrowView.transform = CGAffineTransformMakeRotation(angle);
    self.distanceLabel.text = [NSString stringWithFormat:@"%.0f",[curentlocation distanceFromLocation:locationBegin ]];
    NSDate *dateBegin =[[NSDate alloc] init];
    NSDate *dateEnd =[[NSDate alloc] init];
    dateBegin = locationBegin.timestamp;
    dateEnd = curentlocation.timestamp;
    self.timeLabel.text = [NSString stringWithFormat:@"%.2f",[dateEnd timeIntervalSinceDate:dateBegin]];
    if ([curentlocation distanceFromLocation:locationBegin ] >= 402 && !self.isAchiveQuater ) {
        self.curentResults [@"0-402m for s"] = @([curentlocation.timestamp timeIntervalSinceDate:locationBegin.timestamp]);
        self.curentResults [@"speed on exit"] = @(curentlocation.speed*3.6);
        [self.tableView reloadData];
        self.isAchiveQuater = YES;
    }
}
//метод проверки и вывода на Экран точности измерения
-(void)UpdatedAccuracityNotification{
    double accuracyty =[CFCar sharedInstance].curentLocation.horizontalAccuracy;
    if (accuracyty<=5) {
        self.sateliteImageView.backgroundColor = [UIColor greenColor];
    }
    if (accuracyty <20 && accuracyty>5) {
        self.sateliteImageView.backgroundColor = [UIColor yellowColor];
    }
    if (accuracyty >20) {
        self.sateliteImageView.backgroundColor = [UIColor redColor];
    }
    
}

// случайный цвет

-(UIColor *)randomColor{
    

    return [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    
    
}

//метод выполняемый при достижении 100 км/ч
-(void)carAchevedTheHundretNotification:(NSNotification *)notification{
    CLLocation *temp =[[CLLocation alloc]init];
    temp = [CFCar sharedInstance].curentLocation;
    CLLocation *locationBegin = [[CLLocation alloc] init];
    locationBegin = self.results.firstObject;
    NSDate *dateStart =[[NSDate alloc] init];
    dateStart = locationBegin.timestamp;
    
    self.curentResults [@"time to 100"]=[NSString stringWithFormat:@"%.2f",[temp.timestamp timeIntervalSinceDate:dateStart]];
    self.curentResults [@"distans to 100"]=[NSString stringWithFormat:@"%.2f",[temp distanceFromLocation:[self.results firstObject]]];
    
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:CAR_ACHIEVED_100_NOTIFICATION
                                                object:nil];
}

//МВС
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    self.isStart = YES;
    self.i =0;
  //  self.sateliteImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow.png"]];
    self.sateliteImageView.image = [UIImage imageNamed:@"satelite1.png"];
    
    
    self.sateliteImageView.backgroundColor = [UIColor redColor];
    
    
    
   // self.tabBarItem.title = [CFCar sharedInstance].nameOfCar;
    
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.curentResults = [NSMutableDictionary new];
    [[CFCar sharedInstance] activateLocation];
    self.isAchiveQuater = NO;
    
 self.results = [[NSMutableArray alloc] init];
    self.curentResults =[[NSMutableDictionary alloc]init];
    self.imageView.image = [CFCar sharedInstance].image;
    self.navigationItem.title =[CFCar sharedInstance].nameOfCar;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdatedAccuracityNotification) name:CAR_UPDATED_ACCURACITY_NOTIFICATION object:nil];
    [self.motionManager startAccelerometerUpdates];
    
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[CFCar sharedInstance] deactivadeLocalion];
     self.results = nil;
    self.curentResults=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:CAR_UPDATED_ACCURACITY_NOTIFICATION
                                                  object:nil];
    
}



-(void)endOfRace{
    
    [self performSegueWithIdentifier:@"toDetaliedResultsFromRace" sender:self];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toDetaliedResultsFromRace"]) {
       
            if ([segue.destinationViewController isKindOfClass:[dataliedResultsViewController class]]) {
                Resuls *curentResult = [[Resuls alloc]init];
                curentResult.results =[[NSArray alloc]initWithArray:self.results];
                curentResult.nameOfCar = [CFCar sharedInstance].nameOfCar;
                curentResult.imageCar = [CFCar sharedInstance].image;
                curentResult.idCar = [CFCar sharedInstance].idCar;
                [self writeToFile:curentResult];
                [segue.destinationViewController setCurentResults:curentResult];
                
            }
        
    }
}

-(NSURL* ) applicationDocumentsDirectory{
    //returns URL for Doc directory
    
    
    return  [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)writeToFile:(Resuls *)result{
    
    NSMutableArray *tempArray =[[NSMutableArray alloc]initWithContentsOfURL:[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"results.plist"]];
    if (!tempArray) {
        tempArray =[[NSMutableArray alloc]init];
    }
        [tempArray addObject:[result dataWithResults:result]];
        [tempArray writeToURL:[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"results.plist"] atomically:NO];
}




@end
