//
//  GISServiceProviderStore.h
//  GIS_Scheduler
//
//  Created by Anand on 19/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GISServiceProviderObject.h"

@interface GISServiceProviderStore : NSObject{
    
    GISServiceProviderObject *serviceProviderObj;
}

-(id)initWithJsonDictionary:(NSDictionary *)response;

@end
