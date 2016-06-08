//
//  LKRecommendUserCell.h
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/7.
//  Copyright © 2016年 LK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LKRecommendUserModel;

@interface LKRecommendUserCell : UITableViewCell
/** 用户模型 */
@property (nonatomic, strong)LKRecommendUserModel *user;
@end
