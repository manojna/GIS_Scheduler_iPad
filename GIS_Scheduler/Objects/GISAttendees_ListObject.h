//
//  GISAttendeesListObject.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 21/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISAttendees_ListObject : NSObject

@property(nonatomic,strong)NSString *firstname_String;
@property(nonatomic,strong)NSString *lastname_String;
@property(nonatomic,strong)NSString *email_String;
@property(nonatomic,strong)NSString *modeOf_String;
@property(nonatomic,strong)NSString *directly_utilzed_String;
@property(nonatomic,strong)NSString *servicesNeeded_String;

@property(nonatomic,strong)NSString *modeOfCommuniation_ID_String;
@property(nonatomic,strong)NSString *serviceNedded_ID_String;


@property(nonatomic,strong)NSString *request_No_ID_String;
@property(nonatomic,strong)NSString *attendee_ID_String;

- (id)initWithStoreDictionary:(NSDictionary *)json;

@end
