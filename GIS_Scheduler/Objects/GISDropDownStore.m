//
//  GISDropDownStore.m
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 15/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDropDownStore.h"
#import "GISJSONProperties.h"
#import "GISStoreManager.h"


@implementation GISDropDownStore

@synthesize dropDownObject;


- (id)initWithStoreDictionary:(NSDictionary *)json
{
    if (self == [super init]) {
        NSLog(@"%s: %@",__FUNCTION__, json);
        [self parseDropDownsDetailsWithDict:json];
    }
    return self;
}

- (void)parseDropDownsDetailsWithDict:(NSDictionary *)dictionary
{
    @try {
        
        id dropDowns =dictionary;
        
        if ([dropDowns isKindOfClass:[NSDictionary class]]) {
         
            
        }
        else {
            for (id dropDown in dropDowns) {
                if ([[dropDown objectForKey:kDropDownType] isEqual:kBuildingNames]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addBuildingNameObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kDressCode]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addDressCodeObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kLocationCode]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addLocationCodeObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kEventType]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addEventTypeObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kunitOrDep]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addUnitOrDepartmentObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kRequestNumbers]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addRequestNumbersObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kJob_RequestNumbers]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addSearchRequestNumbersObject:dropDownObject];
                }
                else if([[dropDown objectForKey:kDropDownType] isEqual:kJob_SPRequestNumbers]){
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addSPjobRequestNumbersObject:dropDownObject];
                }
                //
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kMode_of_Communication]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addModeOfCommunicationObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kServiceProvider_GenderPref]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addServiceProvGenderPrefObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kService_Needed]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addServiceNeededObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kClosest_metro]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addClosestmetroObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kLocationName]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addLocationNameObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kPrimary_Audience]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addPrimaryAudienceObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kSkill_Level]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addSkillLevelObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kPay_Level]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addPayLevelObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kBill_Level]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addBillLevelObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kPayStatus_ExpStatus]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addPayStatus_ExpStatusObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kServiceType_serviceProvider]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addServiceType_ServiceProviderObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kRequest_Number_Search]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addRequestNumbers_SearchJobsObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kPayType]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addPayTypeObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kTypeOfService]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addTypeOfServiceObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kServiceType_Registerd_Consumers]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addRegisteredConsumersObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kRequestors]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addRequestorsObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kMode]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addMode_jobAssisgnMentObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kCreated_By]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addCreated_ByObject:dropDownObject];
                }
                else if ([[dropDown objectForKey:kDropDownType] isEqual:kRequestor_Type]) {
                    dropDownObject=[[GISDropDownsObject alloc]initWithStoreDictionary:dropDown];
                    [[GISStoreManager sharedManager]addRequestor_TypeObject:dropDownObject];
                }

            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"EXCEPTION raised, reason was: %@", [exception reason]);
    }
}



@end
