//
//  NSDate+LKExtension.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/15.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "NSDate+LKExtension.h"

@implementation NSDate (LKExtension)
/**
 *比较from和self的时间差
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:from toDate:self options:0];
    
    //    //取出时间中的元素
    //    NSDateComponents *cmps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now];
    //    LKLog(@"%zd-%zd-%zd", cmps.year, cmps.month, cmps.day);
}
/**
 *是否为今年
 */
- (BOOL)isThisYear
{
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}
/**
 *是否为今天
 */
- (BOOL)isToDay
{
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year
    && nowCmps.month == selfCmps.month
    && nowCmps.day == selfCmps.day;
}
/**
 *是否为昨天
 */
- (BOOL)isYesterday
{
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate= [fmt dateFromString:[fmt stringFromDate:self]];
    
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}




@end
//- (void)testDate:(NSString *)create_time
//{
//    //当前时间
//    NSDate *now = [NSDate date];
//    //发帖时间
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    //设置日期格式(y:年 M:月 d:天 H:小时 m:分钟 s:秒)
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *create = [fmt dateFromString:create_time];
//    NSTimeInterval delta = [now timeIntervalSinceDate:create];
//    LKLog(@"%f",delta);
//}