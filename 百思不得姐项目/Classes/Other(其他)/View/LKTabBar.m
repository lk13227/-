//
//  LKTabBar.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/4.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKTabBar.h"
#import "LKPublishViewController.h"
#import "LKNavigationController.h"
#import "LKPostWordViewController.h"

@interface LKTabBar()
/**
 *  发布按钮
 */
@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation LKTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //更换tabbar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        //添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)publishClick
{
//    LKPublishViewController *publish = [[LKPublishViewController alloc] init];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:NO completion:nil];
    
    
    LKPostWordViewController *postWord = [[LKPostWordViewController alloc] init];
    LKNavigationController *nav = [[LKNavigationController alloc] initWithRootViewController:postWord];
    
    // 这里不能使用self来弹出其他控制器, 因为self执行了dismiss操作
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    [root presentViewController:nav animated:YES completion:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //static BOOL added = NO;
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    //设置发布按钮的frame
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    //设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        //if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;//两种判断都可以
        
        //计算按钮的X值
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //增加索引
        index++;
        
//        if (added == NO) {
//            //监听按钮的点击
//            [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
//        }
        
    }
    
//    added = YES;
}

//- (void)buttonClick
//{
//    //发送通知
//    [LKNoteCenter postNotificationName:LKTabBarDidClickNotification object:nil userInfo:nil];
//}

@end
