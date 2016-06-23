//
//  LKCommentHeaderView.h
//  百思不得姐项目
//
//  Created by Kai Liu on 16/6/20.
//  Copyright © 2016年 LK. All rights reserved.
//评论头视图

#import <UIKit/UIKit.h>

@interface LKCommentHeaderView : UITableViewHeaderFooterView
/** 文字数据 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
