//
//  GISJSONProperties.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 06/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#ifndef Gallaudet_Interpreting_Service_GISJSONProperties_h
#define Gallaudet_Interpreting_Service_GISJSONProperties_h

#define kselectedChooseReqNumber @"selectedChooseRequestNumber"
#define KRequestId @"RequestId"
#define KRequestorId @"requestorId"

#pragma mark EventDetails Saving
#define keventDetails_requestNo @"requestNo"
#define keventDetails_requestID @"requestorid"
#define keventDetails_unitId @"unitid"
#define keventDetails_eventName @"eventname"
#define keventDetails_eventId @"eventtypeid"
#define keventDetails_eventPublic @"opentopublic"
#define keventDetails_statusId @"statusid"
#define keventDetails_dresscodeId @"dresscodeid"
#define keventDetails_broadcast @"recbroadcast"
#define keventDetails_onGoing @"ongoing"
#define keventDetails_Othertech @"othertechnologies"
#define keventDetails_CourseId @"courseid"
#define keventDetails_eventDesc @"eventdescription"
#define keventDetails_token @"token"
#define keventDetails_otherServices @"otherservices"
#define keventDetails_captiontype @"captiontypeid"
#define keventDetails_captionView @"capviewoptions"
#define keventDetails_capnoofUsers @"capnoofusers"
#define keventDetails_recordBroadcastYes @"recbroadcastyes"
#define keventDetails_recordBroadcastYes @"recbroadcastyes"
#define keventDetails_OutsideAgency @"OutsideAgency"

#define kPrepMaterialID @"PrepMaterialID"
#define kValue @"Value"

#pragma mark EventDetails Saving

#pragma mark - Login Details Start
#define kLoginEmail @"Email"
#define kLoginFirstName @"FirstName"
#define kLoginLastName @"LastName"
#define kLoginRequestorID @"RequestorID"
#define kLoginToken @"Token"
#define kLoginUserStatus @"UserStatus"
#define kLoginRoleId @"RoleID"
#define kLoginRoles @"Roles"
#define kRequestID @"RequestID"

#define kRequestNo @"RequestNo"
#define kRequestorId @"RequestorId"

#define kToken @"token"

#define kORequest @"oRequest"
#define kOMaterialDetails @"oMaterialDetails"
#define kPrepMaterialID @"PrepMaterialID"
#define kValue @"Value"

#pragma mark - Login Details End


#pragma mark - Get Drop Downs Start
#define kDropDownID  @"ID"
#define kDropDownType  @"Type"
#define kDropDownValue  @"Value"

#define kBuildingNames  @"Building_Name"
#define kDressCode  @"Dress_Code"
#define kLocationCode  @"General_Location"
#define kEventType  @"Event_Type"
#define kunitOrDep  @"Unit_Department"
#define kRequestNumbers  @"Request_Numbers"
#define kJob_RequestNumbers  @"Jobs_Request_Numbers"
#define kJob_SPRequestNumbers  @"SP_Request_Numbers"
#define kRequest_Number_Search  @"Request_Number"//This is for search unfilled and search request jobs
#define kMode_of_Communication  @"Mode_of_Communication"
#define kService_Needed  @"Service_Needed"
#define kServiceProvider_GenderPref  @"ServiceProvider_GenderPref"
#define kClosest_metro @"Closest_Metro"
#define kLocationName @"Location_Name"
#define kPrimary_Audience @"Primary_Audience"
#define kSkill_Level @"Skill_Level"
#define kPay_Level @"Pay_Level"
#define kBill_Level @"Bill_Level"
#define kPayStatus_ExpStatus @"PayStatus_ExpStatus"
#define kServiceType_serviceProvider @"Serviceprovider_Type"
#define kServiceType_Registerd_Consumers @"Registerd_Consumers"
#define kPayType @"Pay_Type"
#define kTypeOfService @"TypeofService"
#define kRegisterd_Consumers @"Registerd_Consumers"
#define kRequestors @"Requestors"
#define kMode @"Mode"
#define kCreated_By @"Created_By"
#define kRequestor_Type @"Requestor_Type"
#pragma mark - Get Drop Downs End


#pragma mark posting to Contacts and Billing Start
#define kID @"id"

