//
//  GISServerManager.m
//  Gallaudet-Interpreting-Service
//
//Created by Paradigm on 02/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISServerManager.h"
#import "GISJsonRequest.h"
#import "Utils.h"

static GISServerManager *singletonManager = nil;

@interface GISServerManager (Private)

- (void)fillCommonParamsForRequest:(GISRequest *)request;
- (void)startRequest:(GISRequest *)request target:(id)target finishAction:(SEL)finishAction failAction:(SEL)failAction;
- (BOOL)isNetworkAvailable;

@end

@implementation GISServerManager

+ (GISServerManager*)sharedManager
{
    if (singletonManager == nil) {
        singletonManager = [[self alloc]init];
    }
    return singletonManager;
}


- (id)init
{
    self = [super init];
    if (self) {
        requests = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (singletonManager == nil) {
            singletonManager = [super allocWithZone:zone];
        }
    }
    
    return singletonManager;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (oneway void)release
{
    // do nothing
}

- (id)autorelease
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;
}

- (void) destroy
{
    
}

#pragma mark -
#pragma mark Class Methods

- (void)queueRequest:(GISRequest *)request
{
    @synchronized (self)
    {
        [requests addObject:request];
    }
}

- (void)removeRequest:(GISRequest *)request
{
    @synchronized (self)
    {
        [requests removeObject:request];
    }
}

- (void)cancelAll
{
    @synchronized (self)
    {
        NSArray *temp = [[NSArray alloc] initWithArray:requests];
        for (GISRequest *request in temp)
        {
            [request cancel];
        }
        [requests removeAllObjects];
        [temp release];
    }
}


#pragma mark -
#pragma mark ServerAPI

- (void)logininForTarget:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    
    //NSString *url = [[NSString alloc] initWithFormat:@"%@%@?username=%@&password=%@",GIS_STAGE_BASE_URL,GIS_USER_LOGIN,[params objectForKey:@"username"],[params objectForKey:@"password"]];
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_USER_LOGIN];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
   
}

///////////////// get Request Methods ////////////////////

- (void)getDropDownData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
 
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_DROP_DOWNS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
   
}

- (void)getMastersData_Schedulers:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_SCHEDULER_MASTERS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
    
}


//iPAd
- (void)getService_Provider_Names:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_SERVICE_PROVIDERS_NAMES_iPAD];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
    
}

- (void)getEventDetailsData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_EVENT_REQUEST];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
    
}

- (void)getBillingsData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_Billing_Details];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];

    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
   
}

- (void)getRequestNumbersData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_REQUEST_NUMBERS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)getSearchRequestNumbersData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_SP_JOBS_REQUEST_NUMBERS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)getChooseRequestDetailsData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_CHOOSE_REQUEST_DETAILS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}


- (void)getAttendees_Details_Data:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_ATTENDEES_DETAILS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)getLocation_Details_Data:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_LOCATION_DETAILS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)getoffCampusLocation_Details_Data:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_OFFLOCATION_DETAILS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)getService_provider_data:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_SERVICE_PROVIDERS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodGet];
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
    
}

- (void)getViewScheduleService_provider_data:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_VIEWSCHEDULE_SERVICEPROVIDERS_INFO];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodGet];
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
    
}


///////////////// Save Request Methods ////////////////////

- (void)getContactsData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_CONTACT_DETAILS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)getDateTimeDetails:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_DATE_TIME_DETAILS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)getviewSchedule:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_SCHEDULE];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}


- (void)getSchedule_ServiceProvider:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_SERVICE_PROVIDER_SCHEDULE];

    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)getDeleteRequest:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_INACTIVE_REQUEST];

    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}
- (void)getMyAssignedJobs:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_MY_ASSIGNED_JOBS];
    
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)getSchedulerRequestedJobs:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_SCHEDULER_REQUESTED_JOBS];
    
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)getSchedulerNewandModifiedRequests:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_SCHEDULER_NEW_MODIFIED_REQUESTS];
    
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)getPayTypedata:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_SCHEDULER_MASTERS];
    
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)getJobDetails_data:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_JOB_DETAILS];
    
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)getViewEditScheduledata:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_VIEW_EDIT_SCHEDULE];
    
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)getEventTypebyUnitId:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_EVENT_TYPE_BY_UNITID];
    
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

///////////////// Save Request Methods ////////////////////

- (void)saveUpdateRequestData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SAVE_UPDATE_REQUEST];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)saveEventDetailsData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SAVE_UPDATE_REQUEST];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)saveAttendeesData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SAVE_ATTENDEES];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)saveLocationData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SAVE_LOCATION];
    
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)saveDateTimeData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SAVE_DATE_TIME];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)saveUpdateUnavailableTime:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SAVE_UPDATE_UNAVAILABLE_TIME];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)saveSPRequestData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SAVE_SPREQUESTED_JOBS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}


- (void)searchRequestJobs:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SEARCH_REQUESTS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)getSearchRequestNumbers:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_GET_SEARCH_REQUEST_NUMBERS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)searchJobs_serviceProvider:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SEARCH_JOBS_SERVICE_PROVIDER];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}
- (void)submitTimeSheet:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SUBMIT_TIME_SHEET];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}
- (void)submitForRequest:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SUBMIT_FOR_REQUEST];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)submitViewEditRequest:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SUBMIT_REQUEST];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)serviceProviderNames_JobDetails:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SERVICE_PROVIDERS_NAMES_JOBDetails];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodGet];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)updateJobDetails:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_UPDATE_JOBS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)addNewJobDetails:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SaveUpdateJobs];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)updateJobDetails_SearchRequestedJobs:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_UPDATE_JOBS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)deleteJobs:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_DeleteJobs];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

#pragma mark -
#pragma mark Helpers

- (void)startRequest:(GISRequest *)request target:(id)target finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    [request setFinishTarget:target andAction:finishAction];
    [request setErrorTarget:target andAction:failAction];
    [request start];
}

- (void)saveMaterialTypeData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SAVE_MATERIAL_TYPE];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)createJObs_JobDetails:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_CreateJobs];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}
- (void)searchSpRequestedJobs:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SPREQUESTED_JOBS_SEARCH];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)filterJobsDetails:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_FILTER_JOB_DETAILS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}


- (void)jobAssignmentJobs:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_JOB_ASSIGNMENT];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)findRequestJObs_Search:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction
{
    if (![self isNetworkAvailable]) { [self alert]; return;}
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",GIS_STAGE_BASE_URL,GIS_SEARCH_REQUESTED_JOBS];
    GISJsonRequest *request = [[GISJsonRequest alloc] initWithURL:url andParams:params];
    [request setMethodPost];
    
    [self startRequest:request target:target finishAction:finishAction failAction:failAction];
}

- (void)alert
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"No internet connection." message:nil delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alertView show];
}

- (BOOL)isNetworkAvailable
{
    return [Utils isNetworkAvailable];
}

@end
