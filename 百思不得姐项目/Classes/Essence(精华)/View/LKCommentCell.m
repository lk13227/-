//
//  LKCommentCell.m
//  百思不得姐项目
//
//  Created by Kai Liu on 16/6/23.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKCommentCell.h"

#import "LKComment.h"
#import "LKUser.h"

#import <UIImageView+WebCache.h>

@interface LKCommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation LKCommentCell

- (void)setComment:(LKComment *)comment
{
    _comment = comment;
    
    [self.profileImage sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sexImage.image = [comment.user.sex isEqualToString:LKUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = LKTopicCellMargin;
    frame.size.width -= 2 * LKTopicCellMargin;
    
    [super setFrame:frame];
}

@end
