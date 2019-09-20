//
//  CourseGetter.m
//  Convertor
//
//  Created by Ivan Vasilevich on 1/25/15.
//  Copyright (c) 2015 Ivan Vasilevich. All rights reserved.
//

#import "CourseGetter.h"

@implementation CourseGetter

+ (void)getCurrencyCourseForCCode:(NSString *)code{
    
    NSURL *nbuCourseURL = [NSURL URLWithString:@"http://www.bank.gov.ua/control/uk/curmetal/detail/currency?period=daily"];
    
    NSData *dataFromNBU = [NSData dataWithContentsOfURL:nbuCourseURL];
    
    NSDictionary *userInfoForNotification = nil;
    
    
    if (dataFromNBU != nil) {
        
        
        @try {
            NSMutableString *sourceOfNBUPage = [[[NSString alloc] initWithData:dataFromNBU encoding:NSUTF8StringEncoding] mutableCopy];
            
            
            
            NSString *codeWithPrants = [NSString stringWithFormat:@">%@<", code];
            
            NSRange startRange = [sourceOfNBUPage rangeOfString:codeWithPrants];
            
            [sourceOfNBUPage deleteCharactersInRange:NSMakeRange(0, startRange.location)];
            
            NSRange endRange = [sourceOfNBUPage rangeOfString:@"</tr>"];
            
            [sourceOfNBUPage deleteCharactersInRange:NSMakeRange(endRange.location, sourceOfNBUPage.length - endRange.location)];
            
            
            
            //        ^[0-9]{4}$
            
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]{1,}[.][0-9]{4}"
                                          
                                                                                   options:NSRegularExpressionCaseInsensitive
                                          
                                                                                     error:nil];
            
            NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:sourceOfNBUPage options:0 range:NSMakeRange(0, [sourceOfNBUPage length])];
            
            
            
            NSString *neededStr = [sourceOfNBUPage substringWithRange:rangeOfFirstMatch];
            
            
            userInfoForNotification = @{COURSE_KEY:neededStr};
            
            
        }
        @catch (NSException *exception) {
            userInfoForNotification = @{COURSE_KEY:@"Exception"};
        }
        @finally {
            
        }
        
    } else {
        userInfoForNotification = @{COURSE_KEY:@"error"};
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:COURSE_RECIVED_NOTIFICATION object:self userInfo:userInfoForNotification];
}

@end
