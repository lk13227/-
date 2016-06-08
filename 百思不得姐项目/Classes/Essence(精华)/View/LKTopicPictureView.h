//
//  LKTopicPictureView.h
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/18.
//  Copyright © 2016年 LK. All rights reserved.
//图片帖子中间的内容

#import <UIKit/UIKit.h>

@class LKTopicModel;
@interface LKTopicPictureView : UIView

/** 帖子数据 */
@property (nonatomic,strong) LKTopicModel *topic;

+ (instancetype)pictureView;
@end
