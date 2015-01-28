//
//  GISAttendeesListObject.m
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 21/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISAttendees_ListObject.h"
#import "GISStoreManager.h"
#import "GISJSONProperties.h"
#import "GISDatabaseManager.h"
@implementation GISAttendees_ListObject


@synthesize firstname_String;
@synthesize lastname_String;
@synthesize email_String;
@synthesize modeOf_String;
@synthesize servicesNeeded_String,directly_utilzed_String;

@synthesize request_No_ID_String,attendee_ID_String;

@synthesize modeOfCommuniation_ID_String,serviceNedded_ID_String;


- (id)initWithStoreDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        @try {
            
            
            if ([json isKindOfClass:[NSDictionary class]]) {
                //enters here
                NSDictionary *dict=json;
                email_String=[self returningstring: [dict objectForKey:kAttendees_Details_AttendeeEmail]];
                firstname_String=[self returningstring: [dict objectForKey:kAttendees_Details_AttendeeFirstName]];
                attendee_ID_String =[self returningstring: [dict objectForKey:kAttendees_Details_AttendeeID]];
                lastname_String=[self returningstring: [dict objectForKey:kAttendees_Details_AttendeeLastName]];
                
                directly_utilzed_String=[self returningstring: [dict objectForKey:kAttendees_Details_DirectlyUnitlizeService]];
                
                request_No_ID_String=[self returningstring: [dict objectForKey:kAttendees_Details_RequestNo]];
                
                ///// servicesNeeded_String
                servicesNeeded_String=[self returningstring: [dict objectForKey:kAttendees_Details_TypeOfServiceNeeded]];
                //NSMutableArray *servicesNeeded_mutArray=[[GISStoreManager sharedManager]getServiceNeededObjects];
                NSString *servicesNeeded_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_NEEDED;"];
                NSMutableArray *servicesNeeded_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:servicesNeeded_statement] mutableCopy];
                BOOL isFound;
                for (int i=0; i<servicesNeeded_mutArray.count; i++) {
                     GISDropDownsObject *reqObj= [servicesNeeded_mutArray objectAtIndex:i];
                    if ([servicesNeeded_String isEqualToString:reqObj.id_String]) {
                        isFound=YES;
                        servicesNeeded_String=reqObj.value_String;
                        serviceNedded_ID_String=reqObj.id_String;
                    }
                }
                if (!isFound) {
                    servicesNeeded_String=@"";
                }
                //////
                
                
                ///
                modeOf_String=[self returningstring: [dict objectForKey:kAttendees_Details_ModeOfCommunication]];
                //NSMutableArray *modeofcommunication_mutArray=[[GISStoreManager sharedManager]getModeOfCommunicationObjects];
                NSString *modeofcommunication_statement = [[NSString alloc]initWithFormat:@"select * from TBL_MODE_OF_COMMUNICATION;"];
                NSMutableArray *modeofcommunication_mutArray = [[[GISDatabaseManager sharedDataManager] getDropDownArray:modeofcommunication_statement] mutableCopy];
                BOOL isFound1;
                for (int i=0; i<modeofcommunication_mutArray.count; i++) {
                    GISDropDownsObject *reqObj= [modeofcommunication_mutArray objectAtIndex:i];
                    if ([modeOf_String isEqualToString:reqObj.id_String]) {
                        isFound1=YES;
                        modeOf_String=reqObj.value_String;
                        modeOfCommuniation_ID_String=reqObj.id_String;
                    }
                }
                if (!isFound1) {
                    modeOf_String=@"";
                }
            }
            else if ([json isKindOfClass:[NSArray class]]) {
                NSArray *array=(NSArray *)json;
                NSDictionary *dict=[array lastObject];
                email_String=[self returningstring: [dict objectForKey:kAttendees_Details_AttendeeEmail]];
                firstname_String=[self returningstring: [dict objectForKey:kAttendees_Details_AttendeeFirstName]];
               attendee_ID_String =[self returningstring: [dict objectForKey:kAttendees_Details_AttendeeID]];
                lastname_String=[self returningstring: [dict objectForKey:kAttendees_Details_AttendeeLastName]];
                directly_utilzed_String=[self returningstring: [dict objectForKey:kAttendees_Details_DirectlyUnitlizeService]];
                request_No_ID_String=[self returningstring: [dict objectForKey:kAttendees_Details_RequestNo]];
                servicesNeeded_String=[self returningstring: [dict objectForKey:kAttendees_Details_TypeOfServiceNeeded]];
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
