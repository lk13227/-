//
//  LKRecommendCategoryCell.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/6.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKRecommendCategoryCell.h"
#import "LKRecommendCategory.h"

@interface LKRecommendCategoryCell()
/**
 *  选中时显示的控件
 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;
@end

@implementation LKRecommendCategoryCell

- (void)awakeFromNib {
    self.backgroundColor = LKRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = LKRGBColor(219, 21, 26);
    
//    self.textLabel.textColor = LKRGBColor(78, 78, 78);
//    self.textLabel.highlightedTextColor = LKRGBColor(219, 21, 26);
//    UIView *bg = [[UIView alloc] init];
//    bg.backgroundColor = [UIColor clearColor];
//    self.selectedBackgroundView = bg;
}

- (void)setCategory:(LKRecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
    
}

//cell被选中时的方法
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : LKRGBColor(78, 78, 78);
}



@end
