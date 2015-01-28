//
//  GISStoreManager.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 05/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GISLoginDetailsObject.h"
#import "GISDropDownsObject.h"
#import "GISBilingDataObject.h"
#import "GISContactAndBillingObject.h"
#import "GISContactsInfoObject.h"
#import "GISChooseRequestDetailsObject.h"
#import "GISDatesAndTimesObject.h"
#import "GISAttendeesObject.h"
#import "GISAttendees_ListObject.h"
#import "GISSearchReqObject.h"
#import "GISViewScheduleObject.h"
#import "GISSchedulerSPJobsObject.h"
#import "GISSchedulerNMRequestsObject.h"
#import "GISJobDetailsObject.h"
#import "GISViewEditDateObject.h"
#import "GISServiceProviderObject.h"

@interface GISStoreManager : NSObject
+ (GISStoreManager *)sharedManager;
- (BOOL)addLoginObject:(GISLoginDetailsObject*)loginObject;
- (NSMutableArray*)getLoginObjects;
- (void)removeLoginObjects;
- (void)destroy;


- (BOOL)addBuildingNameObject:(GISDropDownsObject *)buildingNameObj;
- (NSMutableArray *)getBuildingNameObjects;
- (void)removeBuildingNameObjects;

- (BOOL)addDressCodeObject:(GISDropDownsObject *)dressCodeObj;
- (NSMutableArray *)getDressCodeObjects;
- (void)removeDressCodeObjects;

- (BOOL)addLocationCodeObject:(GISDropDownsObject *)locationCodeObj;
- (NSMutableArray *)getLocationCodeObjects;
- (void)removeLocationCodeObjects;

- (BOOL)addEventTypeObject:(GISDropDownsObject *)eventTypeObj;
- (NSMutableArray *)getEventTypeObjects;
- (void)removeEventTypeObjects;

- (BOOL)addUnitOrDepartmentObject:(GISDropDownsObject *)unitOrDepartmentObj;
- (NSMutableArray *)getUnitOrDepartmentObjects;
- (void)removeUnitOrDepartmentObjects;

- (BOOL)addBillingDataObject:(GISBilingDataObject *)billingDataObj;
- (NSMutableArray *)getBillingDataObject;
- (void)removeBillingDataObjects;


- (BOOL)addRequestNumbersObject:(GISDropDownsObject *)requestNumbersObject;
- (NSMutableArray*)getRequestNumbersObjects;
- (void)removeRequestNumbersObjects;

- (BOOL)addRequestDetailsObject:(GISBilingDataObject *)requestDetails;
- (NSMutableArray *)getRequestDetailsObject;
- (void)removeRequestDetailsObjects;

- (BOOL)addContactsInfoObject:(GISContactsInfoObject *)contactsObj;
- (NSMutableArray *)getContactsInfoObjects;
- (void)removeContactsInfoObjects;


- (BOOL)addChooseRequestDetailsObject:(GISChooseRequestDetailsObject *)chooseRequestDetailsObj;
- (NSMutableArray *)getChooseRequestDetailsObjects;
- (void)removeChooseRequestDetailsObjects;

- (BOOL)addModeOfCommunicationObject:(GISDropDownsObject *)modeOfCommunicationObj;
- (NSMutableArray *)getModeOfCommunicationObjects;
- (void)removeModeOfCommunicationObjects;

- (BOOL)addServiceProvGenderPrefObject:(GISDropDownsObject *)serviceProvGenderPrefObj;
- (NSMutableArray *)getServiceProvGenderPrefObjects;
- (void)removeServiceProvGenderPrefObjects;

- (BOOL)addServiceNeededObject:(GISDropDownsObject *)serviceNeededObj;
- (NSMutableArray *)getServiceNeededObjects;
- (void)removeServiceNeededObjects;

- (BOOL)addAttendees_Details_Object:(GISAttendees_ListObject *)attendees_Details_Obj;
- (NSMutableArray *)getAttendees_Details_Objects;
- (void)removeAttendees_Details_Objects;

- (BOOL)addClosestmetroObject:(GISDropDownsObject *)ClosestmetroObj;
- (NSMutableArray *)getClosestmetroObjects;
- (void)removeClosestmetroObjects;


- (BOOL)addDateTimes_detail_Object:(GISDatesAndTimesObject *)dateTimes_detail_Obj;
- (NSMutableArray *)getDateTimes_detail_Objects;
- (void)removeDateTimes_detail_Objects;

- (BOOL)addLocationNameObject:(GISDropDownsObject *)LocationNameObj;
- (NSMutableArray *)getLocationNameObjects;
- (void)removeLocationNameObjects;

- (BOOL)addPrimaryAudienceObject:(GISDropDownsObject *)PrimaryAudience;
- (NSMutableArray *)getPrimaryAudienceObjects;
- (void)removePrimaryAudienceObjects;


