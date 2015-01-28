//
//  GISViewEditStore.h
//  GIS_Scheduler
//
//  Created by Anand on 16/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GISViewEditDateObject.h"

@interface GISViewEditStore : NSObject
{
    GISViewEditDateObject *viewEditObj;
}

-(id)initWithJsonDictionary:(NSDictionary *)response;

@end
