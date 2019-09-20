//
//  CourseGetter.h
//  Convertor
//
//  Created by Ivan Vasilevich on 1/25/15.
//  Copyright (c) 2015 Ivan Vasilevich. All rights reserved.
//

#import <Foundation/Foundation.h>

#define COURSE_RECIVED_NOTIFICATION @"COURSE_RECIVED_NOTIFICATION"
#define COURSE_KEY @"COURSE_KEY"

@interface CourseGetter : NSObject

+ (void)getCurrencyCourseForCCode:(NSString *)code;


@end
