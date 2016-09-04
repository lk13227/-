//
//  LKMeFooterView.m
//  百思不得姐项目
//
//  Created by Kai Liu on 16/7/7.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKMeFooterView.h"

#import "LKSquare.h"
#import "LKSquareButton.h"
#import "LKWebViewController.h"

#import <AFNetworking.h>
#import <MJExtension.h>

@implementation LKMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        //发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            
            NSArray *squares = [LKSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            
            [self createSquares:squares];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
        }];
        
    }
    
    return self;
}

//创建方块
- (void)createSquares:(NSArray *)squares
{
    
    //一行最多4列
    int maxCols = 4;
    
    //宽度和高度
    CGFloat buttonW = LKScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < squares.count; i++) {
        
        //创建按钮
        LKSquareButton *button = [LKSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.square = squares[i];
        [self addSubview:button];
        
        //计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        
        //计算footer的高度
        //self.height = CGRectGetMaxY(button.frame);
    }
    
//    //总行数
//    NSUInteger rows = squares.count / maxCols;
//    if (squares.count % maxCols) {//不能整除，+1
//        rows++;
//    }
    //总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    NSUInteger rows = (squares.count + maxCols - 1) / maxCols;
    
    //计算footer的高度
    self.height = rows * buttonH;
    
    //重绘
    [self setNeedsDisplay];
}

- (void)buttonClick:(LKSquareButton *)button
{
    //如果网址前缀不是http 则不去处理
    if (![button.square.url hasPrefix:@"http"]) return;
    
    LKWebViewController *web = [[LKWebViewController alloc] init];
    web.url = button.square.url;
    web.title = button.square.name;
    
    //取出当前的导航控制器
    UITabBarController *tabbarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabbarVC.selectedViewController;
    [nav pushViewController:web animated:YES];
}


////把背景图画在view上
//- (void)drawRect:(CGRect)rect
//{
//    //[[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
//}

@end