#define kunitid @"unitid"
#define krequestorid @"requestorid"
#define kstatusid @"statusid"
#define kStatusID @"StatusID"
#define kToken_capital_T @"Token"
#define kRequestNo @"RequestNo"
#define kStatusCode @"StatusCode"
#define kStatus @"Status"
#define kInComplete @"6"
#define kNewValue @"NewValue"
#pragma mark posting to Contacts and Billing End

#pragma mark - BillingsData start
#define kBillingData_BUHAddress1 @"BUHAddress1"
#define kBillingData_BUHAddress2 @"BUHAddress2"
#define kBillingData_BUHCity @"BUHCity"
#define kBillingData_BUHEmail @"BUHEmail"
#define kBillingData_BUHFirstName @"BUHFirstName"
#define kBillingData_BUHLastName @"BUHLastName"
#define kBillingData_BUHState @"BUHState"
#define kBillingData_BUHZip @"BUHZip"
#define kBillingData_Department @"Department"

#pragma mark - Billings Data End

#pragma mark - GET_REQUEST_DETAILS START
#define KGetRequestDetails_UnitID @"UnitID"
#define KGetRequestDetails_inCompleteTab @"InCompleteTab"
#define KGetRequestDetails_isCompleted @"InCompleteTab"
#define KGetRequestDetails_reqFirstName @"ReqFirstName"
#define KGetRequestDetails_reqLastName @"ReqLastName"
#define KGetRequestDetails_reqemail @"ReqEmail"
#define KGetRequestDetails_requestNo @"RequestNo"
#pragma mark - GET_REQUEST_DETAILS END


#pragma mark - Contacts Info start
#define kGetContactInfoId @"ContactInfoId"
#define kGetContactNo @"ContactNo"
#define kGetContactType @"ContactType"
#define kGetContactTypeId @"ContactTypeId"
#define kGetContactTypeNo @"ContactTypeNo"
#pragma mark - Contacts Info nd


#pragma mark - Choose Request Detailed Details start
#define kChooseReqDetails_ClassID @"ClassID"
#define kChooseReqDetails_CourseID @"CourseID"
#define kChooseReqDetails_DressCodeID @"DressCodeID"
#define kChooseReqDetails_EventDescription @"EventDescription"
#define kChooseReqDetails_EventName @"EventName"
#define kChooseReqDetails_EventTypeID @"EventTypeID"
#define kChooseReqDetails_InCompleteTab @"InCompleteTab"
#define kChooseReqDetails_IsCompleteRequest @"IsCompleteRequest"
#define kChooseReqDetails_OnGoing @"OnGoing"
#define kChooseReqDetails_OpenToPublic @"OpenToPublic"
#define kChooseReqDetails_OtherTechnologies @"OtherTechnologies"
#define kChooseReqDetails_OutsideAgency @"OutsideAgency"
#define kChooseReqDetails_RecBroadcast @"RecBroadcast"
#define kChooseReqDetails_RecBroadcastYes @"RecBroadcastYes"
#define kChooseReqDetails_ReqEmail @"ReqEmail"
#define kChooseReqDetails_ReqFirstName @"ReqFirstName"
#define kChooseReqDetails_ReqLastName @"ReqLastName"
#define kChooseReqDetails_RequestNo @"RequestNo"
#define kChooseReqDetails_StatusID @"StatusID"
#define kChooseReqDetails_UnitID @"UnitID"
#define kChooseReqDetails_capnoofUsers @"CapNoOfUsers"
#define kChooseReqDetails_capViewOptions @"CapViewOptions"
#define kChooseReqDetails_capTypeId @"CaptionTypeID"
#define kChooseReqDetails_otherServiceID @"OtherServiceID"
#define kChooseReqDetails_createdDate @"CreatedDate"
#define kChooseReqDetails_requestStatus @"RequestStatus"

#define kChooseReqDetails_ExpectedNoOfAttendees @"ExpectedNoOfAttendees"
#define kChooseReqDetails_GenderPref @"GenderPref"
#define kChooseReqDetails_ServiceProviderGenderPref @"ServiceProviderGenderPref"

