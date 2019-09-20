//
//  ICParser.m
//  CarsParser
//
//  Created by Ivan Vasilevich on 2/26/15.
//  Copyright (c) 2015 Ivan Vasilevich. All rights reserved.
//

#import "ICParser.h"

@interface ICParser ()

@property (nonatomic) int cutIndex;
@property (nonatomic) NSDictionary *manufacturers;

@end

@implementation ICParser

- (NSDictionary *)manufacturers{
    if (!_manufacturers) {
//        _manufacturers =
        _manufacturers = [NSMutableDictionary new];
        
        NSData *dataOfSource = [ICParser dataFromLink:@"http://www.infocar.com.ua/catalog/"];
        NSString *fullSource = [[NSString alloc] initWithData:dataOfSource encoding:NSWindowsCP1251StringEncoding];
        NSMutableString *nuzhniyKusok = [[ICParser stringBetweenOpenString:@"bg4" closeString:@"Самые популярные модели в автокаталоге" inData:fullSource] mutableCopy];
        
        
        
        for (int i = 0; i < 400; i++) {
            [ICParser stringBetweenOpenString:@"<a href=/catalog/" closeString:@"</a>" inData:nuzhniyKusok];
            
            NSString *manufacturerData = [ICParser stringBetweenOpenString:@"<a href=/catalog/" closeString:@"</a>" inData:nuzhniyKusok];
            
            [nuzhniyKusok deleteCharactersInRange:NSMakeRange(0, manufacturerData.length)];
            
            
            
            NSString *manufacturerLink = [[manufacturerData componentsSeparatedByString:@" "] firstObject];
            if (manufacturerLink == nil) {
                break;
            }
            NSString *manufacturerName = [[manufacturerData componentsSeparatedByString:@">"] lastObject];
            
            ((NSMutableDictionary *)_manufacturers)[manufacturerName] = manufacturerLink;
            //        NSLog(@"name: %@ link: %@",manufacturerName, manufacturerLink);
            
        }
    }
    return _manufacturers;
}

- (NSArray *)fetchManufacturers{
    return [self.manufacturers allKeys];
}

- (NSArray *)carsByManufacturer:(NSString *)manufacturer{
    NSString *manLink = [NSString stringWithFormat:@"http://www.infocar.com.ua/catalog/%@", [self.manufacturers objectForKey:manufacturer]];
    NSLog(@"manufacturer: %@", manLink);
    NSData *carsListData = [ICParser dataFromLink:manLink];
    NSString *fullSource = [[NSString alloc] initWithData:carsListData encoding:NSWindowsCP1251StringEncoding];
   
    NSMutableString *nuzhniyKusok = [[ICParser stringBetweenOpenString:@"<li>" closeString:@"</table>" inData:fullSource] mutableCopy];
    
    NSMutableDictionary *cars = [NSMutableDictionary new];
    
    for (int i = 0; i < 400; i++) {
        [ICParser stringBetweenOpenString:@"<a href=/catalog/" closeString:@"</a>" inData:nuzhniyKusok];
        
        NSString *manufacturerData = [ICParser stringBetweenOpenString:@"href=/catalog/" closeString:@"</a>" inData:nuzhniyKusok];
        
        [nuzhniyKusok deleteCharactersInRange:NSMakeRange(0, manufacturerData.length)];
        
        
        
        NSString *manufacturerLink = [[manufacturerData componentsSeparatedByString:@" "] firstObject];
        if (manufacturerLink == nil) {
            break;
        }
        NSString *manufacturerName = [[manufacturerData componentsSeparatedByString:@">"] lastObject];
        manufacturerName = [[manufacturerName componentsSeparatedByString:@";"] lastObject];
        
        cars[manufacturerName] = manufacturerLink;
        //        NSLog(@"name: %@ link: %@",manufacturerName, manufacturerLink);
        
    }
    NSLog(@"%@", cars);
    return cars.allKeys;
}



- (NSDictionary *)carWithName:(NSString *)name{
    return nil;
}



+ (NSData *)dataFromLink:(NSString *)link{
    
    NSLog(@"data from link:%@", link);
    
    NSData *fetchedData = nil;
    
    NSMutableURLRequest *req = [ICParser createReqByLink:link];
    
    fetchedData = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:NULL];
    
    return fetchedData;
    
}

+ (NSString *)stringBetweenOpenString:(NSString *)openStr
                          closeString:(NSString *)closeStr
                               inData:(id)data{
    
    NSString *clearStr;
    @try {
        NSMutableString *dataFileString = ([data isKindOfClass:[NSData class]]) ? [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] mutableCopy] : [data mutableCopy];
        
        NSRange tagRange = [dataFileString rangeOfString:openStr];
        
//        NSLog(@"1qwertyuiop %@", dataFileString);
        
        [dataFileString deleteCharactersInRange:NSMakeRange(0, tagRange.location+tagRange.length)];
//        NSLog(@"2qwertyuiop %@", dataFileString);
        
        NSRange endTagRange = [dataFileString rangeOfString:closeStr];
        
        clearStr = [dataFileString
                    substringWithRange:NSMakeRange(0, endTagRange.location)];
        
        //        self.cutLocation =
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    return clearStr;
    
    
}

+ (NSString *)stringBetweenOpenString:(NSString *)openStr
                          closeString:(NSString *)closeStr
                               inData:(id)data
                            startWith:(NSString *)start{
    NSRange rangeToStart = [data rangeOfString:start];
    NSLog(@"substr3");
    NSString *result;
    @try {
        result = [ICParser stringBetweenOpenString:openStr closeString:closeStr inData:[data substringFromIndex:rangeToStart.location + rangeToStart.length]];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        return result;
    }
    return result;
    
}

+ (NSMutableURLRequest *)createReqByLink:(NSString *)link{
    
    if ([link containsString:@"/api/"]) {
        NSRange rangeAfterApiSlash = [link rangeOfString:@"/api/"];
        //    NSLog(@"substr 9");
        NSLog(@"substr2");
        NSMutableString *afterApi = [[link substringFromIndex:rangeAfterApiSlash.location + rangeAfterApiSlash.length] mutableCopy];
        
        NSString *requestString = [NSString stringWithFormat:@"http://%@:@/api/%@", @"duet.net.ua", afterApi];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString]];
        [request setHTTPMethod:@"GET"];
        return request;
        
    } else {
        
        
        NSString *requestString = link;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString]];
        [request setHTTPMethod:@"GET"];
        return request;
        
    }
    
    
}



@end
