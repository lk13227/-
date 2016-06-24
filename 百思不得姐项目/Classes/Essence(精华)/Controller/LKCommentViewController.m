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
#import "LKCommentCell.h"

#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>

//static NSInteger const LKHeaderLabelTag = 99;
static NSString * const LKCommentID = @"comment";

@interface LKCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 底部工具条距底部的高度约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;

/** 保存帖子的top_cmt */
@property (nonatomic, strong) LKComment *saved_top_cmt;

/** 保存当前的页码 */
@property (nonatomic, assign) NSInteger page;

/** AFN管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation LKCommentViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

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
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreCimments)];
    self.tableView.mj_footer.hidden = YES;
}

//加载更多数据
- (void)loadMoreCimments
{
    //结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //页码
    NSInteger page = self.page + 1;
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    LKComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //最新评论
        NSArray *newComments = [LKComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];
        
        //页码
        self.page = page;
        
        //刷新数据
        [self.tableView reloadData];
        
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {//评论全部加载完毕
            //[self.tableView.mj_footer endRefreshingWithNoMoreData];
            self.tableView.mj_footer.hidden = YES;
        } else {
            //结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_footer endRefreshing];
    }];
}

//刷新数据
- (void)loadNewComments
{
    //结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //最热评论
        self.hotComments = [LKComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //最新评论
        self.latestComments = [LKComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //页码
        self.page = 1;
        
        //刷新数据
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {//评论全部加载完毕
            //[self.tableView.mj_footer endRefreshingWithNoMoreData];
            self.tableView.mj_footer.hidden = YES;
        }
        
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
    
    //cell的高度设置(cell自动设置高度,iOS8开始适用)
    self.tableView.estimatedRowHeight = 72;//估算高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;//设置高度为自动
    
    //背景色
    self.tableView.backgroundColor = LKGlobalBg;
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LKCommentCell class]) bundle:nil] forCellReuseIdentifier:LKCommentID];
    
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, LKTopicCellMargin, 0);
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
    
    //隐藏尾部控件
    tableView.mj_footer.hidden = (latestCount == 0);
    
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
    LKCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:LKCommentID];
    
    cell.comment = [self commentInIndexPath:indexPath];
    
    return cell;
}

//移除所有通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //恢复帖子的top_cmt
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    //取消所有网络请求
    [self.manager invalidateSessionCancelingTasks:YES];
}
@end