#define kChooseReqDetails_reqlocationid @"ReqLocationID"
#define kChooseReqDetails_generallocationid @"GeneralLocationID"
#define kChooseReqDetails_buildingid @"BuildingID"
#define kChooseReqDetails_roomnunber @"RoomNunber"
#define kChooseReqDetails_roomname @"RoomName"
#define kChooseReqDetails_other @"Other"
#define kChooseReqDetails_offcamplocname @"OffCamplocName"
#define kChooseReqDetails_offcampaddress1 @"OffCampAddress1"
#define kChooseReqDetails_offcampaddress2 @"OffCampAddress2"
#define kChooseReqDetails_offcampstate @"OffCampState"
#define kChooseReqDetails_offcampcity @"OffCampCity"
#define kChooseReqDetails_offcampzip @"OffCampZip"
#define kChooseReqDetails_closestmetro @"ClosestMetro"
#define kChooseReqDetails_parking @"Parking"
#define kChooseReqDetails_specialprotocol @"SpecialProtocol"
#define kChooseReqDetails_other_info @"OtherInfo"
#define kChooseReqDetails_OffCampLocID @"OffCampLocID"
#define kChooseReqDetails_Transport @"Transport"
#define kChooseReqDetails_transportnotes @"TransportNotes"
#define kChooseReqDetails_adminComments @"AdminComments"
#define kChooseReqDetails_schedulerComments @"SchedulerComments"
#define kChooseReqDetails_InCompleteTab @"InCompleteTab"
#define kChooseReqDetails_IsCompleteRequest @"IsCompleteRequest"
#define kChooseReqDetails_PrimaryAudience @"PrimaryAudience"
#define kChooseReqDetails_document @"Document"
#define kChooseReqDetails_blackBoardAccess @"BlackboardAccess"
#define kChooseReqDetails_website @"Website"
#define kChooseReqDetails_OtherMaterialType @"OtherMaterial"

#pragma mark - Choose Request Detailed Details END


#pragma mark Attendees Start
#define kAttendees_oRequest @"oRequest"
#define kAttendees_Firstname @"attfirstname"
#define kAttendees_Lastname @"attlastname"
#define kAttendees_Attendee_ID @"attendeeID"
#define kAttendees_Email @"attemail"
#define kAttendees_Modeofcommunication @"attmodeofcommunication"
#define kAttendees_Serviceneeded @"attserviceneeded"
#define kAttendees_Utilizeservice @"attutilizeservice"
#define kAttendees_RequestNo @"RequestNo"
#define kAttendees_NoOfAttendees @"NoOfAttendees"
#define kAttendees_GenderPreference @"GenderPreference"
#define kAttendees_ServiceProviderGenderPref @"ServiceProviderGenderPref"
#define kAttendees_PrimaryAudience @"PrimaryAudience"
#define kAttendees_token @"token"
#define kAttendees_oAttendee @"oAttendee"
#pragma mark Attendees End

#pragma mark Attendees Details Start
#define kAttendees_Details_AttendeeEmail @"AttendeeEmail"
#define kAttendees_Details_AttendeeFirstName @"AttendeeFirstName"
#define kAttendees_Details_AttendeeID @"AttendeeID"
#define kAttendees_Details_AttendeeLastName @"AttendeeLastName"
#define kAttendees_Details_DirectlyUnitlizeService @"DirectlyUnitlizeService"
#define kAttendees_Details_ModeOfCommunication @"ModeOfCommunication"
#define kAttendees_Details_RequestNo @"RequestNo"
#define kAttendees_Details_TypeOfServiceNeeded @"TypeOfServiceNeeded"
#pragma mark Attendees Details  End

#pragma mark Location Start

#define kLocation_eventname @"eventname"
#define kLocation_reqlocationid @"reqlocationid"
#define kLocation_generallocationid @"generallocationid"
#define kLocation_buildingid @"buildingid"
#define kLocation_roomnunber @"roomnunber"
#define kLocation_roomname @"roomname"
#define kLocation_other @"other"
#define kLocation_offcamplocname @"offcamplocname"
#define kLocation_offcampaddress1 @"offcampaddress1"
#define kLocation_offcampaddress2 @"offcampaddress2"
#define kLocation_offcampstate @"offcampstate"
#define kLocation_offcampcity @"offcampcity"
#define kLocation_offcampzip @"offcampzip"
#define kLocation_closestmetro @"closestmetro"
#define kLocation_parking @"parking"
#define kLocation_specialprotocol @"specialprotocol"
#define kLocation_other_info @"otherinfo"
#define kLocation_OffCampLocID @"OffCampLocID"
#define kLocation_transport @"transport"
#define kLocation_transportnotes @"transportnotes"
#define kLocationrequestorid @"requestorId"

