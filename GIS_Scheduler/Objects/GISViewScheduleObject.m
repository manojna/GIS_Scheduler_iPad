//
//  GISViewScheduleObject.m
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 10/06/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISViewScheduleObject.h"
#import "GISJSONProperties.h"

@implementation GISViewScheduleObject


@synthesize createdDate_String;
@synthesize eventTitle_String;
@synthesize requestId_String;
@synthesize requestNumber_String;
@synthesize requestStatus_String;
@synthesize scheduler_String;
@synthesize unitNoStatus_String;
@synthesize requestColorName_String;
@synthesize startTime_String;
@synthesize endTime_String;

@synthesize eventType_String;
@synthesize jobdate_String;
@synthesize jobID_String;
@synthesize state_String;
@synthesize status_String;
@synthesize statusCode_String;
@synthesize jobNumber_String;
@synthesize generalLocation_String;
@synthesize unAvailableID_String;

- (id)initWithStoreDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        @try {
            
            if ([json isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict=json;
                if([dict objectForKey:kEditSchedule_CreatedDate])
                    createdDate_String=[self returningstring: [dict objectForKey:kEditSchedule_CreatedDate]];
                if([dict objectForKey:kEditSchedule_EventTitle])
                    eventTitle_String=[self returningstring: [dict objectForKey:kEditSchedule_EventTitle]];
                if([dict objectForKey:kEditSchedule_RequestId])
                    requestId_String =[self returningstring: [dict objectForKey:kEditSchedule_RequestId]];
                if([dict objectForKey:kEditSchedule_RequestNumber])
                    requestNumber_String=[self returningstring: [dict objectForKey:kEditSchedule_RequestNumber]];
                if([dict objectForKey:kEditSchedule_RequestStatus])
                    requestStatus_String=[self returningstring: [dict objectForKey:kEditSchedule_RequestStatus]];
                if([dict objectForKey:kEditSchedule_UnitNo])
                    unitNoStatus_String=[self returningstring: [dict objectForKey:kEditSchedule_UnitNo]];
                if([dict objectForKey:kEditSchedule_RequestColor])
                    requestColorName_String=[self returningstring: [dict objectForKey:kEditSchedule_RequestColor]];
                if([dict objectForKey:kEditSchedule_StartTime])
                    startTime_String=[self returningstring: [dict objectForKey:kEditSchedule_StartTime]];
                if([dict objectForKey:kEditSchedule_EndTime])
                    endTime_String=[self returningstring: [dict objectForKey:kEditSchedule_EndTime]];
                if([dict objectForKey:kEditSchedule_Scheduler])
                    scheduler_String=[self returningstring: [dict objectForKey:kEditSchedule_Scheduler]];
                
                if([dict objectForKey:kEditSchedule_EventType])
                    eventType_String=[self returningstring: [dict objectForKey:kEditSchedule_EventType]];
                
                if([dict objectForKey:kEditSchedule_JobDate])
                    jobdate_String=[self returningstring: [dict objectForKey:kEditSchedule_JobDate]];
                   // createdDate_String=[self returningstring: [dict objectForKey:kEditSchedule_JobDate]];
                
                if([dict objectForKey:kEditSchedule_JobID])
                    jobID_String=[self returningstring: [dict objectForKey:kEditSchedule_JobID]];
                
                if([dict objectForKey:kEditSchedule_State])
                    state_String=[self returningstring: [dict objectForKey:kEditSchedule_State]];
                
                if([dict objectForKey:kEditSchedule_Status])
                    status_String=[self returningstring: [dict objectForKey:kEditSchedule_Status]];
                
                if([dict objectForKey:kEditSchedule_StatusCode])
                    statusCode_String=[self returningstring: [dict objectForKey:kEditSchedule_StatusCode]];
                
                if([dict objectForKey:kEditSchedule_jobNumber])
                    jobNumber_String=[self returningstring: [dict objectForKey:kEditSchedule_jobNumber]];
                if([dict objectForKey:kEditSchedule_generalLocation])
                    generalLocation_String=[self returningstring: [dict objectForKey:kEditSchedule_generalLocation]];
                if([dict objectForKey:kEditSchedule_unAvailableID])
                    unAvailableID_String=[self returningstring: [dict objectForKey:kEditSchedule_unAvailableID]];
                

                
            }
        }
            
        @catch (NSException *exception) {
            NSLog(@"EXCEPTION raised, reason was: %@", [exception reason]);
        }
    }
    return self;
}


-(NSString *)returningstring:(id)string
{
    if ([string isKindOfClass:[NSNull class]])
    {
        return @" ";
    }
    else
    {
        if (![string isKindOfClass:[NSString class]])
        {
            NSString *str= [string stringValue];
            return str;
        }
        else
        {
            return string;
        }
    }
    
}



@end
