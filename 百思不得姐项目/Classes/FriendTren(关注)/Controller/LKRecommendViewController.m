//
//  LKRecommendViewController.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/6.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKRecommendViewController.h"
#import "LKRecommendCategoryCell.h"
#import "LKRecommendCategory.h"
#import "LKRecommendUserCell.h"
#import "LKRecommendUserModel.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>

#define LKSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface LKRecommendViewController () <UITableViewDataSource,UITableViewDelegate>
/** 左边的类别数据 */
@property (nonatomic, strong)NSArray *categories;
/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 请求参数 */
@property (nonatomic, strong)NSMutableDictionary *params;

/** AFN请求管理者 */
@property (nonatomic, strong)AFHTTPSessionManager *manager;
@end

@implementation LKRecommendViewController

static NSString * const LKCategoryID = @"category";
static NSString * const LKUserID = @"user";

- (NSMutableDictionary *)params
{
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //控件的初始化
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
    //加载左侧的类别数据
    [self loadCategorys];
}

/**
 *  加载左侧的类别数据
 */
- (void)loadCategorys
{
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //服务器返回的数据
        self.categories = [LKRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        //让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

/**
 *  控件初始化
 */
- (void)setupTableView
{
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LKRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:LKCategoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LKRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:LKUserID];
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70.0;
    
    //设置标题
    self.title = @"推荐关注";
    
    //设置背景颜色
    self.view.backgroundColor = LKGlobalBg;
}

/**
 *  添加刷新控件
 */
- (void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

#pragma mark - 加载用户数据
- (void)loadNewUsers
{
    LKRecommendCategory *c = LKSelectedCategory;
    
    //设置当前页码为1
    c.currentPage = 1;
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(c.ID);
    params[@"page"] = @(c.currentPage);
    self.params = params;
    
    //发送请求给服务器，加载右侧数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //字典数组 -> 模型数据
        NSArray *users = [LKRecommendUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //先清除所有的旧数据
        [c.users removeAllObjects];
        
        //添加到当前类别对应的而用户数组中
        [c.users addObjectsFromArray:users];
        
        //保存总数
        c.total = [responseObject[@"total"] integerValue];
        
        if (self.params != params) return ;//防止重复请求
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return ;//防止重复请求
        //提示失败
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreUsers
{
    LKRecommendCategory *category = LKSelectedCategory;
    
    //发送请求给服务器，加载右侧数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.ID);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //字典数组 -> 模型数据
        NSArray *users = [LKRecommendUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的而用户数组中
        [category.users addObjectsFromArray:users];
        
        if (self.params != params) return ;//防止重复请求
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return ;//防止重复请求
        //提示失败
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        //结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
}

/**
 *  检测tableView有没有第二页的数据
 */
- (void)checkFooterState
{
    LKRecommendCategory *c = LKSelectedCategory;
    
    //每次刷新右边数据时，控制footer显示和隐藏
    self.userTableView.mj_footer.hidden = (c.users.count == 0);
    
    if (c.users.count == c.total) {//全部加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        //让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    } else {
        //左边被选中的类别模型
        LKRecommendCategory *c = LKSelectedCategory;
        
        [self checkFooterState];
        
        return c.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.categoryTableView) {
        LKRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:LKCategoryID];
        
        cell.category = self.categories[indexPath.row];
        
        return cell;
    } else {
        LKRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:LKUserID];
        
        //左边被选中的类别模型
        LKRecommendCategory *c = LKSelectedCategory;
        cell.user = c.users[indexPath.row];
        
        return cell;
    }
    
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    LKRecommendCategory *c = self.categories[indexPath.row];
    
    if (c.users.count) {
        //显示曾经的数据
        [self.userTableView reloadData];
        
    } else {
        [self.userTableView reloadData];//让之前的数据消失
        
        //进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
    
}

#pragma mark - 控制器的销毁
- (void)dealloc
{
    //停止所有的操作
    [self.manager.operationQueue cancelAllOperations];
}

@end
