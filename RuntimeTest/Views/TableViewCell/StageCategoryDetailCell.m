//
//  StageCategoryDetailCell.m
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "StageCategoryDetailCell.h"
#import "WeeklyItemStageCategoryDetail.h"
#import "CategoryDetailFrameModel.h"

@interface StageCategoryDetailCell()

@property (nonatomic ,strong) UILabel *titleLabel;


@end

@implementation StageCategoryDetailCell


+ (instancetype)cellWithTableView:(UITableView *)tableView{
	
	static NSString *ID = @"categoryDetailCel";
	
	StageCategoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
	
	if (!cell) {
		
		cell = [[StageCategoryDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
	}
	
	return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		
		self.titleLabel = [[UILabel alloc] init];
		
		self.titleLabel.font = WeeklyCateforyDetailFont;
		
		self.titleLabel.numberOfLines = 0;
		
		[self.contentView addSubview:self.titleLabel];
	}
	return self;
}

- (void)setFrameModel:(CategoryDetailFrameModel *)frameModel{
	
	self.titleLabel.text = frameModel.detailModel.title;
	
	self.titleLabel.frame = frameModel.titleF;
	
}

@end
