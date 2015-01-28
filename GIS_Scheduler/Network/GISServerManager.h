//
//  GISServerManager.h
//  Gallaudet-Interpreting-Service
//
//Created by Paradigm on 02/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GISProperties.h"

@class GISRequest;

@interface GISServerManager : NSObject

{
    NSMutableArray *requests;
}

+ (GISServerManager*)sharedManager;
- (void)destroy;

- (void)queueRequest:(GISRequest *)request;
- (void)removeRequest:(GISRequest *)request;

- (void)cancelAll;

- (void)logininForTarget:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;
- (void)getDropDownData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;
- (void)getMastersData_Schedulers:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;
- (void)getService_Provider_Names:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;
- (void)getBillingsData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getRequestNumbersData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getChooseRequestDetailsData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getContactsData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)saveUpdateRequestData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)saveEventDetailsData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)saveAttendeesData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)saveDateTimeData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getAttendees_Details_Data:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)saveLocationData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)saveUpdateUnavailableTime:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getEventDetailsData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getDateTimeDetails:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getLocation_Details_Data:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getoffCampusLocation_Details_Data:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getDeleteRequest:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getMyAssignedJobs:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getSearchRequestNumbers:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)searchRequestJobs:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;


- (void)getviewSchedule:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getSchedule_ServiceProvider:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)searchJobs_serviceProvider:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)submitTimeSheet:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)submitForRequest:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getSchedulerRequestedJobs:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getSchedulerNewandModifiedRequests:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getPayTypedata:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getViewEditScheduledata:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;


- (void)getJobDetails_data:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)saveSPRequestData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getService_provider_data:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)serviceProviderNames_JobDetails:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)updateJobDetails:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)saveMaterialTypeData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;


- (void)createJObs_JobDetails:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)findRequestJObs_Search:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)searchSpRequestedJobs:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)jobAssignmentJobs:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)submitViewEditRequest:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)filterJobsDetails:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)updateJobDetails_SearchRequestedJobs:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getViewScheduleService_provider_data:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)addNewJobDetails:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getEventTypebyUnitId:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)deleteJobs:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

- (void)getSearchRequestNumbersData:(id)target withParams:(NSMutableDictionary *)params finishAction:(SEL)finishAction failAction:(SEL)failAction;

@end
