//
//  GISSchedulerNMRequestsObject.m
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISSchedulerNMRequestsObject.h"
#import "GISJSONProperties.h"

@implementation GISSchedulerNMRequestsObject

@synthesize AccountName_String;
@synthesize ApprovalDate_String;
@synthesize ApproveddBy_String;
@synthesize DateofEarlierAssigment_String;
@synthesize EarliestDate_String;
@synthesize EventType_String;
@synthesize OtherServices_String;
@synthesize RequestID_String;
@synthesize RequestStatus_String;
@synthesize RequestSubmissionDate_String;
@synthesize Shceduler_String;
@synthesize Tab_String;


- (id)initWithStoreDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        @try {
            //GisResponse_String = [self returningstring:[[json objectForKey:kSPRequestJobs_GisResponse] stringValue]];
            // if(GisResponse_String == NULL)
            //{
            //    GisResponse_String = @" ";
            // }else{
            AccountName_String = [self returningstring:[json objectForKey:kNMRequests_AccountName]];
            ApprovalDate_String = [json objectForKey:kNMRequests_ApprovalDate] == NULL?@" ":[NSString stringWithString:[json objectForKey:kNMRequests_ApprovalDate]];
            ApproveddBy_String = [self returningstring:[json objectForKey:kNMRequests_ApproveddBy]];
            DateofEarlierAssigment_String = [self returningstring:[json objectForKey:kNMRequests_DateofEarlierAssigment]];
            EarliestDate_String = [self returningstring:[json objectForKey:kNMRequests_EarliestDate]];
            EventType_String = [self returningstring:[json objectForKey:kNMRequests_EventType]];
            
            OtherServices_String = [self returningstring:[json objectForKey:kNMRequests_OtherServices]];
            RequestID_String = [self returningstring:[json objectForKey:kNMRequests_RequestID]];
            RequestStatus_String = [self returningstring:[json objectForKey:kNMRequests_RequestStatus]];
            RequestSubmissionDate_String = [self returningstring:[json objectForKey:kNMRequests_RequestSubmissionDate]];
            Shceduler_String = [self returningstring:[json objectForKey:kNMRequests_Shceduler]];
            Tab_String = [self returningstring:[json objectForKey:kNMRequests_Tab]];
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
