//
//  LKVideoView.h
//  百思不得姐项目
//
//  Created by Kai Liu on 16/6/7.
//  Copyright © 2016年 LK. All rights reserved.
//视频帖子中间的内容

#import <UIKit/UIKit.h>

@class LKTopicModel;
@interface LKVideoView : UIView

/** 帖子数据 */
@property (nonatomic,strong) LKTopicModel *topic;

+ (instancetype)videoView;
@end
