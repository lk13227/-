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

@interface LKCommentViewController ()<UITableViewDelegate>

/** 底部工具条距底部的高度约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LKCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupHeader];
}

//上面的view
- (void)setupHeader
{
    LKTopicCell *cell = [LKTopicCell cell];
    cell.topic  = self.topic;
    cell.height = self.topic.cellHeight;
    self.tableView.tableHeaderView = cell;
}

//基本设置
- (void)setupBasic
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    //监听键盘的弹出和收回方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
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

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{//拖动表格隐藏键盘
    [self.view endEditing:YES];
}


//移除所有通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
