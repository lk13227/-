//
//  LKWebViewController.m
//  百思不得姐项目
//
//  Created by Kai Liu on 16/7/8.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKWebViewController.h"

#import <NJKWebViewProgress.h>

@interface LKWebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
/** 进度代理对象 */
@property (nonatomic, strong) NJKWebViewProgress *progress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation LKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress){
        weakSelf.progressView.progress = progress;
        
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    self.progress.webViewProxyDelegate = self;
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

/**
 *  刷新
 */
- (IBAction)refresh:(UIBarButtonItem *)sender {
    [self.webView reload];
}

/**
 *  左箭头 返回
 */
- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

/**
 *  有箭头 前进
 */
- (IBAction)goForward:(UIBarButtonItem *)sender {
    [self.webView goForward];
}

#pragma mark UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
}

@end
