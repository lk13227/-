//
//  LKFriendTrendsViewController.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/4.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKFriendTrendsViewController.h"
#import "LKRecommendViewController.h"
#import "LKLoginRegisterViewController.h"

@interface LKFriendTrendsViewController ()

@end

@implementation LKFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    //导航栏左按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon"target:self action:@selector(friendsClick)];
    
    //设置背景颜色
    self.view.backgroundColor = LKGlobalBg;
}

- (void)friendsClick
{
    LKRecommendViewController *vc = [[LKRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  登陆注册
 */
- (IBAction)loginRegister {
    LKLoginRegisterViewController *loginVC = [[LKLoginRegisterViewController alloc] init];
    
    [self presentViewController:loginVC animated:YES completion:nil];
}
@end
