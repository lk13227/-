//
//  LKTopicModel.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/14.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKTopicModel.h"
#import "LKUser.h"
#import "LKComment.h"

#import <MJExtension.h>

@implementation LKTopicModel
{
    CGFloat _cellHeight;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"smiddle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             };
}


- (NSString *)create_time
{
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式(y:年 M:月 d:天 H:小时 m:分钟 s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) {//今年
        if (create.isToDay) {//今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) {//时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) {//1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {//时间差距 < 1分钟
                return @"刚刚";
            }
        } else if (create.isYesterday) {//昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else {//其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else {//非今年
        return _create_time;
    }
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        //文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT);
        
        //计算文字的高度
        //    CGFloat textH = [topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        //cell的高度
        //文字部分的高度
        _cellHeight = LKTopicCellTextY + textH + LKTopicCellMargin;
        
        //根据段子的类型来计算cell的高度
        if (self.type == LKTopicTypePicture) {//图片帖子
            //图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            //图片显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= LKTopicCellPictureMaxH) {//图片高度过长
                pictureH = LKTopicCellPictureBreakH;
                self.bigPicture = YES;//大图
            }
            
            //计算图片控件的frame
            CGFloat pictureX = LKTopicCellMargin;
            CGFloat pictureY = LKTopicCellTextY + textH + LKTopicCellMargin;
            _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + LKTopicCellMargin;
        } else if (self.type == LKTopicTypeVoice) {//声音帖子
            CGFloat voiceX = LKTopicCellMargin;
            CGFloat voiceY = LKTopicCellTextY + textH + LKTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceViewFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + LKTopicCellMargin;
        } else if (self.type == LKTopicTypeVideo) {//视频帖子
            CGFloat videoX = LKTopicCellMargin;
            CGFloat videoY = LKTopicCellTextY + textH + LKTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoViewFrame = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + LKTopicCellMargin;
        }
        
        //如果有最热评论
        if (self.top_cmt) {//有最热评论
            NSString *content = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += LKTopicCellTopCmtTitleH + contentH + LKTopicCellMargin;
        }
        
        //底部工具条的高度
        _cellHeight += LKTopicCellButtonBarH + LKTopicCellMargin;
    }
    return _cellHeight;
}
@end
