//
//  LKRecommendUserCell.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/7.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKRecommendUserCell.h"
#import "LKRecommendUserModel.h"

#import <UIImageView+WebCache.h>

@interface LKRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@end

@implementation LKRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(LKRecommendUserModel *)user
{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    NSString *fansCount = nil;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    } else {
        fansCount = [NSString stringWithFormat:@"%.1f万人关注",user.fans_count / 10000.0 ];
    }
    self.fansCountLabel.text = fansCount;
    
    [self.headerImageView setHeader:user.header];
}
@end