#pragma mark Location End

#pragma mark Date_Time Start
#define kDateTime_activein @"activein"
#define kDateTime_oRequest @"oRequest"
#define kDateTime_datetimeID @"datetimeID"
#define kDateTime_requestNo @"requestNo"
#define kDateTime_date @"date"
#define kDateTime_starttime @"starttime"
#define kDateTime_endtime @"endtime"
#define kDateTime_oDatetime @"oDatetime"
#define kDateTime_RequestorID @"RequestorID"
#define kDateTime_token @"token"

#define kDateTime_Detail_Date @"Date"
#define kDateTime_Detail_DateTimeId @"DateTimeId"
#define kDateTime_Detail_Day @"Day"
#define kDateTime_Detail_EndTime @"EndTime"
#define kDateTime_Detail_StartTime @"StartTime"
#define kDateTime_Detail_Status @"Status"
#define kDateTime_Detail_StatusCode @"StatusCode"
#pragma mark Date_Time End


#pragma mark offLocation data Start

#define kOffLoc_Address1 @"Address1"
#define kOffLoc_Address2 @"Address2"
#define kOffLoc_City @"City"
#define kOffLoc_Closestmetro @"Closestmetro"
#define kOffLoc_LocationName @"LocationName"
#define kOffLoc_State @"State"
#define kOffLoc_Zip @"Zip"


#pragma mark offLocation data End


#pragma mark Search Request Start
#define kSearchRequest_ModeID @"ModeID"
#define kSearchRequest_WeekDays @"WeekDays"
#define kSearchRequest_StartTime @"StartTime"
#define kSearchRequest_EndTime @"EndTime"
#define kSearchRequest_StartDate @"StartDate"
#define kSearchRequest_EndDate @"EndDate"
#define kSearchRequest_OpenToPublic @"OpenToPublic"
#define kSearchRequest_PrimaryAudienceid @"PrimaryAudienceid"
#define kSearchRequest_EventTypeID @"EventTypeID"
#define kSearchRequest_LocationID @"LocationID"
#define kSearchRequest_RequestorID @"RequestorID"
#define kSearchRequest_UnitID @"UnitID"

//Search Req Jobs
#define kSearchReq_Result_EndTime @"EndTime"
#define kSearchReq_Result_EventTitle @"EventTitle"
#define kSearchReq_Result_RequestId @"RequestId"
#define kSearchReq_Result_RequestNumber @"RequestNumber"
#define kSearchReq_Result_RequestStatus @"RequestStatus"
#define kSearchReq_Result_RequestedDate @"RequestedDate"
#define kSearchReq_Result_StartTime @"StartTime"
#define kSearchReq_Result_Status @"Status"
#define kSearchReq_Result_StatusCode @"StatusCode"

//Additiomal Service Provider Search jobs
#define kSearchReq_Result_JobDate @"JobDate"
#define kSearchReq_Result_JobID @"JobID"
#define kSearchReq_Result_JobNumber @"JobNumber"
#define kSearchReq_Result_State @"State"
#define kSearchReq_Result_GeneralLocation @"GeneralLocation"
#define kSearchReq_Result_EventType @"EventType"
#define kSearchReq_Result_UnitId @"UnitId"
//Search Req Result_service Provider SP=ServiceProvider
#define kSearchReq_SP_StartDate @"StartDate"
#define kSearchReq_SP_EndDate @"EndDate"
#define kSearchReq_SP_StartTime @"StartTime"
#define kSearchReq_SP_EndTime @"EndTime"
#define kSearchReq_SP_WeekDays @"WeekDays"
#define kSearchReq_SP_SpTypeID @"SpTypeID"
#define kSearchReq_SP_OnGoing @"OnGoing"
#define kSearchReq_SP_LocationID @"LocationID"
#define kSearchReq_SP_OpenToPublic @"OpenToPublic"
#define kSearchReq_SP_RequestID @"RequestID"
#define kSearchReq_SP_EventTypeID @"EventTypeID"
#define kSearchReq_SP_SkillLevel @"SkillLevel"
#define kSearchReq_SP_PayLevel @"PayLevel"
#define kSearchReq_SP_requestorId @"RequestorID"
#define kSearchReq_SP_token @"token"
#define kSearchReq_SP_RequestedJobs "Requested Jobs"
#pragma mark Search Request End

