//
//  GISConstants.h
//  Gallaudet-Interpreting-Service
//
//  Created by Paradigm on 02/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#ifndef Gallaudet_Interpreting_Service_GISConstants_h
#define Gallaudet_Interpreting_Service_GISConstants_h


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define TABLE @"custom"

#define kFontFamilyNormal @"MyriadPro-Regular"
#define kFontFamilyBold  @"MyriadPro-Semibold"

#define kSelectPopOver  @"SelectPopover"
#define kMoveUp  @"moveUp"
#define kTabSelected  @"tabSelected"
#define kRequestInfo  @"requestInfo"
#define kNextSelected  @"nextSelected"
#define kEventsUpdated  @"eventsUpadted"
#define kRowSelected  @"rowSelected"

#define kFindRequestJobs_Screen @"findRequestJobs_screen"
#define kJobAssignment_Screen @"jobAssignment_screen"

#define kEmail @"Email"
#define kPassword @"Password"

#endif
