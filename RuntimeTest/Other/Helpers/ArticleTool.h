//
//  ArticleTool.h
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ArticleModel;
@interface ArticleTool : NSObject

/**
 *  删除一个模型
 */
+(void)deleteArticalWithModel:(ArticleModel *)model;
/**
 *  添加一个模型
 */
+ (void)addArticalWithModel:(ArticleModel *)model;
/**
 *  添加一组数据
 */
+ (void)addArticalWithArray:(NSArray *)modelArray;
/**
 *  获取全部数据
 */
+ (NSArray *)Articalsback;

@end