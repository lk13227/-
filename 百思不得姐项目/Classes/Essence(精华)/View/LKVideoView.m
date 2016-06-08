//
//  LKVideoView.m
//  百思不得姐项目
//
//  Created by Kai Liu on 16/6/7.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKVideoView.h"
#import "LKTopicModel.h"
#import "LKShowPictureViewController.h"

#import <UIImageView+WebCache.h>

@interface LKVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playtimeLabel;

@end

@implementation LKVideoView


+ (instancetype)videoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    //关闭自动伸缩
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture
{
    LKShowPictureViewController *showPicture = [[LKShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTopic:(LKTopicModel *)topic
{
    _topic = topic;
    
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    //播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    //播放时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.playtimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
}

@end
