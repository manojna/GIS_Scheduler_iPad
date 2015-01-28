//
//  GISDatesTimesDetailStore.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 30/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GISDatesAndTimesObject.h"
@interface GISDatesTimesDetailStore : NSObject
@property(nonatomic,strong) GISDatesAndTimesObject *dateTime_obj_here;
- (id)initWithStoreDictionary:(NSDictionary *)json;
@end
