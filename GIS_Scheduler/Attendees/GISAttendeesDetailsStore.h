//
//  GISAttendeesDetailsStore.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 23/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GISAttendees_ListObject.h"
@interface GISAttendeesDetailsStore : NSObject

@property(nonatomic,strong) GISAttendees_ListObject *attendeesListObj_here;
- (id)initWithStoreDictionary:(NSDictionary *)json;
@end
