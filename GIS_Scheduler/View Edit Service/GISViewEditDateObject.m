//
//  GISViewEditDateObject.m
//  GIS_Scheduler
//
//  Created by Anand on 16/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISViewEditDateObject.h"
#import "GISJSONProperties.h"
#import "GISDatabaseManager.h"
#import "GISDropDownsObject.h"
#import "GISServiceProviderObject.h"

@implementation GISViewEditDateObject

@synthesize billAmount_String;
@synthesize endTime_String;
@synthesize jobDate_String;
@synthesize jobId_String;
@synthesize jobNumber_String;
@synthesize patType_String;
@synthesize serViceProvider_String;
@synthesize startTime_String;
@synthesize timely_String;
@synthesize typeOfService_String;
@synthesize subRole_String;
@synthesize eventName_String;
@synthesize requestApproved_String;

- (id)initWithStoreDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        @try {
            
            NSMutableArray *typeOfService_array=[[NSMutableArray alloc]init];
            NSString *typeOfService_statement = [[NSString alloc]initWithFormat:@"select * from TBL_TYPE_OF_SERVICE  ORDER BY ID DESC;"];
            typeOfService_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:typeOfService_statement] mutableCopy];
            
            NSMutableArray *serviceProvider_Array=[[NSMutableArray alloc]init];
            NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO"];
            serviceProvider_Array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
            
            NSMutableArray *payType_array=  [[NSMutableArray alloc]init];
            NSString *payType_statement  =  [[NSString alloc]initWithFormat:@"select * from TBL_PAY_TYPE"];
            payType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:payType_statement] mutableCopy];
         
            billAmount_String = [self returningstring:[json objectForKey:kViewSchedule_BillAmount]];
            endTime_String = [json objectForKey:kViewSchedule_EndTime] == NULL?@" ":[NSString stringWithString:[json objectForKey:kViewSchedule_EndTime]];
            jobDate_String = [self returningstring:[json objectForKey:kViewSchedule_JobDate]];
            jobId_String = [self returningstring:[json objectForKey:kViewSchedule_JobID]];
            jobNumber_String = [self returningstring:[json objectForKey:kViewSchedule_JobNumber]];
            
            if([json objectForKey:kViewSchedule_PayType]){
                NSPredicate *filePredicate;
                filePredicate=[NSPredicate predicateWithFormat:@"id_String==%@",[self returningstring:[json objectForKey:kViewSchedule_PayType]]];
                NSArray *fileArray=[payType_array filteredArrayUsingPredicate:filePredicate];
                
                if([fileArray count]>0)
                {
                    GISDropDownsObject *obj=[fileArray lastObject];
                    patType_String=obj.value_String;
                }
            }
            
            //patType_String = [self returningstring:[json objectForKey:kViewSchedule_PayType]];
            
            if ([json objectForKey:kViewSchedule_ServiceProvider]) {
                
                NSPredicate *filePredicate;
                filePredicate=[NSPredicate predicateWithFormat:@"id_String==%@",[self returningstring:[json objectForKey:kViewSchedule_ServiceProvider]]];
                NSArray *fileArray=[serviceProvider_Array filteredArrayUsingPredicate:filePredicate];
                
                if([fileArray count]>0)
                {
                    GISServiceProviderObject *obj=[fileArray lastObject];
                    serViceProvider_String=obj.service_Provider_String;
                }
            }

            if ([json objectForKey:kViewSchedule_TypeofService]) {
                NSPredicate *filePredicate;
                filePredicate=[NSPredicate predicateWithFormat:@"id_String==%@",[self returningstring:[json objectForKey:kViewSchedule_TypeofService]]];
                NSArray *fileArray=[typeOfService_array filteredArrayUsingPredicate:filePredicate];
                
                if([fileArray count]>0)
                {
                    GISDropDownsObject *obj=[fileArray lastObject];
                    typeOfService_String=obj.value_String;
                }
            }
            //serViceProvider_String = [self returningstring:[json objectForKey:kViewSchedule_ServiceProvider]];
            startTime_String = [self returningstring:[json objectForKey:kViewSchedule_StartTime]];
            timely_String = [self returningstring:[json objectForKey:kViewSchedule_Timely]];
            //typeOfService_String = [self returningstring:[json objectForKey:kViewSchedule_TypeofService]];
            subRole_String = [self returningstring:[json objectForKey:kViewSchedule_SubRole]];
            eventName_String = [self returningstring:[json objectForKey:kViewSchedule_EventType]];
            requestApproved_String = [self returningstring:[json objectForKey:kViewSchedule_RequestApproved]];
           
            
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
