//
//  LKProgressView.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/19.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKProgressView.h"

@implementation LKProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 2;//设置进度条圆角
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.progressLabel.text = text;
}

@end
