//
//  NewsTableViewCell.m
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "NewsTableViewCell.h"

#import "ArticleModel.h"
#import "UIImageView+WebCache.h"


@interface NewsTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *feed_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@end

@implementation NewsTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView imageCount:(NSInteger)count{
	
	NSString *ID = @"";
	if (count > 0) {
		
		ID = @"NewsTableViewCell";
		
	}else{
		
		ID = @"NewsTableViewCell1";
		
	}
	
	NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
	
	if (cell == nil) {
		if ([ID isEqualToString:@"NewsTableViewCell"]) {
			cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:nil options:nil] lastObject];
		}else{
			
			cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:nil options:nil] firstObject];
		}
	}
	
	return cell;
}



-(void)setArticleModel:(ArticleModel *)articleModel{
	
	_articleModel = articleModel;
	
	self.titleLabel.text = articleModel.title;
	self.feed_titleLabel.text = articleModel.feed_title;
	self.timeLabel.text = articleModel.time;
	
	if (articleModel.img) {
		[self.iconImageView sd_setImageWithURL:[NSURL URLWithString:articleModel.img] placeholderImage:[UIImage imageNamed:@"abs_pic"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
			
			if (error) {
				self.iconImageView.image = [UIImage imageNamed:@"abs_pic_broken"];
			}
			
		}];
	}
}

@end
