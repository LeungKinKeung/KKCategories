//
//  NSDate+KK.m
//  KKCategories
//
//  Created by LeungKinKeung on 2020/9/4.
//  Copyright © 2020 LeungKinKeung. All rights reserved.
//

#import "NSDate+KK.h"

static NSMutableDictionary *kSHARED_DATE_FORMATTER_MAP = nil;

@implementation NSDate (KK)

- (NSDate *)GMTToLocal
{
    NSTimeZone *timeZone    =
    [NSTimeZone systemTimeZone];
    
    NSInteger interval      =
    [timeZone secondsFromGMTForDate:self];
    
    // 加上时差(如北京时间+8小时)
    NSDate *localeDate  =
    [self dateByAddingTimeInterval:interval];
    
    return localeDate;
}

- (NSDate *)localToGMT
{
    NSTimeZone *timeZone    =
    [NSTimeZone systemTimeZone];
    
    NSInteger interval      =
    [timeZone secondsFromGMTForDate:self];
    
    // 减去时差(如北京时间-8小时)
    NSDate *GMTDate  =
    [self dateByAddingTimeInterval:-interval];
    
    return GMTDate;
}

+ (NSDateFormatter *)dateFormatter:(NSString *)format
{
    if (kSHARED_DATE_FORMATTER_MAP == nil)
    {
        kSHARED_DATE_FORMATTER_MAP = [NSMutableDictionary dictionary];
    }
    NSDateFormatter *df =
    [kSHARED_DATE_FORMATTER_MAP valueForKey:format];
    
    if (df == nil)
    {
        df              = [[NSDateFormatter alloc] init];
        df.dateFormat   = format;
        
        [kSHARED_DATE_FORMATTER_MAP setValue:df
                                      forKey:format];
    }
    return df;
}

+ (void)removeDateFormatter:(NSString *)format
{
    if (kSHARED_DATE_FORMATTER_MAP == nil)
    {
        return;
    }
    [kSHARED_DATE_FORMATTER_MAP removeObjectForKey:format];
}

+ (NSTimeInterval)timestampFromString:(NSString *)string
                               format:(NSString *)format
{
    NSDateFormatter *df = [self dateFormatter:format];
    
    return [[df dateFromString:string] timeIntervalSince1970];
}

+ (NSDate *)dateWithYear:(NSInteger)yearValue
                   month:(NSInteger)monthValue
                     day:(NSInteger)dayValue
                    Hour:(NSInteger)hourValue
                  minute:(NSInteger)minuteValue
                  second:(NSInteger)secondValue
{
    return [[NSCalendar currentCalendar] dateWithEra:1 year:yearValue month:monthValue day:dayValue hour:hourValue minute:minuteValue second:secondValue nanosecond:0];
}

+ (NSDate *)dateWithHour:(NSInteger)hourValue minute:(NSInteger)minuteValue second:(NSInteger)secondValue
{
    return [[NSCalendar currentCalendar] dateWithEra:1 year:2000 month:1 day:1 hour:hourValue minute:minuteValue second:secondValue nanosecond:0];
}

- (NSDate *)dateByAddingYear:(NSInteger)yearValue
                       month:(NSInteger)monthValue
                         day:(NSInteger)dayValue
{
    NSCalendar *calendar =
    [NSCalendar currentCalendar];
    
    NSDateComponents *adcomps =
    [[NSDateComponents alloc] init];
    [adcomps setYear:yearValue];
    [adcomps setMonth:monthValue];
    [adcomps setDay:dayValue];
    
    return [calendar dateByAddingComponents:adcomps
                                     toDate:self
                                    options:0];
}



- (NSDate *)dateByAddingHour:(NSInteger)hourValue
                      minute:(NSInteger)minuteValue
                      second:(NSInteger)secondValue
{
    NSCalendar *calendar =
    [NSCalendar currentCalendar];
    
    NSDateComponents *adcomps =
    [[NSDateComponents alloc] init];
    [adcomps setHour:hourValue];
    [adcomps setMinute:minuteValue];
    [adcomps setSecond:secondValue];
    
    return [calendar dateByAddingComponents:adcomps
                                     toDate:self
                                    options:0];
}

