//
//  DESSiteItemTableViewCell.m
//  RuntimeTest
//
//  Created by desmond on 16/7/6.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DESSiteItemTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface DESSiteItemTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *CountBtn;

@end

@implementation DESSiteItemTableViewCell

//- (void)awakeFromNib {
//
//}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		
		self = [[[NSBundle mainBundle]loadNibNamed:@"DESSiteItemTableViewCell" owner:nil options:nil] lastObject];
		//        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
		
//		self.iconImageView.layer.cornerRadius = 12;
//		self.iconImageView.layer.masksToBounds = YES;
//		self.iconImageView.layer.borderWidth = 1;
		self.iconImageView.layer.borderColor = [UIColor colorWithRed:211 / 255.0 green:211 / 255.0 blue:211 / 255.0 alpha:1].CGColor;
		
		self.CountBtn.layer.cornerRadius = 9;
		self.CountBtn.layer.masksToBounds = YES;
		
	}
	return self;
}

-(void)setSiteItemModel:(DESSiteItemModel *)siteItemModel{
	
	_siteItemModel = siteItemModel;
	
	self.nameLabel.text = siteItemModel.name;
	NSLog(@"%@",siteItemModel.count);
	if (siteItemModel.count.length > 0 ) {
		self.CountBtn.hidden = NO;
		self.CountBtn.titleLabel.text = siteItemModel.count;
	}else{
		
		self.CountBtn.hidden = YES;
	}
	
	
	
	[self.iconImageView sd_setImageWithURL:[NSURL URLWithString:siteItemModel.image] placeholderImage:[UIImage imageNamed:@"abs_pic"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
		
		
		
	}];
	
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

@end

