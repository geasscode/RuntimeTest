//
//  StageCategoryHeaderView.m
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "StageCategoryHeaderView.h"
#import "WeeklyItemStageDetailModel.h"
#import "UIView+Utils.h"

@interface StageCategoryHeaderView ()
@property (nonatomic ,strong) UILabel *categoryName;
@end

@implementation StageCategoryHeaderView


+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
	
	static NSString *ID = @"cagegoryHeaer";
	
	StageCategoryHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
	
	if (!header) {
		
		header = [[StageCategoryHeaderView alloc] initWithReuseIdentifier:ID];
		
	}
	
	return header;
	
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
	
	if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
		
		//添加控件
		self.categoryName = [[UILabel alloc] init];
		self.categoryName.textColor = NavColor;
		self.categoryName.font = [UIFont systemFontOfSize:15];
		[self.contentView addSubview:self.categoryName];
		
	}
	
	return self;
}

- (void)layoutSubviews{
	
	[super layoutSubviews];
	self.categoryName.frame = CGRectMake(5, 0, 100, self.height);
}

- (void)setDetailModel:(WeeklyItemStageDetailModel *)detailModel{
	
	self.categoryName.text = detailModel.name;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
