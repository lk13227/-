//
//  NSDate+LKExtension.h
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/15.
//  Copyright © 2016年 LK. All rights reserved.
//时间处理分类

#import <Foundation/Foundation.h>

@interface NSDate (LKExtension)
/**
 *比较from和self的时间差
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;
/**
 *是否为今年
 */
- (BOOL)isThisYear;
/**
 *是否为今天
 */
- (BOOL)isToDay;
/**
 *是否为昨天
 */
- (BOOL)isYesterday;
@end