#pragma mark viewSchedule data Start

#define kEditSchedule_CreatedDate @"CreatedDate"
#define kEditSchedule_EventTitle @"EventTitle"
#define kEditSchedule_RequestId @"RequestId"
#define kEditSchedule_RequestNumber @"RequestNumber"
#define kEditSchedule_RequestStatus @"RequestStatus"
#define kEditSchedule_Scheduler @"Scheduler"
#define kEditSchedule_UnitNo @"UnitNo"
#define kEditSchedule_RequestColor @"RequestColor"
#define kEditSchedule_StartTime @"StartTime"
#define kEditSchedule_EndTime @"EndTime"

//Additional Fields for Service Provider View Schedule
#define kEditSchedule_EventType @"EventType"
#define kEditSchedule_JobDate @"JobDate"
#define kEditSchedule_JobID @"JobID"
#define kEditSchedule_State @"State"
#define kEditSchedule_Status @"Status"
#define kEditSchedule_StatusCode @"StatusCode"
#define kEditSchedule_jobNumber @"JobNumber"
#define kEditSchedule_generalLocation @"GeneralLocation"
#define kEditSchedule_unAvailableID @"UnavailableID"


#define kServiceProvider_State_MyJobs @"My jobs"
#define kServiceProvider_State_CurrentJobs @""
#define kServiceProvider_State_RequestedJobs @"Requested Jobs"
#define kServiceProvider_State_UnavailableTime @"Unavailable Time"

#pragma mark offLocation data End

////For Tabs
#define  kmyJobsTab @"myJobsTab"
#define  kcurrentJobsTab @"currentJobsTab"
#define  krequestedJobsTab @"requestedJobsTab"
//These are the Response constants that are from the web service

//Comparisons
#define  kInternal @"Internal"


#pragma mark My Jobs Start
#define kMyJobs_BuildingName @"BuildingName"
#define kMyJobs_CallInTime @"CallInTime"
#define kMyJobs_Description @"Description"
#define kMyJobs_EndTime  @"EndTime"
#define kMyJobs_EventTitle  @"EventTitle"
#define kMyJobs_EventType  @"EventType"
#define kMyJobs_GeneralLocation  @"GeneralLocation"
#define kMyJobs_JobAssignedBy  @"JobAssignedBy"
#define kMyJobs_JobCreatedBy  @"JobCreatedBy"
#define kMyJobs_jobID @"JobId"
#define kMyJobs_JobDate  @"JobDate"
#define kMyJobs_JobNumber  @"JobNumber"
#define kMyJobs_Mileage  @"Mileage"
#define kMyJobs_Notes  @"Notes"
#define kMyJobs_Parking  @"Parking"
#define kMyJobs_PayType  @"PayType"
#define kMyJobs_RequestID  @"RequestID"
#define kMyJobs_RoomName  @"RoomName"
#define kMyJobs_RoomNumber  @"RoomNumber"
#define kMyJobs_Slots  @"Slots"
#define kMyJobs_StartTime  @"StartTime"
#define kMyJobs_Status  @"Status"
#define kMyJobs_StatusID  @"StatusID"
#define kMyJobs_TotalHours  @"TotalHours"

#pragma mark My Jobs  End

#pragma Mark Mark Unavailable Time Start
#define kUnavailableTime_SPUnAvaliableID  @"SPUnAvaliableID"
#define kUnavailableTime_Date  @"Date"
#define kUnavailableTime_StartTime  @"StartTime"
#define kUnavailableTime_EndTime  @"EndTime"
#define kUnavailableTime_Note  @"Note"
#define kUnavailableTime_requestorId @"requestorId"
#define kUnavailableTime_oToken @"oToken"
#define kUnavailableTime_oUnavailableTime @"oUnavailableTime"
#define kUnavailableTime_StatusID @"StatusID"
#pragma Mark Mark Unavailable Time End

