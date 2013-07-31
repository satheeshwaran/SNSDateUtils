//
//  SNSDateUtils.h
// 
//
//  Created by Mac Air on 1/27/13.
//  Copyright (c) 2013 Satheeshwaran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNSDateUtils : NSObject

+ (BOOL)timeIs24HourFormat ;

+ (NSString *)dayNameForWeekDay:(int)weekday;

+ (NSDate *)date:(NSDate*)date ByAddingDays:(int)days;

+ (NSDate *)nextDayFromDate:(NSDate *)date;

+ (NSDate *)previousDayFromDate:(NSDate *)date;

+ (NSDateComponents *)componentsForDate:(NSDate *)date;

+ (NSDate* )date:(NSDate *)date ByAddingHours:(int)hours;

+ (BOOL)dateIsToday:(NSDate *)date;

+ (BOOL)date:(NSDate *)date IsEqualTo:(NSDate *)anotherdate;

+ (NSDate *)dateWithOutTime:(NSDate *)datDate;

+ (NSString *)timeFromNSDate:(NSDate *)date;

+ (BOOL)isDate:(NSDate *)date1 smallerThanAnotherDate:(NSDate *)date2;

+ (NSString *)monthNameForMonthInNumber:(int)monthNumber withFullMonthName:(BOOL)fullMonth;

+ (NSString *)convertDateToUTC;

+ (NSDate *)dateFromUTCTimeStamp:(NSString *)dateString;

+ (NSString *)convertDateToUTC:(NSDate *)date;

+ (NSInteger)getDiffernceInHoursForDate:(NSDate *)date1 andAnotherDate:(NSDate *)date2;

+ (NSInteger)getDiffernceInMinutesForDate:(NSDate *)date1 andAnotherDate:(NSDate *)date2;

+ (NSDate *)firstDayOfMonthContainingDate:(NSDate *)date;

+ (NSDate *)firstDayOfNextMonthContainingDate:(NSDate *)date;

+ (NSComparisonResult)compareByMonth:(NSDate *)date toDate:(NSDate *)otherDate;

+ (NSInteger)placeInWeekForDate:(NSDate *)date;

+ (BOOL)date:(NSDate *)date1 isSameDayAsDate:(NSDate *)date2;

+ (NSInteger)numberOfWeeksInMonthContainingDate:(NSDate *)date;

+ (NSDate *)nextDay:(NSDate *)date;

+ (NSDate *)previousDay:(NSDate *)date;

+ (NSInteger)numberOfDaysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;



@end
