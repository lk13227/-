//
//  LKMeViewController.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/4.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKMeViewController.h"

@interface LKMeViewController ()

@end

@implementation LKMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    self.navigationItem.title = @"我的";
    
    //导航栏右按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[
                                                settingItem,
                                                moonItem
                                                ];
    
    //设置背景颜色
    self.view.backgroundColor = LKGlobalBg;
}

- (void)settingClick
{
    LKLog(@"..");
}

- (void)moonClick
{
    LKLog(@"..");
}

@end
