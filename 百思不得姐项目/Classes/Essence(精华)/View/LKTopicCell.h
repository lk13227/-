//
//  LKTopicCell.h
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/15.
//  Copyright © 2016年 LK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LKTopicModel;
@interface LKTopicCell : UITableViewCell
/** 帖子数据 */
@property (nonatomic,strong) LKTopicModel *topic;
@end
