//
//  Resuls.m
//  iDragBlackBoard
//
//  Created by Max on 3/4/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "Resuls.h"
#import "CFCar.h"
@interface Resuls ()<NSCoding>
@end

@implementation Resuls  


-(NSData*)dataWithResults:(Resuls *)results{
   
    return [NSKeyedArchiver archivedDataWithRootObject:results];
}
-(Resuls*)resultsWithData:(NSData *)data{
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
}
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.nameOfCar = [decoder decodeObjectForKey:@"nameOfCar"];
        self.idCar = [decoder decodeObjectForKey:@"idCar"];
        self.imageCar = [decoder decodeObjectForKey:@"imageCar"];
        self.results = [decoder decodeObjectForKey:@"results"];
        self.accelerometrDatasOfDate = [decoder decodeObjectForKey:@"accelerometrDatasOfDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.nameOfCar forKey:@"nameOfCar"];
    [encoder encodeObject:self.idCar forKey:@"idCar"];
    [encoder encodeObject:self.imageCar forKey:@"imageCar"];
    [encoder encodeObject:self.results forKey:@"results"];
    [encoder encodeObject:self.accelerometrDatasOfDate forKey:@"accelerometrDatasOfDate"];
}

@end
