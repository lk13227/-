//
//  LKRecommendUserModel.h
//  百思不得姐项目
//
//  Created by 理念-刘凯 on 16/3/7.
//  Copyright © 2016年 LK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKRecommendUserModel : NSObject
/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 粉丝数 */
@property (nonatomic, assign) NSInteger fans_count;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;
@end
