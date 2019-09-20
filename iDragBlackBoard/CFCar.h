//
//  CFCar.h
//  iDragBlackBoard
//
//  Created by Max on 2/25/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <UIKit/UIKit.h>
#define CAR_LCATION_UPDATED_NOTIFICATION @"CAR_LCATION_UPDATED_NOTIFICATION"
#define CAR_ACHIEVED_100_NOTIFICATION @"CAR_ACHIEVED_100_NOTIFICATION"
#define CAR_UPDATED_ACCURACITY_NOTIFICATION @"CAR_UPDATED_ACCURACITY_NOTIFICATION"

@interface CFCar : NSObject<CLLocationManagerDelegate>
@property (nonatomic) NSNumber *idCar;
// Уникальный Идентификатор машины;
@property (nonatomic) NSString *nameOfCar;
//  Name Of Car
@property (nonatomic) NSString *markOfCar;
// Mark of Car
@property (nonatomic) NSString *model;
//model Of Car
//@property (nonatomic) NSDate *year;
//year of Manufacture
@property (nonatomic) CLLocationSpeed currentSpeed;
//Curent speed of the car
@property (nonatomic) NSNumber *maxSpeed;
//weight Of the Car
@property (nonatomic) NSNumber *weight;
//acceleration 0-100 kmph
@property (nonatomic) NSNumber *acceleration;
//Brake Horse power
@property (nonatomic) NSNumber  *horsePower;
//Krutiashiy moment
@property (nonatomic) NSNumber  *torque;
//type of the body
@property (nonatomic) NSString *typeOfBody;
//foto of the car;
//@property (nonatomic) UIImage *image;
//engine volume
@property (nonatomic) NSNumber *engineValue;
//image of car
@property(nonatomic)UIImage *image;
//results Of ceruntRace
//@property (nonatomic) NSMutableArray *resultsOfCurentRace;
//curent Location
@property (nonatomic) CLLocation *curentLocation;
//curent acceleration
@property (nonatomic)  CMAcceleration curentAcceleration;
//device motion manager
@property (nonatomic) CMMotionManager *motionManager;



//--------METHODS_-----------------------
//singlon
+(instancetype) sharedInstance;
//method generates uniq ID of The car;
-(void)generateIdCar;
//return description
- (NSString *)description;
//return curent Spped
//-(NSNumber *) getCurentSpeed;
//-(void)getCurrentSpeed;
//return Curent Accelerations range;
-(CMAcceleration)getCarAcceleration;
-(void)activateLocation;
-(void)deactivadeLocalion;
// delegates Methods--------------------
//requaried
//-(void)startRace;
//-(CLLocation *)acceleratedtoSpeed:(float)speed;
//-(void)stopRace;








@end
