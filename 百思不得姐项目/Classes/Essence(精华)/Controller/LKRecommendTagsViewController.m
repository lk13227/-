//
//  LKRecommendTagsViewController.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/8.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKRecommendTagsViewController.h"
#import "LKLKRecommendTagsModel.h"
#import "LKRecommendTagCell.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>

@interface LKRecommendTagsViewController ()
/** 标签数据 */
@property (nonatomic, strong)NSArray *tags;
@end

static NSString * const LKTagsID = @"tag";

@implementation LKRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tableview
    [self setupTableView];
    
    //加载数据
    [self loadTags];
    
}

- (void)loadTags
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        self.tags = [LKLKRecommendTagsModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
    }];
}

- (void)setupTableView
{
    self.title = @"推荐标签";
    self.tableView.backgroundColor = LKGlobalBg;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LKRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:LKTagsID];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消系统分割线
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LKRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:LKTagsID];
 
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}



@end
