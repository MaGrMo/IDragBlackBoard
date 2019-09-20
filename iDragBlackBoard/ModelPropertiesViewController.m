//
//  ModelPropertiesViewController.m
//  iDragBlackBoard
//
//  Created by Max on 3/1/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "ModelPropertiesViewController.h"
#import "guarageViewController.h"
#import "carEditViewController.h"
@interface ModelPropertiesViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) NSMutableDictionary *propertyOfModel;


@end

@implementation ModelPropertiesViewController


- (IBAction)gestureRecognizer:(UITapGestureRecognizer *)sender {
//    if (!self.isForedit) {

        //если имя непоменяно то присвоить имя
        if ([[self.propertyOfModel objectForKey:@"name"] isEqualToString:@"no Name"]) {
            [self.propertyOfModel setObject:[self.brand stringByAppendingString:self.title] forKey:@"name"];
    }
        
    NSMutableArray *garagePlist =[[NSMutableArray alloc]initWithContentsOfURL:[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"garage.plist"]];
    
        //проверяем создалься ли гаражплист из файла если нет то создаем
        if (!garagePlist) {
            garagePlist = [[NSMutableArray alloc]init];
        }

        //добавляем картинку для машины в гараже

        if ([[[self.navigationController.viewControllers objectAtIndex:1] listOfBrandsAndImages] objectForKey:self.brand] != [NSData new]) {
            self.propertyOfModel [@"image"]= [[[self.navigationController.viewControllers objectAtIndex:1] listOfBrandsAndImages] objectForKey:self.brand];
        } else{
            self.propertyOfModel [@"image"]= UIImagePNGRepresentation([UIImage imageNamed:@"noBrand.png"]) ;
        }
        //добавляем машину
        [garagePlist addObject:self.propertyOfModel];
        //все записываем в файлик
    [garagePlist writeToURL:[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"garage.plist"] atomically:NO];
    
    //  [garagePlist writeToFile:@"/Users/max/Developer/iDragBlackBoard/data/garage.plist" atomically:YES];
        
       //[[self.navigationController.viewControllers firstObject] setCarsInGarage:self.carToSend];
//    } else{
        
//    }
   
    //переход к меню гараж
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.propertyOfModel.allKeys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *property = [self.propertyOfModel.allKeys objectAtIndex:indexPath.row];
    NSString *valueForProperty =[self.propertyOfModel.allValues objectAtIndex:indexPath.row];
    cell.textLabel.text = property;
    cell.detailTextLabel.text = valueForProperty;
    
    return cell;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"UYUc %@",self.propertyOfModel);
    if (!self.propertyOfModel) {
        self.propertyOfModel = [[NSMutableDictionary alloc] initWithDictionary:self.propertyOfModelFrom copyItems:YES];
    }
   
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    

    
    CIImage *image = [[CIImage alloc] initWithImage:[[self.navigationController.viewControllers objectAtIndex:1] curentImage]];
    self.imageView.image = [[UIImage alloc]initWithCIImage:image];
    image =nil;
   // NSString *barnd = [[NSString alloc]initWithString:@" "];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    if (![self.propertyOfModel objectForKey:@"name"]) {
        //[self.propertyOfModel setObject:@"no Name" forKey:@"name"];
        

        self.propertyOfModel[@"name"]=@"no Name";
    }
    
}
//-(void)viewWillDisappear:(BOOL)animated{
//    [[self.navigationController.viewControllers objectAtIndex:1] setListOfBrandsAndImages:nil ];
//    
//    
//  //  carEditViewController.listOfBrandsAndImages=nil;
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSURL* ) applicationDocumentsDirectory{
    //returns URL for Doc directory
    
    
    return  [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
