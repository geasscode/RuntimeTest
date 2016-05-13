//
//  NewsTableViewCell.h
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArticleModel;

@interface NewsTableViewCell : UITableViewCell

@property (nonatomic,strong) ArticleModel *articleModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView imageCount:(NSInteger)count;

@end
