//
//  GISLoginDetails.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 05/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISLoginDetailsObject : NSObject


@property(nonatomic,strong)NSString * email_string;
@property(nonatomic,strong)NSString * firstName_string;
@property(nonatomic,strong)NSString * lastName_string;
@property(nonatomic,strong)NSString * requestorID_string;
@property(nonatomic,strong)NSString * token_string;
@property(nonatomic,strong)NSString * userStatus_string;
@property(nonatomic,strong)NSString * role_ID_string;
@property(nonatomic,strong)NSString * roles_string;

- (id)initWithStoreDictionary:(NSDictionary *)dictionary;
@end
