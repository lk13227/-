//
//  LKTopicModel.h
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/14.
//  Copyright © 2016年 LK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LKComment;

@interface LKTopicModel : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像的URL */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, copy) NSString *ding;
/** 踩的数量 */
@property (nonatomic, copy) NSString *cai;
/** 转发数量 */
@property (nonatomic, copy) NSString *repost;
/** 评论数 */
@property (nonatomic, copy) NSString *comment;
/** 是否为新浪加V用户 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 段子的类型 */
@property (nonatomic, assign) LKTopicType type;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 最热评论 */
@property (nonatomic, strong) LKComment *top_cmt;


/******* 额外的辅助属性 *******/

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 图片控件的frame */
@property (nonatomic, assign, readonly) CGRect pictureViewFrame;
/** 图片是否太大 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;

/** 声音控件的frame */
@property (nonatomic, assign, readonly) CGRect voiceViewFrame;

/** 视频控件的frame */
@property (nonatomic, assign, readonly) CGRect videoViewFrame;
@end
