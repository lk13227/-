//
//  LKTextField.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/10.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKTextField.h"

#import <objc/runtime.h>

static NSString * const LKPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation LKTextField

/**
 先通过运行时代码得到私有变量的名字
 */
//+ (void)initialize
//{
//    unsigned int count = 0;
//    
//    //拷贝处所有的成员变量列表，需要释放
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    
//    for (int i = 0; i < count; i++) {
//        //取出成员变量
//        Ivar ivar = *(ivars + i);
//        
//        //打印成员变量的名字
//        LKLog(@"%s", ivar_getName(ivar));
//    }
//    
//    //释放
//    free(ivars);
//}

/**
 *  然后在修改私有变量的属性
 */
- (void)awakeFromNib
{
//    UILabel *placeholderLabel = [self valueForKeyPath:@"_placeholderLabel"];
//    placeholderLabel.textColor = [UIColor whiteColor];
    
//    //修改占位文字颜色
//    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    //不成为第一响应者
    [self resignFirstResponder];
}

/**
 *  当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder
{
    //修改占位文字颜色
    [self setValue:self.textColor forKeyPath:LKPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 *  当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder
{
    //修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:LKPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}

//- (void)setPlaceholderColor:(UIColor *)placeholderColor
//{
//    _placeholderColor = placeholderColor;
//    
//    //修改占位文字颜色
//    [self setValue:placeholderColor forKeyPath:LKPlacerholderColorKeyPath];
//}

/**
 *  运行时(Runtime): 苹果官方的一套C语言库
 *  能做很多底层操作(比如访问隐藏的一些成员变量\成员方法.....)
 */

@end


//白色提示文字
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    [self.placeholder drawInRect:CGRectMake(0, 10, rect.size.width, 25) withAttributes:@{
//                                            NSForegroundColorAttributeName : [UIColor grayColor],
//                                            NSFontAttributeName : self.font
//                                            }];
//}