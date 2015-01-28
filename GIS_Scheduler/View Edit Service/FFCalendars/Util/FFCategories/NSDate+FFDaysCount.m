//
//  NSDate+FFDaysCount.m
//  FFCalendar
//
//  Created by Felipe Rocha on 14/02/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "NSDate+FFDaysCount.h"
#import "FFImportantFilesForCalendar.h"

@implementation NSDate (FFDaysCount)

-(NSDate*)lastDayOfMonth {
    
    NSInteger dayCount = [self numberOfDaysInMonthCount];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSDateComponents *comp = [calendar components:
                              NSYearCalendarUnit |
                              NSMonthCalendarUnit |
                              NSDayCalendarUnit fromDate:self];
    
    [comp setDay:dayCount];
    
    return [calendar dateFromComponents:comp];
}

-(NSInteger)numberOfDaysInMonthCount {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
//    [calendar setTimeZone:[NSTimeZone timeZoneWithName:TIMEZONE]];
    
    NSRange dayRange = [calendar rangeOfUnit:NSDayCalendarUnit
                                      inUnit:NSMonthCalendarUnit
                                     forDate:self];
    
    return dayRange.length;
}

- (NSInteger)numberOfWeekInMonthCount {
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSRange weekRange = [calender rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    return weekRange.length;
}


- (NSDateComponents *)componentsOfDate{
    
    return [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday | NSHourCalendarUnit |
            NSMinuteCalendarUnit fromDate:self];
}

#pragma mark - Methods Statics

+ (NSDateComponents *)componentsOfCurrentDate {
    
    return [NSDate componentsOfDate:[NSDate date]];
}

+ (NSDateComponents *)componentsOfDate:(NSDate *)date {
    
    return [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth| NSHourCalendarUnit |
            NSMinuteCalendarUnit fromDate:date];
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [NSDate componentsWithYear:year month:month day:day];
    
    return [calendar dateFromComponents:components];
}

+ (NSDate *)dateWithHour:(NSInteger)hour min:(NSInteger)min {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [NSDate componentsWithHour:hour min:min];
    
    return [calendar dateFromComponents:components];
}

+ (NSString *)stringTimeOfDate:(NSDate *)date {
    
    NSDateFormatter *dateFormater = [NSDateFormatter new];
    [dateFormater setDateFormat:@"HH:mm"];
    
    return [dateFormater stringFromDate:date];
}

+ (NSString *)stringDayOfDate:(NSDate *)date {
    
    NSDateComponents *comp = [NSDate componentsOfDate:date];
    
    //    return [NSString stringWithFormat:@"%@, %i/%i/%i", [dictWeekNumberName objectForKey:[NSNumber numberWithInt:comp.weekday]], comp.day, comp.month, comp.year];
    return [NSString stringWithFormat:@"%@, %@ %i, %i", [dictWeekNumberName objectForKey:[NSNumber numberWithInt:comp.weekday]], [arrayMonthNameAbrev objectAtIndex:comp.month-1], comp.day, comp.year];
}

+(NSDate *)dateWithString:(NSString *)string{
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *FromDate = [myDateFormatter dateFromString:string];
    return FromDate;
}

+ (NSDateComponents *)componentsWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    
    return components;
}

+ (NSDateComponents *)componentsWithHour:(NSInteger)hour min:(NSInteger)min {
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:hour];
    [components setMinute:min];
    
    return components;
}

+(NSDate *)getWeekFirstDate:(NSDate *)date{
    
    NSDate *currentDate  = date;
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]  initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorianCalendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    
    NSDateComponents *components = [gregorianCalendar components:(NSYearCalendarUnit| NSMonthCalendarUnit
                                                                  | NSDayCalendarUnit| NSWeekdayCalendarUnit|NSWeekCalendarUnit)  fromDate:currentDate];
    
    NSDateComponents *dt=[[NSDateComponents alloc]init];
    
    [dt setWeek:[components week]];
    [dt setWeekday:1];
    [dt setMonth:[components month]];
    [dt setYear:[components year]];
    
    NSDate *firstDay=[gregorianCalendar dateFromComponents:dt];
    
    return firstDay;
}

+(NSDate *)getWeeklastDate:(NSDate *)date{
    
    NSDate *currentDate  = date;
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]  initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorianCalendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    
    NSDateComponents *components = [gregorianCalendar components:(NSYearCalendarUnit| NSMonthCalendarUnit
                                                                  | NSDayCalendarUnit| NSWeekdayCalendarUnit|NSWeekCalendarUnit)  fromDate:currentDate];
    
    NSDateComponents *dt=[[NSDateComponents alloc]init];
    
    [dt setWeek:[components week]];
    [dt setWeekday:7];
    [dt setMonth:[components month]];
    [dt setYear:[components year]];

    NSDate *lastDay=[gregorianCalendar dateFromComponents:dt];
    
    return lastDay;
}

+(NSDate *)getMonthFirstDate:(NSDate *)date{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                   fromDate:date];
    components.day = 1;
    NSDate *firstDayOfMonthDate = [[NSCalendar currentCalendar] dateFromComponents: components];
    NSLog(@"First day of month: %@", [firstDayOfMonthDate descriptionWithLocale:[NSLocale currentLocale]]);
    
    return firstDayOfMonthDate;
}
+(NSDate *)getMonthlastDate:(NSDate *)date{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                   fromDate:date];
    [components setMonth:[components month]+1];
    [components setDay:0];
    NSDate *lastDayOfMonthDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    NSLog(@"last day of month: %@", [lastDayOfMonthDate descriptionWithLocale:[NSLocale currentLocale]]);
    
    return lastDayOfMonthDate;
}

+ (BOOL)isTheSameDateTheCompA:(NSDateComponents *)compA compB:(NSDateComponents *)compB {
    
    return ([compA day]==[compB day] && [compA month]==[compB month ]&& [compA year]==[compB year]);
}

+ (BOOL)isTheSameTimeTheCompA:(NSDateComponents *)compA compB:(NSDateComponents *)compB {
    
    return ([compA hour]==[compB hour] && [compA minute]==[compB minute]);
}

@end
