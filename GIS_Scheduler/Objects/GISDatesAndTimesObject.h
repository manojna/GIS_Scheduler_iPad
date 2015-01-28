//
//  GISDatesAndTimesObject.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 28/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISDatesAndTimesObject : NSObject
@property (strong, nonatomic) NSString *dateTime_ID_String;
@property (strong, nonatomic) NSString *requestNo_String;
@property (strong, nonatomic) NSString *chooseReq_ID_String;
@property (strong, nonatomic) NSString *chooseReq_answer_String;
@property (strong, nonatomic) NSString *startDate_String;
@property (strong, nonatomic) NSString *endDate_String;
@property (strong, nonatomic) NSString *startTime_String;
@property (strong, nonatomic) NSString *endTime_String;
@property (strong, nonatomic) NSMutableDictionary *weekDays_dictionary;

@property (strong, nonatomic) NSString *date_String;
@property (strong, nonatomic) NSString *day_String;

@property (strong, nonatomic) NSString *status_String;
@property (strong, nonatomic) NSString *statusCode_String;
@property (strong, nonatomic) NSString *unavailableID_String;
@property (strong, nonatomic) NSString *notes_String;

@property (nonatomic, readwrite) int tagValue;

- (id)initWithStoreDictionary:(NSDictionary *)json;
@end