- (BOOL)addSearchRequestJobsObject:(GISSearchReqObject *)searchRequestJobsObj;
- (NSMutableArray*)getSearchRequestJobsObjects;
- (void)removeSearchRequestJobsObjects;

- (BOOL)addViewSchedule_Details_Object:(GISViewScheduleObject *)viewSchedule_Details_Obj;
- (NSMutableArray *)getViewSchedule_Objects;
- (void)removeViewSchedule_Objects;

- (BOOL)addSkillLevelObject:(GISDropDownsObject *)SkillLevelObj;
- (NSMutableArray *)getSkillLevelObjects;
- (void)removeSkillLevelObjects;

- (BOOL)addPayLevelObject:(GISDropDownsObject *)PayLevelObj;
- (NSMutableArray *)getPayLevelObjects;
- (void)removePayLevelObjects;

- (BOOL)addServiceType_ServiceProviderObject:(GISDropDownsObject *)ServiceType_ServiceProviderObj;
- (NSMutableArray *)getServiceType_ServiceProviderObjects;
- (void)removeServiceType_ServiceProviderObjects;

- (BOOL)addRegisteredConsumersObject:(GISDropDownsObject *)registeredConsumersObj;
- (NSMutableArray *)getRegisteredConsumersObjects;
- (void)removeRegisteredConsumersObjects;

- (BOOL)addRequestNumbers_SearchJobsObject:(GISDropDownsObject *)requestNumbers_SearchJobsObject;
- (NSMutableArray*)getRequestNumbers_SearchJobsObjects;
- (void)removeRequestNumbers_SearchJobsObjects;

-(BOOL)addRequestJobs_SPJobsObject:(GISSchedulerSPJobsObject *)request_SPJobsObject;
- (NSMutableArray*)getRequestJobs_SPJobsObject;
- (void)removeRequestJobs_SPJobsObject;

-(BOOL)addRequests_NMRequestObject:(GISSchedulerNMRequestsObject *)request_NMRequestsObject;
- (NSMutableArray*)getRequest_NMRequestObject;
- (void)removeRequest_NMRequestObject;

- (BOOL)addPayTypeObject:(GISDropDownsObject *)payTypeObj;
- (NSMutableArray*)getPayTypeObjects;
- (void)removePayTypeObjects;

- (BOOL)addJobDetailsObject:(GISJobDetailsObject *)jobdetailsObj;
- (NSMutableArray*)getJobDetailsObjects;
- (void)removeJobDetailsObjects;

- (BOOL)addTypeOfServiceObject:(GISDropDownsObject *)typeOfServiceObj;
- (NSMutableArray*)getTypeOfServiceObjects;
- (void)removeTypeOfServiceObjects;


- (BOOL)addBillLevelObject:(GISDropDownsObject *)billLevelObj;
- (NSMutableArray *)getBillLevelObjects;
- (void)removeBillLevelObjects;

- (BOOL)addPayStatus_ExpStatusObject:(GISDropDownsObject *)payStatus_ExpStatusObj;
- (NSMutableArray *)getPayStatus_ExpStatusObjects;
- (void)removePayStatus_ExpStatusObjects;

- (BOOL)addViewEditObject:(GISViewEditDateObject *)jobdetailsObj;
- (NSMutableArray*)getViewEditObjects;
- (void)removeViewEditObjects;

- (BOOL)addServiceProviderObject:(GISServiceProviderObject *)serviceProviderObj;
- (NSMutableArray*)getServiceProviderObjects;
- (void)removeServiceProviderObjects;

- (BOOL)addRequestorsObject:(GISDropDownsObject *)requestorsObj;
- (NSMutableArray*)getRequestorsObjects;
- (void)removeRequestorsObjects;

- (BOOL)addCreated_ByObject:(GISDropDownsObject *)created_ByObj;
- (NSMutableArray*)getCreated_ByObjects;
- (void)removeCreated_ByObjects;

- (BOOL)addMode_jobAssisgnMentObject:(GISDropDownsObject *)mode_jobAssisgnMentObj;
- (NSMutableArray*)getMode_jobAssisgnMentObjects;
- (void)removeMode_jobAssisgnMentObjects;

- (BOOL)addRequestor_TypeObject:(GISDropDownsObject *)requestor_TypeObj;
- (NSMutableArray*)getRequestor_TypeObjects;
- (void)removeRequestor_TypeObjects;

- (BOOL)addSearchRequestNumbersObject:(GISDropDownsObject *)requestNumbersObject;
- (NSMutableArray*)getSearchRequestNumbersObjects;
- (void)removeSearchRequestNumbersObjects;

- (BOOL)addSPjobRequestNumbersObject:(GISDropDownsObject *)requestNumbersObject;
- (NSMutableArray*)getSPjobRequestNumbersObjects;
- (void)removeSPjobRequestNumbersObjects;
@end
