//
//  SNSDateUtils.m
//  iPitch V2
//
//  Created by Mac Air on 1/27/13.
//  Copyright (c) Satheeshwaran. All rights reserved.
//

#import "SNSDateUtils.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation SNSDateUtils

+ (BOOL)timeIs24HourFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
    NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
    BOOL is24Hour = amRange.location == NSNotFound && pmRange.location == NSNotFound;
    return is24Hour;
}

+ (NSString *)dayNameForWeekDay:(int)weekday
{
    switch (weekday) {
        case 1:
            return @"Sunday";
            break;
        case 2:
            return @"Monday";
            break;
        case 3:
            return @"Tuesday";
            break;
        case 4:
            return @"Wednesday";
            break;
        case 5:
            return @"Thursday";
            break;
        case 6:
            return @"Friday";
            break;
        case 7:
            return @"Saturday";
            break;
        default:
            break;
    }
    
    return @"";
}


+ (NSString *)monthNameForMonthInNumber:(int)monthNumber withFullMonthName:(BOOL)fullMonth
{
    switch (monthNumber) {
        case 1:
            if (fullMonth)
                return @"January";
            else
                return @"Jan";
            break;
        case 2:
            if (fullMonth)
                return @"February";
            else
                return @"Feb";
            break;
        case 3:
            if (fullMonth)
                return @"March";
            else
                return @"Mar";
            break;
        case 4:
            if (fullMonth)
                return @"April";
            else
                return @"Apr";
            break;
        case 5:
            if (fullMonth)
                return @"May";
            else
                return @"May";
            break;
        case 6:
            if (fullMonth)
                return @"June";
            else
                return @"Jun";
            break;
        case 7:
            if (fullMonth)
                return @"July";
            else
                return @"Jul";
            break;
        case 8:
            if (fullMonth)
                return @"August";
            else
                return @"Aug";
            break;
        case 9:
            if (fullMonth)
                return @"September";
            else
                return @"Sep";
            break;
        case 10:
            if (fullMonth)
                return @"October";
            else
                return @"Oct";
            break;
        case 11:
            if (fullMonth)
                return @"November";
            else
                return @"Nov";
            break;
        case 12:
            if (fullMonth)
                return @"December";
            else
                return @"Dec";
            break;
            
        default:
            return @"";
            break;
    }
    
    return @"";
}

+ (NSDate* )date:(NSDate*)date ByAddingDays:(int)days
{
    return [date dateByAddingTimeInterval:60*60*24*days];
}

+ (NSDate* )date:(NSDate*)date ByAddingHours:(int)hours
{
    return [date dateByAddingTimeInterval:60*60*hours];
}


+ (NSDate *)nextDayFromDate:(NSDate *)date {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
	[components setDay:[components day] + 1];
	[components setHour:0];
	[components setMinute:0];
	[components setSecond:0];
	return [CURRENT_CALENDAR dateFromComponents:components];
}

+ (NSDate *)previousDayFromDate:(NSDate *)date {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
	[components setDay:[components day] - 1];
	[components setHour:0];
	[components setMinute:0];
	[components setSecond:0];
	return [CURRENT_CALENDAR dateFromComponents:components];
}

+ (NSDateComponents *)componentsForDate:(NSDate *)date
{
    if (date!=nil)
    {
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDateComponents *dayComponents =
        [gregorian components:DATE_COMPONENTS fromDate:date];
        
        return dayComponents;
    }
    
    return nil;
}


+(BOOL)date:(NSDate *)date IsEqualTo:(NSDate*)anotherdate
{
    
    if ([[self dateWithOutTime:date] isEqualToDate:[self dateWithOutTime:anotherdate]]) {
        return YES;
    }
    
    return NO;
    
}

+(NSDate *)dateWithOutTime:(NSDate *)datDate
{
    if( datDate == nil ) {
        datDate = [NSDate date];
    }
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:datDate];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
    
}
+(NSString *)timeFromNSDate:(NSDate *)date
{
    int hour=[self componentsForDate:date].hour;
    int minute=[self componentsForDate:date].minute;
    
    
    NSString *returnDateString=@"";
    if (hour <= 9 ) {
        returnDateString=[NSString stringWithFormat:@"0%d", hour];
    }
    
    else {
        returnDateString=[NSString stringWithFormat:@"%d", hour];
    }
    
    if (minute <= 9 ) {
        returnDateString= [returnDateString stringByAppendingFormat:@":%@", [NSString stringWithFormat:@"0%d", minute]];
    }
    
    else {
        returnDateString= [returnDateString stringByAppendingFormat:@":%@", [NSString stringWithFormat:@"%d", minute]];
    }
    
    
    return returnDateString;
}


