//
//  GISJobDetailsStore.h
//  GIS_Scheduler
//
//  Created by Paradigm on 19/08/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GISJobDetailsObject.h"

@interface GISJobDetailsStore : NSObject
{
    GISJobDetailsObject *jobDetailsObj;
}

-(id)initWithJsonDictionary:(NSDictionary *)response;
@end
