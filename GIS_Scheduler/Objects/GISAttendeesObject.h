//
//  GISAttendeesObject.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 21/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISAttendeesObject : NSObject

@property(nonatomic,strong)NSString *choose_request_String;
@property(nonatomic,strong)NSString *expectedNo_String,*expectedNo_ID_String;
@property(nonatomic,strong)NSString *genderPreference_String,*genderPreference_ID_String;
@property(nonatomic,strong)NSString *preference_String;

@property(nonatomic,strong)NSMutableArray *attendeesList_mutArray;


@property(nonatomic,strong)NSString *choose_request_ID_String;

@property(nonatomic,strong)NSString *preference_ID_String;

@property(nonatomic,strong)NSString *primaryAudience_String,*primaryAudience_ID_String;
@end
