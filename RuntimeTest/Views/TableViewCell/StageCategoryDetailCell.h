//
//  StageCategoryDetailCell.h
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryDetailFrameModel;

@interface StageCategoryDetailCell : UITableViewCell

@property (nonatomic ,strong) CategoryDetailFrameModel *frameModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
