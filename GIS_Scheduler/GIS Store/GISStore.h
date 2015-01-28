//
//  GISStore.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 05/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GISLoginDetailsObject.h"
@interface GISStore : NSObject
{
    GISLoginDetailsObject *loginObject;
}

@property (nonatomic, retain) GISLoginDetailsObject *loginObject;
- (id)initWithJsonDictionary:(NSDictionary *)json;
@end
