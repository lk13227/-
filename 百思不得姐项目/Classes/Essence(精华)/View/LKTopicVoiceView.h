//
//  LKTopicVoiceView.h
//  百思不得姐项目
//
//  Created by Kai Liu on 16/6/7.
//  Copyright © 2016年 LK. All rights reserved.
//声音帖子中间内容

#import <UIKit/UIKit.h>

@class LKTopicModel;
@interface LKTopicVoiceView : UIView

/** 帖子数据 */
@property (nonatomic,strong) LKTopicModel *topic;

+ (instancetype)voiceView;
@end