#pragma Mark SubmitTimeSheet Start
#define kSubmitForRequest_JobId @"JobID"
#define kSubmitTimeSheet_JobId @"JobId"
#define kSubmitTimeSheet_SpType @"SpType"
#define kSubmitTimeSheet_CallIntime @"CallIntime"
#define kSubmitTimeSheet_EventDescription @"EventDescription"
#define kSubmitTimeSheet_Parking @"Parking"
#define kSubmitTimeSheet_Mileage @"Mileage"
#define kSubmitTimeSheet_token @"token"

#pragma Mark SubmitTimeSheet End


#pragma Mark ServiceProviderSPRequestJobs Start

#define kSPRequestJobs_EventType @"EventType"
#define kSPRequestJobs_EndTime @"EndTime"
#define kSPRequestJobs_GisResponse @"GISResponse"
#define kSPRequestJobs_JobDate @"JobDate"
#define kSPRequestJobs_JobID @"JobID"
#define kSPRequestJobs_JobNumber @"JobNumber"
#define kSPRequestJobs_PayType @"PayType"
#define kSPRequestJobs_RequestedDate @"RequestedDate"
#define kSPRequestJobs_StartTime @"StartTime"
#define kSPRequestJobs_ServiceProviderName @"ServiceProviderName"
#define kSPRequestJobs_TotalHours @"TotalHours"
#define kSPRequestJobs_SPRequestJobID @"SPRequestJobID"
#define kSPRequestJobs_AccountName @"AccountName"
#define kSPRequestJobs_BillAmount @"BillAmount"
#define kSPRequestJobs_OutToAgency @"OutToAgency"
#define kSPRequestJobs_Location @"Location"
#define kSPRequestJobs_RequestorName @"RequestorName"
#define kSPRequestJobs_SubRole @"SubRole"
#define kSPRequestJobs_Timely @"Timely"
#define kSPRequestJobs_TypeofService @"TypeofService"
#pragma Mark ServiceProviderSPRequestJobs End

#pragma Mark ServiceProviderNMRequests Start

#define kNMRequests_AccountName @"AccountName"
#define kNMRequests_ApprovalDate @"ApprovalDate"
#define kNMRequests_ApproveddBy @"ApproveddBy"
#define kNMRequests_DateofEarlierAssigment @"DateofEarlierAssigment"
#define kNMRequests_EarliestDate @"EarliestDate"
#define kNMRequests_EventType @"EventType"
#define kNMRequests_OtherServices @"OtherServices"
#define kNMRequests_RequestID @"RequestID"
#define kNMRequests_RequestStatus @"RequestStatus"
#define kNMRequests_RequestSubmissionDate @"RequestSubmissionDate"
#define kNMRequests_Shceduler @"Shceduler"
#define kNMRequests_Tab @"Tab"

#pragma Mark ServiceProviderNMRequests End


#pragma mark JobDetails Start
#define kJobDetais_BillAmount @"BillAmount"
#define kJobDetais_EndTime @"EndTime"
#define kJobDetais_JobDate @"JobDate"
#define kJobDetais_JobID @"JobID"
#define kJobDetais_JobNumber @"JobNumber"
#define kJobDetais_PayType @"PayType"
#define kJobDetais_ServiceProvider @"ServiceProvider"
#define kJobDetais_StartTime @"StartTime"
#define kJobDetais_Status @"Status"
#define kJobDetais_StatusCode @"StatusCode"
#define kJobDetais_Timely @"Timely"
#define kJobDetais_TypeofService @"TypeofService"
#define kJobDetais_FilledUnFilled @"FilledUnFilled"
#define kJobDetais_Slots @"Slots"
#define kJobDetais_deleteJob @"Deletejob"

#pragma mark JobDetails End

#pragma Mark ViewEditSchedle Start

