//
//  GISContactsInfoObject.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 16/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISContactsInfoObject : NSObject

@property(nonatomic,strong)NSString *contactInfoId_String;
@property(nonatomic,strong)NSString *contactNo_String;
@property(nonatomic,strong)NSString *contactType_String;
@property(nonatomic,strong)NSString *contactTypeId_String;
@property(nonatomic,strong)NSString *contactTypeNo_String;

- (id)initWithStoreDictionary:(NSDictionary *)json;
@end