+ (BOOL)isDate:(NSDate *)date1 smallerThanAnotherDate:(NSDate *)date2
{
    NSDate* enddate = date1;
    NSDate* currentdate = date2;
    NSTimeInterval distanceBetweenDates = [enddate timeIntervalSinceDate:currentdate];
    double secondsInMinute = 60;
    NSInteger secondsBetweenDates = distanceBetweenDates / secondsInMinute;
    
    if (secondsBetweenDates == 0)
        return YES;
    else if (secondsBetweenDates < 0)
        return YES;
    else
        return NO;
}

+ (NSString *)convertDateToUTC
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [dateFormatter stringFromDate:[NSDate date]];
    if (timeStamp)
        return timeStamp;
    
    else
        return @"";}

+ (NSString *)convertDateToUTC:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [dateFormatter stringFromDate:date];
    if (timeStamp)
        return timeStamp;
    
    else
        return @"";
}

+ (NSInteger)getDiffernceInHoursForDate:(NSDate *)date1 andAnotherDate:(NSDate *)date2
{
    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    double secondsInAnHour = 3600;
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    return hoursBetweenDates;
}

+ (NSInteger)getDiffernceInMinutesForDate:(NSDate *)date1 andAnotherDate:(NSDate *)date2
{
    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    double minutesInAnHour = 60;
    NSInteger hoursBetweenDates = distanceBetweenDates / minutesInAnHour;
    return hoursBetweenDates;
}

+ (NSDate *)dateFromUTCTimeStamp:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSz"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate* date = [dateFormatter dateFromString:dateString];
    NSLog(@"Formatted Timestamp: %@ - Original Timestamp: %@", date,dateString);
    return date;
}


+ (NSDate *)firstDayOfMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [CURRENT_CALENDAR components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    comps.day = 1;
    return [CURRENT_CALENDAR dateFromComponents:comps];
}

+ (NSDate *)firstDayOfNextMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [CURRENT_CALENDAR components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    comps.day = 1;
    comps.month = comps.month + 1;
    return [CURRENT_CALENDAR dateFromComponents:comps];
}

+ (NSComparisonResult)compareByMonth:(NSDate *)date toDate:(NSDate *)otherDate {
    NSDateComponents *day = [CURRENT_CALENDAR components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:date];
    NSDateComponents *day2 = [CURRENT_CALENDAR components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:otherDate];
    
    if (day.year < day2.year) {
        return NSOrderedAscending;
    } else if (day.year > day2.year) {
        return NSOrderedDescending;
    } else if (day.month < day2.month) {
        return NSOrderedAscending;
    } else if (day.month > day2.month) {
        return NSOrderedDescending;
    } else {
        return NSOrderedSame;
    }
}

+ (NSInteger)placeInWeekForDate:(NSDate *)date {
    NSDateComponents *compsFirstDayInMonth = [CURRENT_CALENDAR components:NSWeekdayCalendarUnit fromDate:date];
    return (compsFirstDayInMonth.weekday - 1 - [CURRENT_CALENDAR firstWeekday] + 8) % 7;
}

+ (BOOL)dateIsToday:(NSDate *)date {
    return [self date:[NSDate date] isSameDayAsDate:date];
}

+ (BOOL)date:(NSDate *)date1 isSameDayAsDate:(NSDate *)date2 {
    
    if (date1 == nil || date2 == nil) {
        return NO;
    }
    
    NSDateComponents *day = [CURRENT_CALENDAR components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date1];
    NSDateComponents *day2 = [CURRENT_CALENDAR components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date2];
    return ([day2 day] == [day day] &&
            [day2 month] == [day month] &&
            [day2 year] == [day year] &&
            [day2 era] == [day era]);
}


+ (NSInteger)numberOfWeeksInMonthContainingDate:(NSDate *)date {
    return [CURRENT_CALENDAR rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length;
}

+ (NSDate *)nextDay:(NSDate *)date {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [CURRENT_CALENDAR dateByAddingComponents:comps toDate:date options:0];
}

+ (NSDate *)previousDay:(NSDate *)date {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:-1];
    return [CURRENT_CALENDAR dateByAddingComponents:comps toDate:date options:0];
}

+ (NSInteger)numberOfDaysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
    NSInteger startDay = [CURRENT_CALENDAR ordinalityOfUnit:NSDayCalendarUnit inUnit:NSEraCalendarUnit forDate:startDate];
    NSInteger endDay = [CURRENT_CALENDAR ordinalityOfUnit:NSDayCalendarUnit inUnit:NSEraCalendarUnit forDate:endDate];
    return endDay - startDay;
}

@end
