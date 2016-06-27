//
//  LKLoginRegisterViewController.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/9.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKLoginRegisterViewController.h"

@interface LKLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneField;
/**
 *  登陆框距离控制器view左边的间距
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation LKLoginRegisterViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

/**
 *  注册账号
 */
- (IBAction)showLoginOrRegister:(UIButton *)button
{
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {//显示注册
        self.loginViewLeftMargin.constant = - self.view.width;
        [button setTitle:@"已有账号?" forState:UIControlStateNormal];
    } else {//显示登陆
        self.loginViewLeftMargin.constant = 0;
        [button setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];//在0.25秒的时间里修改布局
    }];
}

/**
 *  退出按钮
 */
- (IBAction)back {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self dismissViewControllerAnimated:YES completion:nil];
}


///**
// *  控制器内设置状态栏颜色
// *
// *  @return 设置为状态栏白色
// */
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

/**
 *  富文本
 */
- (void)textFiledAttributed
{
    //    //文字属性
    //    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    //    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    //
    //    //NSAttributedString:带有属性的文字(富文本)
    //    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
    //
    //    self.phoneField.attributedPlaceholder = placeholder;
    
    //    NSMutableAttributedString *placehoder = [[NSMutableAttributedString alloc] initWithString:@"手机号"];
    //    [placehoder setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} range:NSMakeRange(0, 1)];
    //    self.phoneField.attributedPlaceholder = placehoder;
}
@end
