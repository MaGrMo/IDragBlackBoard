//
//  Resuls.h
//  iDragBlackBoard
//
//  Created by Max on 3/4/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFCar.h"
#include <TargetConditionals.h>
#import <objc/NSObject.h>
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSZone.h>
@interface Resuls : NSObject
@property (nonatomic) NSString *nameOfCar;
@property (nonatomic) NSNumber *idCar;
@property (nonatomic) UIImage *imageCar;
//массив СЛЛокатион
@property (nonatomic) NSArray *results;
//словарь Ускорений от Времени

@property (nonatomic) NSDictionary *accelerometrDatasOfDate;
//@property (nonatomic) NSMutableDictionary *detailedResults;

-(NSData*)dataWithResults:(Resuls *)results;
-(Resuls*)resultsWithData:(NSData *)data;


@end
