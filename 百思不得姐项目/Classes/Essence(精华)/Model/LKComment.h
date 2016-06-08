//
//  LKComment.h
//  百思不得姐项目
//
//  Created by Kai Liu on 16/6/8.
//  Copyright © 2016年 LK. All rights reserved.
//评论模型

#import <Foundation/Foundation.h>

@class LKUser;
@interface LKComment : NSObject

/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) LKUser *user;

@end
