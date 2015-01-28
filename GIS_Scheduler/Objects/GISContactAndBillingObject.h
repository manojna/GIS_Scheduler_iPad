//
//  ContactAndBillingObject.h
//  TableView_Animation
//
//  Created by Paradigm on 08/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GISContactAndBillingObject : NSObject

@property(nonatomic,strong)NSString *chooseRequest_String;
@property(nonatomic,strong)NSString *unitOrDepartment_String;
@property(nonatomic,strong)NSString *firstName_String;
@property(nonatomic,strong)NSString *lastName_String;
@property(nonatomic,strong)NSString *email_String;
@property(nonatomic,strong)NSString *contacts_String;

@property(nonatomic,strong)NSString *accountName_String;
@property(nonatomic,strong)NSString *department_String;
@property(nonatomic,strong)NSString *buh_firstName_String;
@property(nonatomic,strong)NSString *buh_lastName_String;
@property(nonatomic,strong)NSString *buh_email_String;
@property(nonatomic,strong)NSString *buh_address1_String;
@property(nonatomic,strong)NSString *buh_address2_String;
@property(nonatomic,strong)NSString *buh_city_String;
@property(nonatomic,strong)NSString *buh_state_String;
@property(nonatomic,strong)NSString *buh_zip_String;


@property(nonatomic,strong)NSString *unitOrDepartment_ID_String;//This is the ID that is related to the unitOrDepartment_String which is saving while getting the data form the picker
@property(nonatomic,strong)NSString *chooseRequest_ID_String;//This is the ID that is related to the unitOrDepartment_String which is saving while getting the data form the picker






@end
