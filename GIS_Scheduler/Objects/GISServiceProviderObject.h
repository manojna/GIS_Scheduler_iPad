//
//  GISServiceProviderObject.h
//  GIS_Scheduler
//
//  Created by Anand on 19/09/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISServiceProviderObject : NSObject

@property(nonatomic,strong)NSString *id_String;
@property(nonatomic,strong)NSString *type_String;
@property(nonatomic,strong)NSString *service_Provider_String;
@property(nonatomic,strong)NSString *spType_String;

- (id)initWithStoreDictionary:(NSDictionary *)json;

@end
