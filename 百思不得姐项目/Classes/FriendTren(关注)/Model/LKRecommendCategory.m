//
//  LKRecommendCategory.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/6.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKRecommendCategory.h"
//#import <MJExtension.h>

@implementation LKRecommendCategory
-(NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}
@end
