//
//  LKPushuideView.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/11.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKPushuideView.h"

@implementation LKPushuideView

+ (instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (void)show
{
    //第一次打开app弹出提示
    NSString *key = @"CFBundleShortVersionString";
    //获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        LKPushuideView *guideView = [LKPushuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];//更新
    }
}

- (IBAction)close {
    [self removeFromSuperview];
}
@end
