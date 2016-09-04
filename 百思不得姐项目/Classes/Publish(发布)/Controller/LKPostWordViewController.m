//
//  LKPostWordViewController.m
//  百思不得姐项目
//
//  Created by Kai Liu on 16/7/27.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKPostWordViewController.h"

@interface LKPostWordViewController ()

@end

@implementation LKPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LKGlobalBg;
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;//发表默认不能点击
    //强制更新item的状态
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    
}

@end
