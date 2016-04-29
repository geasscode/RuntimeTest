//
//  WeeklyItemStageCategoryDetail.h
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeeklyItemStageCategoryDetail : NSObject


@property (nonatomic ,copy) NSString *url;

@property (nonatomic ,copy) NSString *title;

@property (nonatomic ,copy) NSString *meta;

@property (nonatomic ,assign) NSInteger type;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
