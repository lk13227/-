//
//  LKPublishView.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/19.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKPublishView.h"
#import "LKVerticalButton.h"

#import <POP.h>

#define LKRootView [UIApplication sharedApplication].keyWindow.rootViewController.view

static CGFloat const LKAnimationDlay = 0.1;
static CGFloat const LKSpringFactor = 10;

@interface LKPublishView ()

@end

@implementation LKPublishView

+ (instancetype)publishView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    //让控制器的view不能被点击
    LKRootView.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    
    //数据
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    
    //中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (LKScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 15;
    CGFloat xMargin = (LKScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<images.count ; i++) {
        LKVerticalButton *button = [[LKVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        //计算x\y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - LKScreenH;
        
        //添加动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = LKSpringFactor;
        anim.springSpeed = LKSpringFactor;
        anim.beginTime = CACurrentMediaTime() + LKAnimationDlay * i;
        [button pop_addAnimation:anim forKey:nil];
    }
    
    //添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganView];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = LKScreenW * 0.5;
    CGFloat centerEndY = LKScreenH * 0.2;
    CGFloat centerBeginY = centerEndY - LKScreenH;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.springBounciness = LKSpringFactor;
    anim.springSpeed = LKSpringFactor;
    anim.beginTime = CACurrentMediaTime() + images.count * LKAnimationDlay;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        //标语动画执行完毕 view恢复点击
        LKRootView.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
}


- (IBAction)cancel {
    [self cancelWithCompletionBlock:nil];
}

/**
 *  先执行退出动画 然后执行
 */
- (void)cancelWithCompletionBlock:(void (^)())completionBlock
{
    //不能被点击
    LKRootView.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    
    int beginIndex = 1;
    
    for (int i = beginIndex; i<self.subviews.count ; i++) {
        UIView *subView = self.subviews[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subView.centerY + LKScreenH;
        //动画执行节奏(一开始很慢，后面很快)
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * LKAnimationDlay;
        [subView pop_addAnimation:anim forKey:nil];
        
        //监听最后一个动画
        if (i == self.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                LKRootView.userInteractionEnabled = YES;
                self.userInteractionEnabled = YES;
                [self removeFromSuperview];
                
                //执行传进来的completionBlock参数
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

- (void)buttonClick:(UIButton *)button
{
    [self cancelWithCompletionBlock:^{
        if (button.tag == 0) {
            
        }
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionBlock:nil];
}

@end
