//
//  UIImageView+LKExtension.m
//  百思不得姐项目
//
//  Created by Kai Liu on 16/6/28.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "UIImageView+LKExtension.h"

#import <UIImageView+WebCache.h>

@implementation UIImageView (LKExtension)
- (void)setHeader:(NSString *)url
{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
}
@end
