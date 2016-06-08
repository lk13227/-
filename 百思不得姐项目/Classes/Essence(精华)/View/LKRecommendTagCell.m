//
//  LKRecommendTagCell.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/8.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKRecommendTagCell.h"
#import "LKLKRecommendTagsModel.h"

#import <UIImageView+WebCache.h>

@interface LKRecommendTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation LKRecommendTagCell

- (void)setRecommendTag:(LKLKRecommendTagsModel *)recommendTag
{
    _recommendTag = recommendTag;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommendTag.theme_name;
    
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    } else {
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number / 10000.0 ];
    }
    self.subNumberLabel.text = subNumber;
}

/**
 *  修改cell的位置
 */
- (void)setFrame:(CGRect)frame
{
    
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