#define kViewSchedule_BillAmount @"BillAmount"
#define kViewSchedule_EndTime @"EndTime"
#define kViewSchedule_JobDate @"JobDate"
#define kViewSchedule_JobID @"JobID"
#define kViewSchedule_JobNumber @"JobNumber"
#define kViewSchedule_PayType @"PayType"
#define kViewSchedule_ServiceProvider @"ServiceProvider"
#define kViewSchedule_StartTime @"StartTime"
#define kViewSchedule_Timely @"Timely"
#define kViewSchedule_TypeofService @"TypeofService"
#define kViewSchedule_ServiceProviderID @"ServiceProviderID"
#define kViewSchedule_SubroleID @"SubRoleID"
#define kViewSchedule_PayTypeID @"PayTypeID"
#define kViewSchedule_JobNotes @"JobNotes"
#define kViewSchedule_SubRole @"SubRole"
#define kViewSchedule_EventType @"EventType"
#define kViewSchedule_RequestApproved @"RequestApproved"

#pragma mark JobDetails End

#pragma Mark ServiceProvider Start

#define kServiceProviderID  @"ID"
#define kServiceProviderType  @"Type"
#define kServiceProviderSPType  @"SpType"
#define kServiceProvider @"ServiceProvider"
#define kServiceProviderResult @"ServiceProvidersResult"
#define kViewScheduleServiceProviderResult @"SchedulerServiceProvidersResult"
#define kRegisteredConsumers @"RegisteredConsumers"
#define kUnitNumber @"UnitNumber"
#define kAccountType @"AccountType"
#pragma mark ServiceProvider End

#define kPayLevelID @"PayLevelID"
#define kCancel @"Cancel"
#define kOutToAgency @"OutToAgency"
#define kAmtPaid @"AmtPaid"
#define kAgencyFee @"AgencyFee"
#define kOverrideBill @"OverrideBill"
#define kPayStatus @"PayStatus"
#define kExpenseStatus @"ExpenseStatus"
#define kBillingLevelID @"BillingLevelID"
#define koJobs @"oJobs"

#define kRequestSDate @"RequestSDate"
#define kRequestEDate @"RequestEDate"
#define kRequestorTypeID @"RequestorTypeID"
#define kConsumerID @"ConsumerID"
#define kJobSDate @"JobSDate"
#define kJobEDate @"JobEDate"
#define kJobSTime @"JobSTime"
#define kJobETime @"JobETime"
#define kDays @"Days"
#define kTypeID @"TypeID"
#define kSPID @"SPID"
#define kFilled @"Filled"
#define kOutAgency @"OutAgency"
#define kCreatedBy @"CreatedBy"
#define kCanceled @"Canceled"
#define kCancelDate @"CancelDate"
#define kRPayLevelID @"RPayLevelID"
#define kRequestReturn @"RequestReturn"
#define kJobReturn @"JobReturn"
#define kRPayLevelID @"RPayLevelID"
#define kModeID @"ModeID"
#define kPrimaryAudianceID @"PrimaryAudienceid"


#pragma Mark SPRequested Jobs Search Start

#define kSPRequetstesJobsSearchJobsDate  @"JobSDate"
#define kSPRequetstesJobsSearchJobEDate  @"JobEDate"
#define kSPRequetstesJobsSearchJobSTime  @"JobSTime"
#define kSPRequetstesJobsSearchJobETime @"JobETime"
#define kSPRequetstesJobsSearchDays @"Days"
#define kSPRequetstesJobsSearchSpTypeID  @"SpTypeID"
#define kSPRequetstesJobsSearchnoOfExpAttendID  @"noOfExpAttendID"
#define kSPRequetstesJobsSearchLocationID  @"LocationID"
#define kSPRequetstesJobsSearchonGoing @"onGoing"
#define kSPRequetstesJobsSearchrecordedOrBoardCast @"recordedOrBoardCast"
#define kSPRequetstesJobsSearchOpenToPublic  @"OpenToPublic"
#define kSPRequetstesJobsSearchEventTypeID @"EventTypeID"
#define kSPRequetstesJobsSearchSPID @"SPID"

#pragma mark SPRequested Jobs Search End

#pragma Mark Job Assignment Start

#define kJobAssignmentStartDate  @"StartDate"
#define kJobAssignmentEndDate  @"EndDate"
#define kJobAssignmentSPSubRole  @"SPSubRole"

#pragma mark Job Assignment End


#endif







