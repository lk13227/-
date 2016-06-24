//
//  LKComment.m
//  百思不得姐项目
//
//  Created by Kai Liu on 16/6/8.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKComment.h"

#import <MJExtension.h>

@implementation LKComment
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}
@end