- (NSDate *)dateByResetHour:(NSInteger)hourValue
                     minute:(NSInteger)minuteValue
                     second:(NSInteger)secondValue
{
    NSCalendar *calendar =
    [NSCalendar currentCalendar];
    
    NSCalendarUnit unit =
    NSCalendarUnitEra |
    NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay;
    
    NSDateComponents *comps =
    [calendar components:unit
                fromDate:self];
    
    comps.hour      = hourValue;
    comps.minute    = minuteValue;
    comps.second    = secondValue;
    
    return [calendar dateFromComponents:comps];
}

- (NSDate *)dateByRemoveSecond
{
    NSCalendar *calendar =
    [NSCalendar currentCalendar];
    
    NSCalendarUnit unit =
    NSCalendarUnitEra |
    NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitHour |
    NSCalendarUnitMinute;
    
    NSDateComponents *comps =
    [calendar components:unit
                fromDate:self];
    
    comps.second    = 0;
    
    return [calendar dateFromComponents:comps];
}

#pragma mark if (self > beforeDate) return YES
- (BOOL)largerThanDate:(NSDate *)beforeDate
{
    return ([self compare:beforeDate] == NSOrderedDescending);
}

#pragma mark if (self < afterDate) return YES
- (BOOL)lessThanDate:(NSDate *)afterDate
{
    return ([self compare:afterDate] == NSOrderedAscending);
}

- (NSInteger)dayInterval:(NSDate *)date
{
    NSTimeInterval interval =
    self.timeIntervalSince1970 - date.timeIntervalSince1970;
    
    return (NSInteger)interval / (60 * 60 * 24);
}

- (NSInteger)unit:(NSCalendarUnit)unit
{
    NSCalendar *calendar =
    [NSCalendar currentCalendar];
    
    NSDateComponents *comps =
    [calendar components:unit
                fromDate:self];
    
    switch (unit)
    {
        case NSCalendarUnitEra:
        {
            return comps.era;
        }
        case NSCalendarUnitYear:
        {
            return comps.year;
        }
        case NSCalendarUnitMonth:
        {
            return comps.month;
        }
        case NSCalendarUnitDay:
        {
            return comps.day;
        }
        case NSCalendarUnitHour:
        {
            return comps.hour;
        }
        case NSCalendarUnitMinute:
        {
            return comps.minute;
        }
        case NSCalendarUnitSecond:
        {
            return comps.second;
        }
        case NSCalendarUnitNanosecond:
        {
            return comps.nanosecond;
        }
        case NSCalendarUnitWeekday:
        {
            return comps.weekday;
        }
        case NSCalendarUnitWeekdayOrdinal:
        {
            return comps.weekdayOrdinal;
        }
        case NSCalendarUnitQuarter:
        {
            return comps.quarter;
        }
        case NSCalendarUnitWeekOfMonth:
        {
            return comps.weekOfMonth;
        }
        case NSCalendarUnitWeekOfYear:
        {
            return comps.weekOfYear;
        }
        case NSCalendarUnitYearForWeekOfYear:
        {
            return comps.yearForWeekOfYear;
        }
        default:
        {
            break;
        }
    }
    
    return 0;
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval
{
    if (timeInterval < 0)
    {
        return @"00:00.00";
    }
    long duration       = (long)timeInterval;
    long hour           = duration / (60 * 60);
    long minute         = duration % (60 * 60) / 60;
    long second         = duration % 60;
    long millisecond    = (timeInterval - duration) * 100;
    
    NSString *timeText  = nil;
    
    if (hour > 0)
    {
        timeText =
        [NSString stringWithFormat:@"%02ld:%02ld:%02ld.%02ld",hour,minute,second,millisecond];
    }
    else
    {
        timeText =
        [NSString stringWithFormat:@"%02ld:%02ld.%02ld",minute,second,millisecond];
    }
    return timeText;
}

+ (NSString *)stringFromDuration:(NSInteger)duration
{
    if (duration < 0)
    {
        return @"00:00";
    }
    long hour           = duration / (60 * 60);
    long minute         = duration % (60 * 60) / 60;
    long second         = duration % 60;
    NSString *timeText  = nil;
    
    if (hour > 0)
    {
        timeText =
        [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hour,minute,second];
    }
    else
    {
        timeText =
        [NSString stringWithFormat:@"%02ld:%02ld",minute,second];
    }
    return timeText;
}

NSDate *KKStringToDate(NSString *dateString,NSString *format)
{
    return [[NSDate dateFormatter:format] dateFromString:dateString];
}

NSString *KKDateToString(NSDate *date,NSString *format)
{
    return [[NSDate dateFormatter:format] stringFromDate:date];
}

@end
