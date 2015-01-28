//
//  GISServiceProviderObject.m
//  GIS_Scheduler
//
//  Created by Anand on 19/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISServiceProviderObject.h"
#import "GISJSONProperties.h"

@implementation GISServiceProviderObject

@synthesize id_String;
@synthesize type_String;
@synthesize spType_String;
@synthesize service_Provider_String;


//@synthesize dropDownStore;


- (id)initWithStoreDictionary:(NSDictionary *)json
{
    if (self = [super init]) {
        
        @try {
            
            id_String = [json objectForKey:kServiceProviderID];
            if(id_String == NULL)
            {
                id_String = @" ";
            }else{
                id_String = [json objectForKey:kServiceProviderID];
            }
            
            type_String = [json objectForKey:kServiceProviderType] == [NSNull null]?@" ":[NSString stringWithString:[json objectForKey:kServiceProviderType]];
            spType_String = [json objectForKey:kServiceProviderSPType] == [NSNull null]?@" ":[NSString stringWithString:[json objectForKey:kServiceProviderSPType]];
            service_Provider_String = [json objectForKey:kServiceProvider] == [NSNull null]?@" ":[NSString stringWithString:[json objectForKey:kServiceProvider]];
        }
        @catch (NSException *exception) {
            NSLog(@"EXCEPTION raised, reason was: %@", [exception reason]);
        }
    }
    return self;
}


@end
