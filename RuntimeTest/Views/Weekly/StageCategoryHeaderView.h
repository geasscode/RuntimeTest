//
//  StageCategoryHeaderView.h
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeeklyItemStageDetailModel;

@interface StageCategoryHeaderView : UITableViewHeaderFooterView

@property (nonatomic ,strong) WeeklyItemStageDetailModel *detailModel;


+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
