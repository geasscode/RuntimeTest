//
//  WeeklyItemStageModel.h
//  RuntimeTest
//
//  Created by desmond on 16/4/28.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
typedef void(^successBlock)(NSArray *itemStageArray);

@interface WeeklyItemStageModel : NSObject

/**
 *  期数的id
 */
@property (nonatomic ,copy) NSString *stageId;
/**
 *  所属的类型
 */
@property (nonatomic ,assign) NSInteger type;
/**
 *  是哪一期的
 */
@property (nonatomic ,copy) NSString *title;
/**
 *  时间
 */
@property (nonatomic ,copy) NSString *time;

+ (void)weeklyItmeStageRequestURL:(NSString *)urlString success:(successBlock)successBlock;

@end
