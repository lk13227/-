//
//  LKCommentViewController.h
//  百思不得姐项目
//
//  Created by Kai Liu on 16/6/13.
//  Copyright © 2016年 LK. All rights reserved.
//评论控制器

#import <UIKit/UIKit.h>

@class LKTopicModel;

@interface LKCommentViewController : UIViewController

/** 帖子模型 */
@property (nonatomic, strong) LKTopicModel *topic;

@end
