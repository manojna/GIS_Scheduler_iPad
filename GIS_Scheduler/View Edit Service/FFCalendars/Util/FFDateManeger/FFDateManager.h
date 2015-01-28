//
//  FFDateManager.h
//  FFCalendar
//
//  Created by Felipe Rocha on 19/02/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <Foundation/Foundation.h>


#define DATE_MANAGER_DATE_CHANGED @"br.com.FFCalendar.DateManager.DateChanged"
#define DATE_MANAGER_DATE_CHANGED_KEY @"br.com.FFCalendar.DateManager.DateChanged.Key"
#define SHOW_EVENT @"showEvent"
#define SHOW_WEEK_EVENT @"showweekEvent"
#define SHOW_MONTH_EVENT @"showMonthEvent"
#define DATE_CHANGED_UPDATE_EVENT @"upadteEvent"
#define SHOW_MONTH_EVENTS @"showMonthEvents"


@interface FFDateManager : NSObject

@property (nonatomic, strong) NSDate *currentDate;

+ (id)sharedManager;

@end
