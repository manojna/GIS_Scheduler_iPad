//
//  GISChooseRequestDetailsObject.m
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 20/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISChooseRequestDetailsObject.h"
#import "GISJSONProperties.h"
#import "GISUtility.h"
@implementation GISChooseRequestDetailsObject
@synthesize classID_String_chooseReqParsedDetails;
@synthesize courseID_String_chooseReqParsedDetails;
@synthesize dressCodeID_String_chooseReqParsedDetails;
@synthesize eventDescription_String_chooseReqParsedDetails;
@synthesize eventName_String_chooseReqParsedDetails;
@synthesize eventTypeID_String_chooseReqParsedDetails;
@synthesize inCompleteTab_String_chooseReqParsedDetails;
@synthesize isCompleteRequest_String_chooseReqParsedDetails;
@synthesize onGoing_String_chooseReqParsedDetails;
@synthesize openToPublic_String_chooseReqParsedDetails;
@synthesize otherTechnologies_String_chooseReqParsedDetails;
@synthesize outsideAgency_String_chooseReqParsedDetails;
@synthesize recBroadcast_String_chooseReqParsedDetails;
@synthesize recBroadcastYes_String_chooseReqParsedDetails;
@synthesize reqEmail_String_chooseReqParsedDetails;
@synthesize reqFirstName_String_chooseReqParsedDetails;
@synthesize reqLastName_String_chooseReqParsedDetails;
@synthesize requestNo_String_chooseReqParsedDetails;
@synthesize statusID_String_chooseReqParsedDetails;
@synthesize unitID_String_chooseReqParsedDetails;
@synthesize CapNoOfUsers_String_chooseReqParsedDetails;
@synthesize CaptionTypeID_String_chooseReqParsedDetails;
@synthesize CapViewOptions_String_chooseReqParsedDetails;
@synthesize OtherServiceID_String_chooseReqParsedDetails;
@synthesize createdDate_String_chooseReqParsedDetails;


@synthesize generalLocation_String_chooseReqParsedDetails;
@synthesize offCamp_address1_String_chooseReqParsedDetails;
@synthesize offCamp_address2_String_chooseReqParsedDetails;
@synthesize offCamp_city_String_chooseReqParsedDetails;
@synthesize offLoc_ID_String_chooseReqParsedDetails;
@synthesize offCamp_state_String_chooseReqParsedDetails;
@synthesize offCamp_zip_String_chooseReqParsedDetails;
@synthesize offCamp_LocationName_String_chooseReqParsedDetails;
@synthesize other_String_chooseReqParsedDetails;
@synthesize otherInfo_String_chooseReqParsedDetails;
@synthesize parking_String_chooseReqParsedDetails;
@synthesize reqLocation_Id_chooseReqParsedDetails;
@synthesize ClosestMetro_String_chooseReqParsedDetails;
@synthesize SpecialProtocol_String_chooseReqParsedDetails;
@synthesize building_Id_String_chooseReqParsedDetails;
@synthesize RoomName_String_chooseReqParsedDetails;
@synthesize RoomNunber_String_chooseReqParsedDetails;
@synthesize transportation_String_chooseReqParsedDetails;
@synthesize transportationYes_String_chooseReqParsedDetails;
@synthesize adminComments_String_chooseReqParsedDetails;
@synthesize schedulerComments_String_chooseReqParsedDetails;
@synthesize requestStatus_String_chooseReqParsedDetails;
@synthesize document_String_chooseReqParsedDetails;
@synthesize balckboardAccess_String_chooseReqParsedDetails;
@synthesize website_String_chooseReqParsedDetails;
@synthesize other_materialType_String_chooseReqParsedDetails;

@synthesize primaryAudience_String_chooseReqParsedDetails;

@synthesize expected_No_of_attendees_String_chooseReqParsedDetails,gender_preference_String_chooseReqParsedDetails,service_providergender_preference_String_chooseReqParsedDetails;

- (id)initWithStoreChooseRequestDetailsDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        @try {
            
            
            if ([json isKindOfClass:[NSDictionary class]]) {
            }
            else if ([json isKindOfClass:[NSArray class]]) {
                NSArray *array=(NSArray *)json;
                NSDictionary *dict=[array lastObject];
                
                classID_String_chooseReqParsedDetails=[self returningstring: [dict objectForKey:kChooseReqDetails_ClassID]];
                courseID_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_CourseID ]];
                dressCodeID_String_chooseReqParsedDetails= [self returningstring: [dict objectForKey:kChooseReqDetails_DressCodeID ]];
                eventDescription_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_EventDescription ]];
                eventName_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_EventName ]];
                eventTypeID_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_EventTypeID ]];
                inCompleteTab_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_InCompleteTab ]];
                isCompleteRequest_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_IsCompleteRequest ]];
                onGoing_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_OnGoing ]];
                openToPublic_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_OpenToPublic ]];
                otherTechnologies_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_OtherTechnologies ]];
                outsideAgency_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_OutsideAgency ]];
                recBroadcast_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_RecBroadcast ]];
                recBroadcastYes_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_RecBroadcastYes ]];
                reqEmail_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_ReqEmail ]];
                reqFirstName_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_ReqFirstName ]];
                reqLastName_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_ReqLastName ]];
                requestNo_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_RequestNo ]];
                statusID_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_StatusID ]];
                unitID_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_UnitID ]];
                CapNoOfUsers_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_capnoofUsers ]];
                CaptionTypeID_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_capTypeId]];
                CapViewOptions_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_capViewOptions]];
                OtherServiceID_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_otherServiceID ]];
                createdDate_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_createdDate ]];
                requestStatus_String_chooseReqParsedDetails = [self returningstring:[dict objectForKey:kChooseReqDetails_requestStatus ]];
                
                expected_No_of_attendees_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_ExpectedNoOfAttendees]];
                gender_preference_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_GenderPref]];
                service_providergender_preference_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_ServiceProviderGenderPref ]];
                
                generalLocation_String_chooseReqParsedDetails = [self returningstring:[dict objectForKey:kChooseReqDetails_generallocationid]];
                offCamp_address1_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_offcampaddress1 ]];
                offCamp_address2_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_offcampaddress2 ]];
                offCamp_city_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_offcampcity ]];
                offCamp_state_String_chooseReqParsedDetails = [self returningstring:[dict objectForKey:kChooseReqDetails_offcampstate ]];
                offCamp_zip_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_offcampzip ]];
                offCamp_LocationName_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_offcamplocname ]];
                other_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_other ]];
                otherInfo_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_other_info ]];
                parking_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_parking ]];
                reqLocation_Id_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_reqlocationid ]];
                ClosestMetro_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_closestmetro ]];
                SpecialProtocol_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_specialprotocol ]];
                building_Id_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_buildingid ]];
                RoomName_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_roomname]];
                RoomNunber_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_roomnunber]];
                offLoc_ID_String_chooseReqParsedDetails= [self returningstring:[dict objectForKey:kChooseReqDetails_OffCampLocID]];
                transportation_String_chooseReqParsedDetails =  [self returningstring:[dict objectForKey:kChooseReqDetails_Transport]];
                transportationYes_String_chooseReqParsedDetails =  [self returningstring:[dict objectForKey:kChooseReqDetails_transportnotes]];
                adminComments_String_chooseReqParsedDetails =  [self returningstring:[dict objectForKey:kChooseReqDetails_adminComments]];
                schedulerComments_String_chooseReqParsedDetails =  [self returningstring:[dict objectForKey:kChooseReqDetails_schedulerComments]];
                primaryAudience_String_chooseReqParsedDetails =  [self returningstring:[dict objectForKey:kChooseReqDetails_PrimaryAudience]];
                
                website_String_chooseReqParsedDetails =  [self returningstring:[dict objectForKey:kChooseReqDetails_website]];
                balckboardAccess_String_chooseReqParsedDetails =  [self returningstring:[dict objectForKey:kChooseReqDetails_blackBoardAccess]];
                document_String_chooseReqParsedDetails =  [self returningstring:[dict objectForKey:kChooseReqDetails_document]];
                other_materialType_String_chooseReqParsedDetails =  [self returningstring:[dict objectForKey:kChooseReqDetails_OtherMaterialType]];
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

    if ([string isKindOfClass:[NSNull class]] || string == (NSString*) [NSNull null] || string == nil)
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
            NSString *str=[NSString stringWithFormat:@"%@",string];
            return str;
        }
    }
    
}

@end
