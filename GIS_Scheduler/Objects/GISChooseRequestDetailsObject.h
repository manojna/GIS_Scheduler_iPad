//
//  GISChooseRequestDetailsObject.h
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 20/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISChooseRequestDetailsObject : NSObject
////These are Event Details values that are parsed from the contacts and billing Choose Request.
@property(nonatomic,strong)NSString *primaryAudience_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *classID_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *courseID_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *dressCodeID_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *eventDescription_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *eventName_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *eventTypeID_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *inCompleteTab_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *isCompleteRequest_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *onGoing_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *openToPublic_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *otherTechnologies_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *outsideAgency_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *recBroadcast_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *recBroadcastYes_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *reqEmail_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *reqFirstName_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *reqLastName_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *requestNo_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *statusID_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *unitID_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *CapNoOfUsers_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *CapViewOptions_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *CaptionTypeID_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *OtherServiceID_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *createdDate_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *requestStatus_String_chooseReqParsedDetails;

@property(nonatomic,strong)NSString *expected_No_of_attendees_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *gender_preference_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *service_providergender_preference_String_chooseReqParsedDetails;

@property(nonatomic,strong)NSString *generalLocation_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *offCamp_address1_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *offCamp_address2_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *offCamp_city_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *offLoc_ID_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *offCamp_state_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *offCamp_zip_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *offCamp_LocationName_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *other_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *otherInfo_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *parking_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *reqLocation_Id_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *ClosestMetro_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *SpecialProtocol_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *building_Id_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *RoomName_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *RoomNunber_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *transportation_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *transportationYes_String_chooseReqParsedDetails;

@property(nonatomic,strong)NSString *schedulerComments_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *adminComments_String_chooseReqParsedDetails;

@property(nonatomic,strong)NSString *balckboardAccess_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *website_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *other_materialType_String_chooseReqParsedDetails;
@property(nonatomic,strong)NSString *document_String_chooseReqParsedDetails;


- (id)initWithStoreChooseRequestDetailsDictionary:(NSDictionary *)json;
@end
