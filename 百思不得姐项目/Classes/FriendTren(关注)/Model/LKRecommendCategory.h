//
//  LKRecommendCategory.h
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/6.
//  Copyright © 2016年 LK. All rights reserved.
//推荐关注  左边的数据模型

#import <Foundation/Foundation.h>

@interface LKRecommendCategory : NSObject
/** id */
@property (nonatomic, assign) NSInteger ID;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;


/** 这个类别对应的数据模型 */
@property (nonatomic, strong)NSMutableArray *users;
/** 总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;
@end
