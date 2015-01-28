//
//  GISDatesAndTimesObject.m
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 28/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDatesAndTimesObject.h"
#import "GISStoreManager.h"
#import "GISJSONProperties.h"
#import "GISDatabaseManager.h"

@implementation GISDatesAndTimesObject

@synthesize chooseReq_answer_String;
@synthesize startDate_String;
@synthesize endDate_String;
@synthesize startTime_String;
@synthesize endTime_String;
@synthesize weekDays_dictionary;
@synthesize date_String,day_String;
@synthesize dateTime_ID_String,requestNo_String;
@synthesize tagValue;
@synthesize status_String,statusCode_String;
@synthesize unavailableID_String,notes_String;

//
- (id)initWithStoreDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        @try {
            
            
            if ([json isKindOfClass:[NSDictionary class]]) {
                //enters here
                NSDictionary *dict=json;
                
                date_String=[self returningstring: [dict objectForKey:kDateTime_Detail_Date]];
                dateTime_ID_String=[self returningstring: [dict objectForKey:kDateTime_Detail_DateTimeId]];
                day_String=[self returningstring: [dict objectForKey:kDateTime_Detail_Day]];
                endTime_String=[self returningstring: [dict objectForKey:kDateTime_Detail_EndTime]];
                startTime_String=[self returningstring: [dict objectForKey:kDateTime_Detail_StartTime]];
                status_String=[self returningstring: [dict objectForKey:kDateTime_Detail_Status]];
                statusCode_String=[self returningstring: [dict objectForKey:kDateTime_Detail_StatusCode]];
            }
            else if ([json isKindOfClass:[NSArray class]]) {
                
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
