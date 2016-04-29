//
//  WeeklyItemStageDetatilController.h
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeeklyItemStageDetatilController : UITableViewController


/**
 *  用于接受上一界面传过来的周刊的type
 */
@property (nonatomic ,assign) NSInteger type;
/**
 * 用于接受上一界面传过来的不同周刊的期数的id
 */
@property (nonatomic ,copy) NSString *stageId;

@property (nonatomic ,copy) NSString *text;

@end
