//
//  CategoryDetailFrameModel.h
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>
#define WeeklyCateforyDetailFont [UIFont systemFontOfSize:14]
@class WeeklyItemStageCategoryDetail;

@interface CategoryDetailFrameModel : NSObject


/**
 *  标题的frame
 */
@property (nonatomic ,assign,readonly) CGRect titleF;

/**
 *  cell的高度
 */
@property (nonatomic ,assign,readonly) CGFloat cellHeight;

/**
 *  数据模型
 */
@property (nonatomic ,strong) WeeklyItemStageCategoryDetail *detailModel;

@end
