//
//  LKCommentViewController.m
//  百思不得姐项目
//
//  Created by Kai Liu on 16/6/13.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKCommentViewController.h"
#import "LKTopicCell.h"
#import "LKTopicModel.h"
#import "LKComment.h"
#import "LKCommentHeaderView.h"

#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>

//static NSInteger const LKHeaderLabelTag = 99;

@interface LKCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 底部工具条距底部的高度约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;

/** 保存帖子的top_cmt */
@property (nonatomic, strong) NSArray *saved_top_cmt;
@end

@implementation LKCommentViewController

- (NSMutableArray *)latestComments
{
    if (!_latestComments) {
        _latestComments = [NSMutableArray array];
    }
    return _latestComments;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];
}

//刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
}

//刷新数据
- (void)loadNewComments
{
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //最热评论
        self.hotComments = [LKComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新评论
        self.latestComments = [LKComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
}

//上面的view
- (void)setupHeader
{
    //创建header
    UIView *header = [[UIView alloc] init];
    
    //清空top_cmt
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    //添加cell
    LKTopicCell *cell = [LKTopicCell cell];
    cell.topic  = self.topic;
    cell.size = CGSizeMake(LKScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    
    //header的高度
    header.height = self.topic.cellHeight + LKTopicCellMargin;
    
    self.tableView.tableHeaderView = header;
}

//基本设置
- (void)setupBasic
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    //监听键盘的弹出和收回方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.backgroundColor = LKGlobalBg;
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    //获得键盘显示/隐藏时的位置
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.bottomSapce.constant = LKScreenH - frame.origin.y;
    
    //动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

/**
 *  返回所有section组的所有数组
 */
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return  self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}
/**
 *  返回每一组的所有评论
 */
- (LKComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{//拖动表格隐藏键盘
    [self.view endEditing:YES];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (hotCount) return 2;
    if (latestCount) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    return latestCount;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    static NSString *ID = @"header";
//    //先从缓存池中找header
//    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
//    
//    UILabel *label = nil;
//    if (header == nil) {//缓存池中没有，自己创建
//        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:ID];
//        header.contentView.backgroundColor = LKGlobalBg;
//        
//        label = [[UILabel alloc] init];
//        label.textColor = LKRGBColor(67, 67, 67);
//        label.width = 200;
//        label.x = LKTopicCellMargin;
//        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        label.tag = LKHeaderLabelTag;
//        [header.contentView addSubview:label];
//    } else {//缓存池中取出
//        label = (UILabel *)[header viewWithTag:LKHeaderLabelTag];
//    }
//    
//    //设置label的数据
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        label.text =  hotCount ? @"最热评论" : @"最新评论";
//    } else {
//        label.text = @"最新评论";
//    }
//    
//    
//    return header;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //先从缓存池中找header
    LKCommentHeaderView *header = [LKCommentHeaderView headerViewWithTableView:tableView];

    //设置label的数据
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title =  hotCount ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"最新评论";
    }


    return header;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    
    
    LKComment *cmt = [self commentInIndexPath:indexPath];
    cell.textLabel.text = cmt.content;
    
    return cell;
}

//移除所有通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //恢复帖子的top_cmt
    if (self.saved_top_cmt.count) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
}
@end
