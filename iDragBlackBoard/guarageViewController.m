//
//  guarageViewController.m
//  iDragBlackBoard
//
//  Created by Max on 2/20/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "guarageViewController.h"
#import "CarEditInGarageViewController.h"
#import "CFCar.h"

@interface guarageViewController ()<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *carsInGarage;
//@property (nonatomic) NSArray *listOfBrands;
//@property (nonatomic) NSArray *namesOfTheCars;
@property (nonatomic) int selectedCarIndex;

@end

@implementation guarageViewController
//pressed + button
- (IBAction)btnPressed:(UIButton *)sender {
//    self.carsInGarage =nil;
    [self performSegueWithIdentifier:@"toNewCar" sender:sender];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.carsInGarage.count;
}

//pressed cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //вызывает переход на редактирование модели
    [self createCarFromArrayAtIndex:indexPath.row];
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Selected Car" message:[CFCar sharedInstance].nameOfCar delegate:nil cancelButtonTitle:@"close" otherButtonTitles:nil, nil];
    
    
    [alert show];
   
    
}

//создаем машину
-(void)createCarFromArrayAtIndex:(int)index{
    //гунурируем ИД
    [[CFCar sharedInstance] generateIdCar];
    //создаем Имаже
    UIImage *image =[[UIImage alloc]initWithData:[[self.carsInGarage objectAtIndex:index] objectForKey:@"image"]];
    [CFCar sharedInstance].image = image;
   // [CFCar sharedInstance].image = [[self.carsInGarage objectAtIndex:index] objectForKey:@"image"];
    //имя машины
    [CFCar sharedInstance].nameOfCar = [[self.carsInGarage objectAtIndex:index] objectForKey:@"name"];
    
    //крутящий момент
    if (![[[self.carsInGarage objectAtIndex:index] objectForKey:@"Крутящий момент, Нм/об мин"] isEqualToString:[NSString new]]) {
        NSString *str = [NSString stringWithFormat:@"%@",
                         [[self.carsInGarage objectAtIndex:index]
                          objectForKey:@"Крутящий момент, Нм/об мин"]] ;
        [CFCar sharedInstance].torque = [self numberFromString:[[str componentsSeparatedByString:@"/"] firstObject]];
        
        //     NSLog(@"torque is %@",[CFCar sharedInstance].torque);
        
    }else{
        [CFCar sharedInstance].torque = @(0);
        
    }
    
    //полная масса
    if (![[[self.carsInGarage objectAtIndex:index] objectForKey:@"Полная масса "] isEqualToString:[NSString new]]) {
        [CFCar sharedInstance].weight =[self numberFromString:[[self.carsInGarage objectAtIndex:index] objectForKey:@"Полная масса "]];
    }else{
        [CFCar sharedInstance].weight =@(0);
        
    }
    //Максимальная скорость, км/час
    
    if (![[[self.carsInGarage objectAtIndex:index] objectForKey:@"Максимальная скорость, км/час"] isEqualToString:[NSString new]]) {
        [CFCar sharedInstance].maxSpeed =[self numberFromString:[[self.carsInGarage objectAtIndex:index] objectForKey:@"Максимальная скорость, км/час"]];
    }else{
        [CFCar sharedInstance].maxSpeed =@(0);
        
    }
    //Объем двигателя, куб. см
    if (![[[self.carsInGarage objectAtIndex:index] objectForKey:@"Объем двигателя, куб. см"] isEqualToString:[NSString new]]) {
        [CFCar sharedInstance].engineValue =[self numberFromString:[[self.carsInGarage objectAtIndex:index] objectForKey:@"Объем двигателя, куб. см"]];
    }else{
        [CFCar sharedInstance].engineValue =@(0);
        
    }
    
    //Мощность, л.с./об мин
    
    if (![[[self.carsInGarage objectAtIndex:index] objectForKey:@"Мощность, л.с./об мин"] isEqualToString:[NSString new]]) {
        NSString *str = [NSString stringWithFormat:@"%@",
                         [[self.carsInGarage objectAtIndex:index]
                          objectForKey:@"Мощность, л.с./об мин"]] ;
        [CFCar sharedInstance].horsePower = [self numberFromString:[[str componentsSeparatedByString:@"/"] firstObject]];
        
        //     NSLog(@"torque is %@",[CFCar sharedInstance].torque);
        
    }else{
        [CFCar sharedInstance].horsePower = @(0);
        
    }
    //Разгон до 100 км/час, с
    if (![[[self.carsInGarage objectAtIndex:index] objectForKey:@"Разгон до 100 км/час, с"] isEqualToString:[NSString new]]) {
        [CFCar sharedInstance].acceleration =[self numberFromString:[[self.carsInGarage objectAtIndex:index] objectForKey:@"Разгон до 100 км/час, с"]];
    }else{
        [CFCar sharedInstance].acceleration =@(0);
        
    }
    //Тип кузова
    if (![[[self.carsInGarage objectAtIndex:index] objectForKey:@"Тип кузова"] isEqualToString:[NSString new]]) {
        [CFCar sharedInstance].typeOfBody =[[self.carsInGarage objectAtIndex:index] objectForKey:@"Тип кузова"];
    }else{
        [CFCar sharedInstance].typeOfBody =@"";
        
    }
    
}

