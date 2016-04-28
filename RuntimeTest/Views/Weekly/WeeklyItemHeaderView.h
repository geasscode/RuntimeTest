//
//  WeeklyItemHeaderView.h
//  RuntimeTest
//
//  Created by desmond on 16/4/27.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeeklyItemHeaderView;
@class WeeklyItemModel;

@protocol HeaderViewDelegate <NSObject>

@optional

- (void)headerViewDidClickMoreLabel:(WeeklyItemHeaderView*)headerView viewForItemType:(NSInteger)type;

@end

@interface WeeklyItemHeaderView : UITableViewHeaderFooterView

@property(nonatomic,weak)id <HeaderViewDelegate> delegate;
@property(nonatomic,strong)UILabel *weeklyItemLabel;
@property(nonatomic,strong)WeeklyItemModel * itemModel;


+(instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
