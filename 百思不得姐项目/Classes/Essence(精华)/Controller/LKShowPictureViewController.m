//
//  LKShowPictureViewController.m
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/19.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKShowPictureViewController.h"
#import "LKTopicModel.h"

#import "LKProgressView.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface LKShowPictureViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet LKProgressView *progressView;

@end

@implementation LKShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    //图片的尺寸
    CGFloat pictureW = LKScreenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    
    if (pictureH > LKScreenH) {//图片显示高度超过一个屏幕
        //需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
        
    } else {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = LKScreenH * 0.5;
    }
    
    //马上显示当前图片的下载进度
    [self.progressView setProgress:self.topic.pictureProgress animated:NO];
    
    //下载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片还没下载完"];
        return;
    }
    
    //将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

@end
