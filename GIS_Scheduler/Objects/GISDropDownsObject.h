//
//  GISDropDownsObject.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 14/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "GISDropDownStore.h"

//@class GISBuildingNamesObject;
//@class GISDressCodeObject;
//@class GISLocationCodeObject;
//@class GISEventTypeObject;
//@class GISUnitOrDepartmentObject;




@interface GISDropDownsObject : NSObject

@property(nonatomic,strong)NSString *id_String;
@property(nonatomic,strong)NSString *type_String;
@property(nonatomic,strong)NSString *value_String;


//@property (nonatomic, retain) GISBuildingNamesObject *buildingNamesObject;
//@property (nonatomic, retain) GISDressCodeObject *dressCodeObject;
//@property (nonatomic, retain) GISLocationCodeObject *locationCodeObject;
//@property (nonatomic, retain) GISEventTypeObject *eventTypeObject;
//@property (nonatomic, retain) GISUnitOrDepartmentObject *unitOrDepartmentObject;
//
//@property (nonatomic, retain) GISDropDownStore *dropDownStore;

//- (id)initWithDropDownsDictionary:(NSDictionary *)json;

- (id)initWithStoreDictionary:(NSDictionary *)json;


@end
