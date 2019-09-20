//
//  CFCar.m
//  iDragBlackBoard
//
//  Created by Max on 2/25/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "CFCar.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>

@interface CFCar()  <CLLocationManagerDelegate>
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) BOOL isTimerOn;
@property (nonatomic) CLLocation *previosLocation;



@end
@implementation CFCar

//singltone

+(instancetype) sharedInstance{
    //1
    static id _sharedInstance = nil;
    //2
    static dispatch_once_t oncePredicate;
    //3
    
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[[self class]alloc]init];
        
    });
    return _sharedInstance;
}


//активировать получение данных с ЖПС
-(void)activateLocation{
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc]init];
    }
    //проверяем статус разрешения локейшнменеджера
    if([CLLocationManager locationServicesEnabled]) {
        // Location Services Are Enabled
        switch([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusRestricted:
                NSLog(@"This application is not authorized to use location services.  Due");
                // to active restrictions on location services, the user cannot change
                // this status, and may not have personally denied authorization
                break;
                
                
            case kCLAuthorizationStatusDenied:
                NSLog(@"User has explicitly denied authorization for this application, or");
                // location services are disabled in Settings
                break;
                
            case    kCLAuthorizationStatusAuthorizedWhenInUse:
                NSLog(@"User has granted authorization to use their location only when your app");
                // is visible to them (it will be made visible to them if you continue to
                // receive location updates while in the background).  Authorization to use
                // launch APIs has not been granted.
                
                break;
            case kCLAuthorizationStatusAuthorizedAlways:
                NSLog(@" User has granted authorization to use their location at any time,");
                // including monitoring for regions, visits, or significant location changes.
                
                
                break;
                
            case kCLAuthorizationStatusNotDetermined:
                NSLog(@" User has not yet made a choice with regards to this application");
              //  [self.locationManager requestAlwaysAuthorization];
                [self.locationManager requestWhenInUseAuthorization];
                break;
        }
    } else {
        // Location Services Disabled
    }
    [self.locationManager setDelegate:self];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
   // [self.locationManager startUpdatingLocation];
    
    self.motionManager = [[CMMotionManager alloc]init];
    [self.locationManager startUpdatingLocation];
    [self.motionManager startDeviceMotionUpdates];
    self.previosLocation =[[CLLocation alloc]init];

}

-(void)deactivadeLocalion{
    [self.locationManager stopUpdatingLocation];
    [self.motionManager stopDeviceMotionUpdates];
}

//Start Race
/*
-(void)startRace{
  //  self.resultsOfCurentRace=nil;
    
    [self activateLocation];
    self.motionManager = [[CMMotionManager alloc]init];
    [self.locationManager startUpdatingLocation];
    [self.motionManager startDeviceMotionUpdates];
    
    
    
    
}
//Stop Race

-(void)stopRace{
    [self.locationManager stopUpdatingLocation];
    [self.motionManager stopDeviceMotionUpdates];
    
    
}
*/
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *tempLocation = [[CLLocation alloc]init];
    tempLocation = locations.lastObject;

    self.currentSpeed = tempLocation.speed;
    self.curentLocation = locations.lastObject;
    [[NSNotificationCenter defaultCenter] postNotificationName:CAR_LCATION_UPDATED_NOTIFICATION
                                                        object:self];
    
    if (self.currentSpeed>=100/3.6) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CAR_ACHIEVED_100_NOTIFICATION
                                                            object:self];
        
    }
    if (tempLocation.horizontalAccuracy != self.previosLocation.horizontalAccuracy) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CAR_UPDATED_ACCURACITY_NOTIFICATION
      
                                                            object:self];
        self.previosLocation = tempLocation;
    }
    
    
}

-(void)getCurrentSpeedFromspeed{
    self.curentAcceleration = self.motionManager.deviceMotion.userAcceleration;
    double d=self.motionManager.deviceMotion.userAcceleration.z*10;
    int i=(int) d%10;
    d=(float)i/10;
    self.currentSpeed = self.currentSpeed+d*0.2;
    if (self.currentSpeed>=100/3.6) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CAR_ACHIEVED_100_NOTIFICATION
                                                            object:self];
        
    }
}








//возвращает текущую скорость

-(NSNumber *) getCurentSpeed{
    [self activateLocation];
    [self.locationManager startUpdatingLocation];
    
    return @(self.curentLocation.speed*3.6);
}


//делегат  возвращения скорости


//возвращает текущее ускорение &&&&&&& Проеврить!!!!!

-(CMAcceleration)getCarAcceleration{
     CMMotionManager *motionManager =[[CMMotionManager alloc] init];
    [motionManager startDeviceMotionUpdates];
    return motionManager.deviceMotion.userAcceleration;
}


//гененрирует ИД кар
-(void)generateIdCar{
    NSDate *date =[NSDate date];
    self.idCar=[NSNumber numberWithLongLong:(NSInteger)date+arc4random()%999];
}


- (NSString *)description{
    NSString *str;
    
    str = [NSString stringWithFormat:@"idCar: %@,nameOfCar %@, Wetght %@ maxSpeed %@,acceleration 0-100 %@", self.idCar,self.nameOfCar, self.weight, self.maxSpeed,self.acceleration ];
    
   
    

    return str;
}
@end