//перевод строки  в Число  0 если не возможно;

-(NSNumber *)numberFromString:(NSString *)string{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [f numberFromString:string];
    
    if (myNumber) {
        return myNumber;
    }else{
        return @(0);
    }
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toEditCars"]) {
        
        if ([segue.destinationViewController isKindOfClass:[CarEditInGarageViewController class]]) {
            [segue.destinationViewController setCarToEdit:[self.carsInGarage objectAtIndex:self.selectedCarIndex]];
            
            
        }
        
    }
}


 
//возвращает отсортированный массив словарей по значениям клуча @"name" Мего круто

-(NSMutableArray *)sortedArrayForName:(NSArray *)array{
    NSArray *tempArray = [NSMutableArray new];
    NSMutableArray *sortedByNames = [NSMutableArray new];
    NSMutableArray *result = [NSMutableArray new];
    for (int i =0 ; i<array.count; i++) {
        [sortedByNames addObject:[[array objectAtIndex:i] objectForKey:@"name"]];
    
    }
    tempArray = [sortedByNames sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in tempArray) {
        for (int i = 0; i<array.count; i++) {
            if ([[[array objectAtIndex:i] objectForKey:@"name"] isEqualToString:key]) {
                [result addObject:[array objectAtIndex:i]];
            }
        }
    }
    
    return result;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 //  self.navigationItem.leftBarButtonItem = self.editButtonItem;

    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
//    NSLog(@"%@",[self applicationDocumentsDirectory]);
    NSMutableArray *tempArray =[[NSMutableArray alloc]initWithContentsOfURL:[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"garage.plist"]];
    
    NSMutableArray *carsNames =[NSMutableArray new];
    self.carsInGarage = [self sortedArrayForName:tempArray];
    for (int i=0; i<tempArray.count; i++) {
        [carsNames addObject:[[tempArray objectAtIndex:i] objectForKey:@"name"] ];
    }
    tempArray = nil;
    carsNames = nil;
    
   
}

-(NSURL* ) applicationDocumentsDirectory{
    //returns URL for Doc directory
    
    
    return  [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
//fullfill table by cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *curentCar = [[NSDictionary alloc]initWithDictionary:[self.carsInGarage objectAtIndex:indexPath.row]];
    NSString *label = [curentCar objectForKey:@"name"];
    
    
    NSMutableString *detailed =[NSMutableString new];
    for (NSString *key in curentCar.allKeys) {
        if (![key isEqualToString:@"name"] && ![key isEqualToString:@"image"]) {
            [detailed appendString:key];
            [detailed appendString:@" : "];
            [detailed appendString:@"'"];
            [detailed appendString:[curentCar objectForKey:key]];
            [detailed appendString:@"'"];
            [detailed appendString:@" ; "];
            
        }
        
    }
    
    
    cell.textLabel.text = label;
    cell.detailTextLabel.text = detailed;
    cell.imageView.image = [[UIImage alloc]initWithData:[curentCar objectForKey:@"image"]];
    
    return cell;
}
//pressed ! button
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{

    self.selectedCarIndex = indexPath.row;
    [self performSegueWithIdentifier:@"toEditCars" sender:tableView];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//vethod delete of cars in garage
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.carsInGarage removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.carsInGarage writeToURL:[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"garage.plist"] atomically:NO];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
