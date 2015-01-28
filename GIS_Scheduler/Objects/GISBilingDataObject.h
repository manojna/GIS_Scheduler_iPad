//
//  GISBuildingObject.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 15/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISBilingDataObject : NSObject

@property(nonatomic,strong)NSString *department_String;
@property(nonatomic,strong)NSString *buh_firstName_String;
@property(nonatomic,strong)NSString *buh_lastName_String;
@property(nonatomic,strong)NSString *buh_email_String;
@property(nonatomic,strong)NSString *buh_address1_String;
@property(nonatomic,strong)NSString *buh_address2_String;
@property(nonatomic,strong)NSString *buh_city_String;
@property(nonatomic,strong)NSString *buh_state_String;
@property(nonatomic,strong)NSString *buh_zip_String;
- (id)initWithStoreBillingDataDictionary:(NSDictionary *)json;

@end
