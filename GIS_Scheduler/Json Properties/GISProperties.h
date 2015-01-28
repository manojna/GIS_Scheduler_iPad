//
//  GISProperties.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 02/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#ifndef Gallaudet_Interpreting_Service_GISProperties_h
#define Gallaudet_Interpreting_Service_GISProperties_h
//#define GIS_STAGE_BASE_URL @"https://gisapp.gallaudet.edu/GisTest/GisREST.svc/"

#define GIS_STAGE_BASE_URL @"http://gisapp.gallaudet.edu/GisTest/GisREST.svc/"
//#define GIS_STAGE_BASE_URL @"http://125.62.193.235/GIS_M/GisREST.svc/"
//#define GIS_STAGE_BASE_URL @"http://182.72.216.215/GIS_M/GisREST.svc/"

//#define GIS_STAGE_BASE_URL @"http://182.72.216.215/GIS_M/GisREST.svc/"//@"http://125.62.193.235/GIS_M/GisREST.svc/"
#define GIS_USER_LOGIN @"SignIn"

#define GIS_GET_Billing_Details @"GetBillingDetails"

#define GIS_GET_DROP_DOWNS @"GetSchedulerMasters"//@"GetMasters"

#define GIS_GET_EVENT_REQUEST @"GetRequestdetails"

#define GIS_GET_REQUEST_NUMBERS @"GetRequestNumbers"
#define GIS_GET_SP_JOBS_REQUEST_NUMBERS @"GetSPandJobsRequestNumbers"
#define GIS_SAVE_UPDATE_REQUEST @"SaveUpdateRequest"
#define GIS_GET_CHOOSE_REQUEST_DETAILS @"GetRequestdetails"

#define GIS_GET_REQUEST_DETAILS @"GetRequestdetails"
#define GIS_GET_CONTACT_DETAILS @"GetContactDetails"
#define GIS_GET_DATE_TIME_DETAILS @"GetDatetimeDetails"


#define GIS_GET_ATTENDEES_DETAILS @"GetAttendeeDetails"
#define GIS_SAVE_ATTENDEES @"SaveUpdateAttendee"
#define GIS_SAVE_LOCATION @"saveupdaterequest"
#define GIS_SAVE_DATE_TIME @"SaveDateTime"

#define GIS_SAVE_UPDATE_UNAVAILABLE_TIME @"SaveUpdateUnavailableTime"

#define GIS_GET_LOCATION_DETAILS @"GetLocationDetails"
#define GIS_GET_OFFLOCATION_DETAILS @"GetOffcampusdetails"

#define GIS_SEARCH_REQUESTS @"SearchRequests"
#define GIS_SEARCH_JOBS_SERVICE_PROVIDER @"SearchJobs"

#define GIS_GET_SCHEDULE @"GetRequestorSchedule"
#define GIS_INACTIVE_REQUEST @"InactiveRequest"

#define GIS_GET_SERVICE_PROVIDER_SCHEDULE @"GetServiceProviderSchedule"
#define GIS_GET_MY_ASSIGNED_JOBS @"GetMyAssignedJobs"

#define GIS_GET_SEARCH_REQUEST_NUMBERS @"GetSearchRequestNumbers" //This is for the request numbers in Search unfilled jobs and serach request jobs

#define GIS_SUBMIT_TIME_SHEET @"SubmitforTimeSheet"
#define GIS_SUBMIT_FOR_REQUEST @"SubmitforRequest"
#define GIS_SUBMIT_REQUEST @"SubmitRequest"
#define GIS_GET_SCHEDULER_REQUESTED_JOBS @"GetSchedulerSPRequestedJobs"
#define GIS_GET_SCHEDULER_NEW_MODIFIED_REQUESTS @"GetSchedulerNewandModifiedRequests"
#define GIS_GET_SCHEDULER_MASTERS @"GetSchedulerMasters"
#define GIS_SAVE_SPREQUESTED_JOBS @"SaveSPRequestedJobs"
#define GIS_GET_VIEW_EDIT_SCHEDULE @"ViewEditSchedule"
#define GIS_GET_EVENT_TYPE_BY_UNITID @"GetEventTypeByUnitID"


#define GIS_GET_JOB_DETAILS @"GetJobDetails"
#define GIS_GET_SERVICE_PROVIDERS @"ServiceProviders"
#define GIS_GET_VIEWSCHEDULE_SERVICEPROVIDERS_INFO @"SchedulerServiceProviders"
#define GIS_UPDATE_JOBS @"UpdateJobs"
#define GIS_SaveUpdateJobs @"SaveUpdateJobs"
#define GIS_CreateJobs @"CreateJobs"
#define GIS_DeleteJobs @"DeleteJob"


///iPAD
#define GIS_GET_SERVICE_PROVIDERS_NAMES_iPAD @"GetServiceProviders"
#define GIS_SERVICE_PROVIDERS_NAMES_JOBDetails @"ServiceProviders"//This is to get the all service providers, this is going to be used in the Job details list view.
#define GIS_SAVE_MATERIAL_TYPE @"SaveUpdateMaterials"
#define GIS_SEARCH_REQUESTED_JOBS @"SearchRequestsJobs"
#define GIS_SPREQUESTED_JOBS_SEARCH @"SPRequestedJobsSearch"
#define GIS_JOB_ASSIGNMENT @"JobAssignment"
#define GIS_FILTER_JOB_DETAILS @"FilterJobDetails"

#define GIS_UPLOAD @"Upload"

#endif
