//
//  LKNewViewController.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/4.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKNewViewController.h"

@interface LKNewViewController ()

@end

@implementation LKNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏的左按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    //设置背景颜色
    self.view.backgroundColor = LKGlobalBg;
}

- (void)tagClick
{
    LKLog(@"%s",__func__);
}

@end
