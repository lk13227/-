//
//  LKTopicViewController.h
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/16.
//  Copyright © 2016年 LK. All rights reserved.
// 最基本的帖子控制器

#import <UIKit/UIKit.h>

@interface LKTopicViewController : UITableViewController
/** 帖子类型(交个子类实现) */
@property (nonatomic, assign) LKTopicType type;
@end
