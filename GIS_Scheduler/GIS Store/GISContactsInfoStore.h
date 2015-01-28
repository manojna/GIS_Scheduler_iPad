//
//  GISContactsInfoStore.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 16/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GISContactsInfoObject.h"

@interface GISContactsInfoStore : NSObject

@property(nonatomic,strong)GISContactsInfoObject *contactsObject;
- (id)initWithJsonDictionary:(NSDictionary *)json;


@end
