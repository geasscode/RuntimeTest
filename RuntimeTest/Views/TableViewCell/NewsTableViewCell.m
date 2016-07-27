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
	
//	放在cell里非常慢。创建spoolight。应该独立出来遍历数组。
//	CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString *)kUTTypeImage];
//	
//	// 标题
//	attributeSet.title =  articleModel.title;
//	// 关键字,NSArray可设置多个
//	attributeSet.keywords = @[articleModel.title];
//	// 描述
//	attributeSet.contentDescription =articleModel.feed_title;
//	// 图标, NSData格式
//	attributeSet.thumbnailData = UIImagePNGRepresentation([UIImage imageNamed:@"psb"]);
//	// Searchable item
//	CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:@"1" domainIdentifier:@"geasscode.com" attributeSet:attributeSet];
//	
//	NSMutableArray *searchItems = [NSMutableArray arrayWithObjects:item, nil];
//	//indexSearchableItems 接收参数NSMutableArray
//	[[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:searchItems completionHandler:^(NSError * error) {
//		if (error) {
//			NSLog(@"索引创建失败:%@",error.localizedDescription);
//		}else{
//			NSLog(@"索引创建成功");
//			
//		}
//	}];
	
	//删除所有索引。索引3种形式删除 deleteSearchableItemsWithDomainIdentifiers deleteSearchableItemsWithIdentifiers deleteAllSearchableItemsWithCompletionHandler
//	[[CSSearchableIndex defaultSearchableIndex] deleteAllSearchableItemsWithCompletionHandler:^(NSError * _Nullable error) {
//		if (error) {
//			NSLog(@"%@",error.localizedDescription);
//		}else{
//			[self performSelectorOnMainThread:@selector(showAlert:) withObject:@"删除所有索引成功" waitUntilDone:NO];
//		}
//	}];
}

@end
