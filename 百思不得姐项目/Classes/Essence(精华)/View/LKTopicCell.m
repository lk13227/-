//
//  LKTopicCell.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/15.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKTopicCell.h"
#import "LKTopicModel.h"
#import "LKTopicPictureView.h"
#import "LKTopicVoiceView.h"
#import "LKVideoView.h"
#import "LKComment.h"
#import "LKUser.h"

#import <UIImageView+WebCache.h>

@interface LKTopicCell()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sina_VView;
/** 帖子的文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** 图片帖子中间的内容 */
@property (nonatomic, weak) LKTopicPictureView *pictureView;
/** 声音帖子中间的内容 */
@property (nonatomic, weak) LKTopicVoiceView *voiceView;
/** 视频帖子中间的内容 */
@property (nonatomic, weak) LKVideoView *videoView;
/** 最热评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/** 最热评论整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end

@implementation LKTopicCell

- (LKTopicPictureView *)pictureView
{
    if (!_pictureView) {
        LKTopicPictureView *pictureView = [LKTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (LKTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        LKTopicVoiceView *voice = [LKTopicVoiceView voiceView];
        [self.contentView addSubview:voice];
        _voiceView = voice;
    }
    return _voiceView;
}

- (LKVideoView *)videoView
{
    if (!_videoView) {
        LKVideoView *video = [LKVideoView videoView];
        [self.contentView addSubview:video];
        _videoView = video;
    }
    return _videoView;
}

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(LKTopicModel *)topic
{
    _topic = topic;
    
    //新浪加V
    self.sina_VView.hidden = !topic.isSina_v;
    
    //设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置名字
    self.nameLabel.text = topic.name;
    //设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    
    //设置按钮的文字
    [self setupButtonTitle:self.dingButton countStr:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton countStr:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton countStr:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton countStr:topic.comment placeholder:@"评论"];
    
    //设置帖子的文字内容
    self.text_label.text = topic.text;
    
    //根据帖子类型添加对应的内容到cell的中间
    if (topic.type == LKTopicTypePicture) {//图片帖子
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureViewFrame;
        
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    } else if (topic.type == LKTopicTypeVoice) {//声音帖子
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceViewFrame;
        
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topic.type == LKTopicTypeVideo) {//视频帖子
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoViewFrame;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else {//段子帖子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
    //处理最热评论
    LKComment *cmt = [topic.top_cmt firstObject];
    if (cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", cmt.user.username, cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
}


/**
 *  设置按钮文字处理
 */
- (void)setupButtonTitle:(UIButton *)button countStr:(NSString *)countStr placeholder:(NSString *)placeholder
{
    if (countStr.integerValue > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",countStr.integerValue / 10000.0];
    } else if (countStr.integerValue > 0) {
        placeholder = [NSString stringWithFormat:@"%.zd",countStr.integerValue];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = LKTopicCellMargin;
    frame.size.width -= LKTopicCellMargin * 2;
//    frame.size.height -= LKTopicCellMargin;
    frame.size.height = self.topic.cellHeight - LKTopicCellMargin;
    frame.origin.y += LKTopicCellMargin;
    
    [super setFrame:frame];
}

- (IBAction)more {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏", @"举报", nil];
    
    [sheet showInView:self.window];
}
@end
