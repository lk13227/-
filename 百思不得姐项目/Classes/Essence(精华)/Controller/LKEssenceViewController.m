//
//  LKEssenceViewController.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/4.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKEssenceViewController.h"
#import "LKRecommendTagsViewController.h"
#import "LKTopicViewController.h"

@interface LKEssenceViewController ()<UIScrollViewDelegate>
/** 标签栏底部红色的指示器 */
@property (nonatomic, weak)UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak)UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak)UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak)UIScrollView *contentView;
@end

@implementation LKEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //初始化子控制器
    [self setupChildVces];
    
    //设置顶部的标签栏
    [self setupTitleView];
    
    //底部的scrollView
    [self srtupContentView];
    
}

/**
 *  初始化子控制器
 */
- (void)setupChildVces
{
    LKTopicViewController *all = [[LKTopicViewController alloc] init];
    all.title = @"全部";
    all.type = LKTopicTypeAll;
    [self addChildViewController:all];
    
    LKTopicViewController *video = [[LKTopicViewController alloc] init];
    video.title = @"视频";
    video.type = LKTopicTypeVideo;
    [self addChildViewController:video];
    
    LKTopicViewController *voice = [[LKTopicViewController alloc] init];
    voice.title = @"声音";
    voice.type = LKTopicTypeVoice;
    [self addChildViewController:voice];
    
    LKTopicViewController *picture = [[LKTopicViewController alloc] init];
    picture.title = @"图片";
    picture.type = LKTopicTypePicture;
    [self addChildViewController:picture];
    
    LKTopicViewController *word = [[LKTopicViewController alloc] init];
    word.title = @"段子";
    word.type = LKTopicTypeWord;
    [self addChildViewController:word];
}

//设置顶部的标签栏
- (void)setupTitleView
{
    //标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = LKTitlesViewH;
    titlesView.y = LKTitlesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    
    //底部红色指示器
    UIView *indicator = [[UIView alloc] init];
    indicator.backgroundColor = [UIColor redColor];
    indicator.height = 2;
    indicator.tag = -1;
    indicator.y = titlesView.height - indicator.height;
    self.indicatorView = indicator;
    
    //内部子标签
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width =  width;
        button.x = i * width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        //[button layoutIfNeeded];//强制布局一下 让按钮有文字
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        //默认选中第一个
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            [button.titleLabel sizeToFit];//让按钮内部的label根据文字内容计算尺寸
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicator];
}

- (void)titleClick:(UIButton *)button
{
    //修改按钮的状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 *  底部的scrollView
 */
- (void)srtupContentView
{
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.delegate = self;
    contentView.frame = self.view.bounds;
    contentView.pagingEnabled = YES;
//    CGFloat bottom = self.tabBarController.tabBar.height;
//    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
//    contentView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);//设置内边距(显示范围)
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

//设置导航栏
- (void)setupNav
{
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏的左按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    //设置背景颜色
    self.view.backgroundColor = LKGlobalBg;
}

- (void)tagClick
{
    LKRecommendTagsViewController *tagsVC = [[LKRecommendTagsViewController alloc] init];
    
    [self.navigationController pushViewController:tagsVC animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

@end
