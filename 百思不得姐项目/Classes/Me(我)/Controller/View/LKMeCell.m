//
//  LKMeCell.m
//  百思不得姐项目
//
//  Created by Kai Liu on 16/7/7.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKMeCell.h"

@implementation LKMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右箭头
        
        //给cell加背景图
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        //调整cell的textLabel
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //没有图片返回
    if (self.imageView.image == nil) return;
    
    //调整cell的imageView的位置
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
    
    //调整textLabel与imageView的间距
    self.textLabel.x = CGRectGetMaxY(self.imageView.frame) + LKTopicCellMargin;
}



//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y -= (35 - LKTopicCellMargin);
//    [super setFrame:frame];
//}

@end
