//
//  WeeklyItemStageDetailModel.h
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^successBlock)(NSArray *array);

@interface WeeklyItemStageDetailModel : NSObject

/**
 *  每一期内的分类名字
 */
@property (nonatomic ,copy) NSString *name;

/**
 *  装有每一期分类新闻简介的模型数组
 */
@property (nonatomic ,strong) NSArray *items;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  请求分类新闻简介的数据
 */
+ (void)stageDetailRequestURL:(NSString *)urlString success:(successBlock)success;

@end
