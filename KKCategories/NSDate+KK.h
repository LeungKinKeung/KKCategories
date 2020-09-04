//
//  NSDate+KK.h
//  KKCategories
//
//  Created by LeungKinKeung on 2020/9/4.
//  Copyright © 2020 LeungKinKeung. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, KKWeekday) {
    KKWeekdaySunday = 1,
    KKWeekdayMonday,
    KKWeekdayTuesday,
    KKWeekdayWednesday,
    KKWeekdayThursday,
    KKWeekdayFriday,
    KKWeekdaySaturday,
};

@interface NSDate (KK)

/// 字符串转时间
/// @param dateString 时间字符串
/// @param format 格式
OBJC_EXTERN NSDate *KKStringToDate(NSString *dateString,NSString *format);

/// 时间转字符串
/// @param date 日期时间
/// @param format 格式
OBJC_EXTERN NSString *KKDateToString(NSDate *date,NSString *format);

/// GMT时间转为本地时间
- (NSDate *)GMTToLocal;

/// 本地时间转为GMT时间
- (NSDate *)localToGMT;

/// 创建时间格式化器，并缓存起来下次使用
/// @param format 格式
+ (NSDateFormatter *)dateFormatter:(NSString *)format;

/// 移除格式化器缓存
/// @param format 格式
+ (void)removeDateFormatter:(NSString *)format;

/// 创建时间对象
+ (NSDate *)dateWithYear:(NSInteger)yearValue
                   month:(NSInteger)monthValue
                     day:(NSInteger)dayValue
                    Hour:(NSInteger)hourValue
                  minute:(NSInteger)minuteValue
                  second:(NSInteger)secondValue;

/// 创建时间对象（2000/1/1 hour:minute:second）
+ (NSDate *)dateWithHour:(NSInteger)hourValue
                  minute:(NSInteger)minuteValue
                  second:(NSInteger)secondValue;

/// 附加年月日
- (NSDate *)dateByAddingYear:(NSInteger)yearValue
                       month:(NSInteger)monthValue
                         day:(NSInteger)dayValue;
/// 附加时分秒
- (NSDate *)dateByAddingHour:(NSInteger)hourValue
                      minute:(NSInteger)minuteValue
                      second:(NSInteger)secondValue;
/// 重置时分秒
- (NSDate *)dateByResetHour:(NSInteger)hourValue
                     minute:(NSInteger)minuteValue
                     second:(NSInteger)secondValue;

/// 获取当前时间并且秒数置0
- (NSDate *)dateByRemoveSecond;

/// 此日期比beforeDate新，例子: if (self:2019 > beforeDate:2018) return YES
- (BOOL)largerThanDate:(NSDate *)beforeDate;

/// 此日期比afterDate旧，例子: if (self:2018 < afterDate:2019) return YES
- (BOOL)lessThanDate:(NSDate *)afterDate;

/// 此日期和另一个日期间隔多少天
- (NSInteger)dayInterval:(NSDate *)date;

/// 获取年月日...
/// @param unit 单元，NSCalendarUnitWeekday:周日为1，周一为2，周六为7...
- (NSInteger)unit:(NSCalendarUnit)unit;

/// 00:01.00
+ (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval;

/// 00:01
+ (NSString *)stringFromDuration:(NSInteger)duration;

@end
