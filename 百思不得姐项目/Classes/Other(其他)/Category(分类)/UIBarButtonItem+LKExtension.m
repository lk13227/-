//
//  UIBarButtonItem+LKExtension.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/4.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "UIBarButtonItem+LKExtension.h"

@implementation UIBarButtonItem (LKExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}

@end
