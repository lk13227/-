//
//  LKTabBarController.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/4.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKTabBarController.h"

#import "LKEssenceViewController.h"
#import "LKNewViewController.h"
#import "LKFriendTrendsViewController.h"
#import "LKMeViewController.h"

#import "LKTabBar.h"
#import "LKNavigationController.h"

@interface LKTabBarController ()

@end

@implementation LKTabBarController

+ (void)initialize
{
    //通过appearance设置所有item的属性
    //后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self setupChildVc:[[LKEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[LKNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[LKFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[LKMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //更换tabbar
    [self setValue:[[LKTabBar alloc] init] forKeyPath:@"tabBar"];
    
}


/**
 *  初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    //vc.view.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0];这里不能设置颜色，会导致控制器提前创建
    //包装一个导航控制器，添加导航控制器为tabbarController的子控制器
    LKNavigationController *nav = [[LKNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
