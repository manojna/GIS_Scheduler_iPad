//
//  GISDropDownStore.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 15/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GISDropDownsObject.h"

@interface GISDropDownStore : NSObject


@property(nonatomic,strong)GISDropDownsObject *dropDownObject;
- (id)initWithStoreDictionary:(NSDictionary *)json;
@end
