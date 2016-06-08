//
//  LKLKRecommendTagsModel.h
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/8.
//  Copyright © 2016年 LK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKLKRecommendTagsModel : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;

@end
