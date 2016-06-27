//
//  LKTopWindow.m
//  百思不得姐项目
//
//  Created by Kai Liu on 16/6/24.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKTopWindow.h"

@implementation LKTopWindow

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, LKScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)show
{
    window_.hidden = NO;
}

/**
 *  监听窗口的点击
 */
+ (void)windowClick
{
    //1.scrollView
    //2.keyWindow
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [self searchScrollViewInView:window];
    
}

+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews) {
        
        //如果真的是ScrollView
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeywindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:CGPointZero animated:YES];
        }
        
        //继续查找子控件
        [self searchScrollViewInView:subview];
    }
}

@end
