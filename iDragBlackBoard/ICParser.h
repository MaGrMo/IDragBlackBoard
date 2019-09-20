//
//  ICParser.h
//  CarsParser
//
//  Created by Ivan Vasilevich on 2/26/15.
//  Copyright (c) 2015 Ivan Vasilevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICParser : NSObject

- (NSArray *)fetchManufacturers;
- (NSArray *)carsByManufacturer:(NSString *)manufacturer;
- (NSDictionary *)carWithName:(NSString *)name;

@end
