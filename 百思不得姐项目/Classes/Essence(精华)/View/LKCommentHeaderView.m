//
//  LKCommentHeaderView.m
//  百思不得姐项目
//
//  Created by Kai Liu on 16/6/20.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKCommentHeaderView.h"

@interface LKCommentHeaderView()
/** 文字标签 */
@property (nonatomic, strong) UILabel *label;
@end

@implementation LKCommentHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = LKGlobalBg;
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = LKRGBColor(67, 67, 67);
        label.width = 200;
        label.x = LKTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.label.text = title;
}

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    
    LKCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {//缓存池中没有，自己创建
        header = [[LKCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    return header;
}

@end
