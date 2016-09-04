//
//  LKMeViewController.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/4.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKMeViewController.h"

#import "LKMeCell.h"
#import "LKMeFooterView.h"

//#import <AFNetworking.h>

static NSString *LKMeID = @"me";

@interface LKMeViewController ()

@end

@implementation LKMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //设置tableview
    [self setupTableView];
}

//设置tableview
- (void)setupTableView
{
    //设置背景颜色
    self.tableView.backgroundColor = LKGlobalBg;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LKMeCell class] forCellReuseIdentifier:LKMeID];
    
    //调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = LKTopicCellMargin;
    
    //调整tableview的内边距
    self.tableView.contentInset = UIEdgeInsetsMake(LKTopicCellMargin - 35, 0, 0, 0);
    
    //设置footerView
    self.tableView.tableFooterView = [[LKMeFooterView alloc] init];
}

//设置导航栏
- (void)setupNav
{
    //设置导航栏标题
    self.navigationItem.title = @"我的";
    
    //导航栏右按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[
                                                settingItem,
                                                moonItem
                                                ];
}

- (void)settingClick
{
    LKLog(@"..");
}

- (void)moonClick
{
    LKLog(@"..");
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LKMeCell *cell = [tableView dequeueReusableCellWithIdentifier:LKMeID];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

@end
