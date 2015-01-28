//
//  GISSearchReqObject.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 10/06/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISSearchReqObject : NSObject

@property(nonatomic,strong) NSString *chooseRequest_string;
@property(nonatomic,strong) NSString *chooseRequest_ID_string;

@property(nonatomic,strong) NSString *from_string;
@property(nonatomic,strong) NSString *to_string;
@property(nonatomic,strong) NSString *startTime_string;
@property(nonatomic,strong) NSString *endTime_string;

@property(nonatomic,strong) NSString *department_string;
@property(nonatomic,strong) NSString *primaryAudience__string;
@property(nonatomic,strong) NSString *registeredConsumers_string;
@property(nonatomic,strong) NSString *location_string;
@property(nonatomic,strong) NSString *eventType_string;
@property(nonatomic,strong) NSString *modeOf_string;

@property(nonatomic,strong) NSString *department_ID_string;
@property(nonatomic,strong) NSString *primaryAudience_ID_string;
@property(nonatomic,strong) NSString *registeredConsumers_ID_string;
@property(nonatomic,strong) NSString *location_ID_string;
@property(nonatomic,strong) NSString *eventType_ID_string;
@property(nonatomic,strong) NSString *modeOf_ID_string;

@property(nonatomic,strong)  NSMutableDictionary *weekDays_dictionary;

////Search Results
@property(nonatomic,strong) NSString *endTime_result_string;
@property(nonatomic,strong) NSString *eventTitle_result_string;
@property(nonatomic,strong) NSString *requestID_result_string;
@property(nonatomic,strong) NSString *requestNumber_result_string;
@property(nonatomic,strong) NSString *requestStatus_result_string;
@property(nonatomic,strong) NSString *requestedDate_result_string;
@property(nonatomic,strong) NSString *startTime_result_string;
@property(nonatomic,strong) NSString *status_result_string;
@property(nonatomic,strong) NSString *statusCode_result_string;


////Service Provider Search Unfilled/Request Jobs
@property(nonatomic,strong) NSString *serviceType_string;
@property(nonatomic,strong) NSString *serviceType_ID_string;

@property(nonatomic,strong) NSString *generalLocation_string;
@property(nonatomic,strong) NSString *generalLocation_ID_string;

@property(nonatomic,strong) NSString *payLevel_string;
@property(nonatomic,strong) NSString *payLevel_ID_string;

@property(nonatomic,strong) NSString *skillLevel_string;
@property(nonatomic,strong) NSString *skillLevel_ID_string;
///////

/// For Service Provider Search Jobs Response fields
@property(nonatomic,strong) NSString *jobDate_string;
@property(nonatomic,strong) NSString *job_ID_string;
@property(nonatomic,strong) NSString *jobNumber_string;
@property(nonatomic,strong) NSString *state_string;

@property(nonatomic,strong) NSString *unitId_string;


- (id)initWithStoreDictionary:(NSDictionary *)json;
@end
