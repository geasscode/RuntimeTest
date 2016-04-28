//
//  WeeklyItemCell.h
//  RuntimeTest
//
//  Created by desmond on 16/4/28.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeeklyItemStageModel;

@interface WeeklyItemCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic ,strong) WeeklyItemStageModel *stageModel;

@end
