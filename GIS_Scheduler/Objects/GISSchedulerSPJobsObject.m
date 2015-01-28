//
//  GISSchedulerSPJobsObject.m
//  GIS_Scheduler
//
//  Created by Anand on 01/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISSchedulerSPJobsObject.h"
#import "GISJSONProperties.h"
#import "GISDropDownsObject.h"
#import "GISStoreManager.h"
#import "GISDatabaseManager.h"
#import "GISUtility.h"

@implementation GISSchedulerSPJobsObject
@synthesize filledOrUnfilled_string;
@synthesize GisResponse_String;
@synthesize endTime_String;
@synthesize ServiceProviderName_String;
@synthesize RequestedDate_String;
@synthesize JobID_String;
@synthesize JobNumber_String;
@synthesize JobDate_String;
@synthesize PayType_String;
@synthesize startTime_String;
@synthesize TotalHours_String;
@synthesize EventType_String;
@synthesize PayType_id_String;
@synthesize SPRequestJobID_String;
@synthesize requestApproved_string;

- (id)initWithStoreDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        @try {
            //GisResponse_String = [self returningstring:[[json objectForKey:kSPRequestJobs_GisResponse] stringValue]];
           // if(GisResponse_String == NULL)
            //{
            //    GisResponse_String = @" ";
           // }else{
            
            NSMutableArray *typeOfService_array=[[NSMutableArray alloc]init];
            NSString *typeOfService_statement = [[NSString alloc]initWithFormat:@"select * from TBL_TYPE_OF_SERVICE  ORDER BY ID DESC;"];
            typeOfService_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:typeOfService_statement] mutableCopy];
            
            NSMutableArray *serviceProvider_Array=[[NSMutableArray alloc]init];
            NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO"];
            serviceProvider_Array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
            
            NSMutableArray *payType_array=  [[NSMutableArray alloc]init];
            NSString *payType_statement  =  [[NSString alloc]initWithFormat:@"select * from TBL_PAY_TYPE"];
            payType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:payType_statement] mutableCopy];
            
            if ([json objectForKey:kSPRequestJobs_TotalHours])
                TotalHours_String = [self returningstring:[json objectForKey:kSPRequestJobs_TotalHours]];
            
            
            
            if ([json objectForKey:kSPRequestJobs_GisResponse])
            {
              GisResponse_String = [self returningstring:[json objectForKey:kSPRequestJobs_GisResponse]];
                if ([GisResponse_String isEqualToString:@"0"])
                    GisResponse_String=@"Select";
                else if ([GisResponse_String isEqualToString:@"1"])
                    GisResponse_String=@"Assigned";
                else if ([GisResponse_String isEqualToString:@"2"])
                    GisResponse_String=@"Not Assigned";
                else if ([GisResponse_String isEqualToString:@"3"])
                    GisResponse_String=@"Need More Information";
                else
                    GisResponse_String=@"Select";
            }
            if ([json objectForKey:kSPRequestJobs_EndTime])
            endTime_String = [self returningstring:[json objectForKey:kSPRequestJobs_EndTime]];
            if ([json objectForKey:kSPRequestJobs_EventType])
            EventType_String = [self returningstring:[json objectForKey:kSPRequestJobs_EventType]];
            if ([json objectForKey:kSPRequestJobs_JobDate])
            JobDate_String = [self returningstring:[json objectForKey:kSPRequestJobs_JobDate]];
            if ([json objectForKey:kSPRequestJobs_JobID])
            JobID_String = [self returningstring:[json objectForKey:kSPRequestJobs_JobID]];
            if ([json objectForKey:kSPRequestJobs_JobNumber])
            JobNumber_String = [self returningstring:[json objectForKey:kSPRequestJobs_JobNumber]];
            if ([json objectForKey:kSPRequestJobs_PayType])
            {
                NSPredicate *filePredicate;
                filePredicate=[NSPredicate predicateWithFormat:@"id_String==%@",[GISUtility returningstring:[json objectForKey:kSPRequestJobs_PayType]]];
                NSArray *fileArray=[payType_array filteredArrayUsingPredicate:filePredicate];
                
                if([fileArray count]>0)
                {
                    GISDropDownsObject *obj=[fileArray lastObject];
                    PayType_String=obj.value_String;
                }
                //PayType_String = [self returningstring:[json objectForKey:kSPRequestJobs_PayType]];
            }
            if ([json objectForKey:kSPRequestJobs_RequestedDate])
            RequestedDate_String = [self returningstring:[json objectForKey:kSPRequestJobs_RequestedDate]];
            if ([json objectForKey:kSPRequestJobs_StartTime])
            startTime_String = [self returningstring:[json objectForKey:kSPRequestJobs_StartTime]];
            if ([json objectForKey:kJobDetais_ServiceProvider])
            {
                if ([[GISUtility returningstring:[json objectForKey:kJobDetais_ServiceProvider]] isEqualToString:@""]) {
                    filledOrUnfilled_string=@"unfilled";
                }
                else
                {
                    filledOrUnfilled_string=@"filled";
                }
                NSPredicate *filePredicate;
                filePredicate=[NSPredicate predicateWithFormat:@"id_String==%@",[GISUtility returningstring:[json objectForKey:kJobDetais_ServiceProvider]]];
                NSArray *fileArray=[serviceProvider_Array filteredArrayUsingPredicate:filePredicate];
                
                if([fileArray count]>0)
                {
                    GISServiceProviderObject *obj=[fileArray lastObject];
                    ServiceProviderName_String=obj.service_Provider_String;
                }
                //ServiceProviderName_String = [self returningstring:[json objectForKey:kJobDetais_ServiceProvider]];
            }
            
            if ([json objectForKey:kSPRequestJobs_TotalHours])
            TotalHours_String = [self returningstring:[json objectForKey:kSPRequestJobs_TotalHours]];
            if ([json objectForKey:kSPRequestJobs_SPRequestJobID])
            SPRequestJobID_String = [self returningstring:[json objectForKey:kSPRequestJobs_SPRequestJobID]];
            if ([json objectForKey:kSPRequestJobs_AccountName])
                _accountName_string = [self returningstring:[json objectForKey:kSPRequestJobs_AccountName]];
            if ([json objectForKey:kSPRequestJobs_BillAmount])
                _billAmount_string = [self returningstring:[json objectForKey:kSPRequestJobs_BillAmount]];
            if ([json objectForKey:kSPRequestJobs_OutToAgency])
                _outToAgency_string = [self returningstring:[json objectForKey:kSPRequestJobs_OutToAgency]];
            if ([json objectForKey:kSPRequestJobs_Location])
                _location_string = [self returningstring:[json objectForKey:kSPRequestJobs_Location]];
            if ([json objectForKey:kSPRequestJobs_RequestorName])
                _requestorName_string = [self returningstring:[json objectForKey:kSPRequestJobs_RequestorName]];
            if ([json objectForKey:kSPRequestJobs_SubRole])
                _subRoll_string = [self returningstring:[json objectForKey:kSPRequestJobs_SubRole]];
            if ([json objectForKey:kSPRequestJobs_Timely])
                _timely_string = [self returningstring:[json objectForKey:kSPRequestJobs_Timely]];
            if ([json objectForKey:kSPRequestJobs_TypeofService])
            {
                
                NSPredicate *filePredicate;
                filePredicate=[NSPredicate predicateWithFormat:@"id_String==%@",[GISUtility returningstring:[json objectForKey:kSPRequestJobs_TypeofService]]];
                NSArray *fileArray=[typeOfService_array filteredArrayUsingPredicate:filePredicate];
                
                if([fileArray count]>0)
                {
                    GISDropDownsObject *obj=[fileArray lastObject];
                    _typeOfService_string=obj.value_String;
                }
                //_typeOfService_string = [self returningstring:[json objectForKey:kSPRequestJobs_TypeofService]];
            }
             if ([json objectForKey:kViewSchedule_RequestApproved])
                 requestApproved_string = [self returningstring:[json objectForKey:kViewSchedule_RequestApproved]];
            
            if ([json objectForKey:kSPRequestJobs_ServiceProviderName])
                ServiceProviderName_String = [self returningstring:[json objectForKey:kSPRequestJobs_ServiceProviderName]];
            

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
