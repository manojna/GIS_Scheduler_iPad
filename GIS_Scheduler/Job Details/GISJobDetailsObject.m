//
//  GISJobDetailsObject.m
//  GIS_Scheduler
//
//  Created by Paradigm on 19/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISJobDetailsObject.h"
#import "GISJSONProperties.h"
#import "GISUtility.h"
#import "GISDatabaseManager.h"
#import "GISDropDownsObject.h"
#import "GISServiceProviderObject.h"
@implementation GISJobDetailsObject

-(GISJobDetailsObject *)initializeJObDetailsValues:(NSDictionary *)dict
{

    NSMutableArray *typeOfService_array=[[NSMutableArray alloc]init];
    NSString *typeOfService_statement = [[NSString alloc]initWithFormat:@"select * from TBL_TYPE_OF_SERVICE  ORDER BY ID DESC;"];
    typeOfService_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:typeOfService_statement] mutableCopy];
    
    NSMutableArray *serviceProvider_Array=[[NSMutableArray alloc]init];
    NSString *spCode_statement = [[NSString alloc]initWithFormat:@"select * from TBL_SERVICE_PROVIDER_INFO"];
    serviceProvider_Array = [[[GISDatabaseManager sharedDataManager] getServiceProviderArray:spCode_statement] mutableCopy];
    
    NSMutableArray *payType_array=  [[NSMutableArray alloc]init];
    NSString *payType_statement  =  [[NSString alloc]initWithFormat:@"select * from TBL_PAY_TYPE"];
    payType_array = [[[GISDatabaseManager sharedDataManager] getDropDownArray:payType_statement] mutableCopy];
    
    
    GISJobDetailsObject *gobj=[[GISJobDetailsObject alloc]init];
    
    if ([dict objectForKey:kJobDetais_BillAmount]) {
        gobj.billAmount_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_BillAmount]];
    }
    if ([dict objectForKey:kJobDetais_EndTime]) {
        gobj.endTime_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_EndTime]];
    }
    if ([dict objectForKey:kJobDetais_JobDate]) {
        gobj.jobDate_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_JobDate]];
    }
    if ([dict objectForKey:kJobDetais_JobID]) {
        gobj.jobID_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_JobID]];
    }
    if ([dict objectForKey:kJobDetais_JobNumber]) {
        gobj.jobNumber_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_JobNumber]];
    }
    if ([dict objectForKey:kJobDetais_PayType]) {
        NSPredicate *filePredicate;
        filePredicate=[NSPredicate predicateWithFormat:@"id_String==%@",[GISUtility returningstring:[dict objectForKey:kJobDetais_PayType]]];
        NSArray *fileArray=[payType_array filteredArrayUsingPredicate:filePredicate];
        
        if([fileArray count]>0)
        {
            GISDropDownsObject *obj=[fileArray lastObject];
            gobj.payType_string=obj.value_String;
        }
        //gobj.payType_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_PayType]];
    }
    if ([dict objectForKey:kJobDetais_ServiceProvider]) {
        NSPredicate *filePredicate;
        filePredicate=[NSPredicate predicateWithFormat:@"id_String==%@",[GISUtility returningstring:[dict objectForKey:kJobDetais_ServiceProvider]]];
        NSArray *fileArray=[serviceProvider_Array filteredArrayUsingPredicate:filePredicate];
        
        if([fileArray count]>0)
        {
            GISServiceProviderObject *obj=[fileArray lastObject];
            gobj.serviceProvider_string=obj.service_Provider_String;
        }
        //gobj.serviceProvider_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_ServiceProvider]];
    }
    if ([dict objectForKey:kJobDetais_StartTime]) {
        gobj.startTime_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_StartTime]];
    }
    if ([dict objectForKey:kJobDetais_Status]) {
        gobj.status_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_Status]];
    }
    if ([dict objectForKey:kJobDetais_StatusCode]) {
        gobj.statusCode_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_StatusCode]];
    }
    if ([dict objectForKey:kJobDetais_Timely]) {
        gobj.timely_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_Timely]];
    }
    if ([dict objectForKey:kJobDetais_TypeofService]) {
        NSPredicate *filePredicate;
        filePredicate=[NSPredicate predicateWithFormat:@"id_String==%@",[GISUtility returningstring:[dict objectForKey:kJobDetais_TypeofService]]];
        NSArray *fileArray=[typeOfService_array filteredArrayUsingPredicate:filePredicate];
        
        if([fileArray count]>0)
        {
            GISDropDownsObject *obj=[fileArray lastObject];
            gobj.typeOfService_string=obj.value_String;
          //gobj.typeOfService_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_TypeofService]];
        }
    }
    
    gobj.slots_string=[GISUtility returningstring:[dict objectForKey:kJobDetais_Slots]];
    
    return gobj;
}

@end
