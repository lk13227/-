//
//  LKCommentCell.h
//  百思不得姐项目
//
//  Created by Kai Liu on 16/6/23.
//  Copyright © 2016年 LK. All rights reserved.
//评论cell

#import <UIKit/UIKit.h>

@class LKComment;

@interface LKCommentCell : UITableViewCell

/** 评论 */
@property (nonatomic, strong) LKComment *comment;

@end
