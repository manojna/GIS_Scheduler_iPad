//
//  GISSearchReqObject.m
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 10/06/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISSearchReqObject.h"
#import "GISJSONProperties.h"
#import "GISUtility.h"

@implementation GISSearchReqObject


 @synthesize from_string;
 @synthesize to_string;
 @synthesize startTime_string;
 @synthesize endTime_string;

 @synthesize department_string;
 @synthesize primaryAudience__string;
 @synthesize registeredConsumers_string;
 @synthesize location_string;
 @synthesize eventType_string;
 @synthesize modeOf_string;
@synthesize weekDays_dictionary;

@synthesize department_ID_string;
@synthesize primaryAudience_ID_string;
@synthesize registeredConsumers_ID_string;
@synthesize location_ID_string;
@synthesize eventType_ID_string;
@synthesize modeOf_ID_string;


@synthesize endTime_result_string;
@synthesize eventTitle_result_string;
@synthesize requestID_result_string;
@synthesize requestNumber_result_string;
@synthesize requestStatus_result_string;
@synthesize requestedDate_result_string;
@synthesize startTime_result_string;
@synthesize status_result_string;
@synthesize statusCode_result_string;
@synthesize chooseRequest_ID_string,chooseRequest_string;

@synthesize serviceType_string;
@synthesize serviceType_ID_string;

@synthesize generalLocation_string;
@synthesize generalLocation_ID_string;

@synthesize payLevel_string;
@synthesize payLevel_ID_string;

@synthesize skillLevel_string;
@synthesize skillLevel_ID_string;

@synthesize jobDate_string;
@synthesize job_ID_string;
@synthesize jobNumber_string;
@synthesize state_string;

@synthesize unitId_string;


- (id)initWithStoreDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        @try {
            if ([json isKindOfClass:[NSDictionary class]]) {
                //enters here
                NSDictionary *dict=json;
                if ([dict objectForKey:kSearchReq_Result_EndTime])
                     endTime_result_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_EndTime]];
                if ([dict objectForKey:kSearchReq_Result_EventTitle])
                    eventTitle_result_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_EventTitle]];
                if ([dict objectForKey:kSearchReq_Result_RequestId])
                    requestID_result_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_RequestId]];
                if ([dict objectForKey:kSearchReq_Result_RequestNumber])
                    requestNumber_result_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_RequestNumber]];
                if ([dict objectForKey:kSearchReq_Result_RequestStatus])
                    requestStatus_result_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_RequestStatus]];
                if ([dict objectForKey:kSearchReq_Result_RequestedDate])
                    requestedDate_result_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_RequestedDate]];
                if ([dict objectForKey:kSearchReq_Result_StartTime])
                    startTime_result_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_StartTime]];
                if ([dict objectForKey:kSearchReq_Result_Status])
                     status_result_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_Status]];
                if ([dict objectForKey:kSearchReq_Result_StatusCode])
                     statusCode_result_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_StatusCode]];
                
                ////
                if ([dict objectForKey:kSearchReq_Result_JobDate])
                    jobDate_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_JobDate]];
                if ([dict objectForKey:kSearchReq_Result_JobID])
                    job_ID_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_JobID]];
                if ([dict objectForKey:kSearchReq_Result_JobNumber])
                    jobNumber_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_JobNumber]];
                if ([dict objectForKey:kSearchReq_Result_State])
                    state_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_State]];
                if ([dict objectForKey:kSearchReq_Result_GeneralLocation])
                    generalLocation_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_GeneralLocation]];
                if ([dict objectForKey:kSearchReq_Result_EventType])
                    eventType_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_EventType]];
                
                if ([dict objectForKey:kSearchReq_Result_UnitId])
                    unitId_string=[GISUtility returningstring:[dict objectForKey:kSearchReq_Result_UnitId]];
                
            }
        }
        @catch (NSException *exception) {
            NSLog(@"EXCEPTION raised, reason was: %@", [exception reason]);
        }
    }
    return self;
}
@end
