//
//  LKUser.h
//  百思不得姐项目
//
//  Created by Kai Liu on 16/6/8.
//  Copyright © 2016年 LK. All rights reserved.
//用户模型

#import <Foundation/Foundation.h>

@interface LKUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

@end
