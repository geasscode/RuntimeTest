//
//  WeeklyItemHeaderView.m
//  RuntimeTest
//
//  Created by desmond on 16/4/27.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "WeeklyItemHeaderView.h"
#import "WeeklyItemModel.h"
#import "UIView+Utils.h"



@interface WeeklyItemHeaderView()
@property (nonatomic ,strong) UILabel *moreLabel;
@property (nonatomic ,assign) int index;

@end

@implementation WeeklyItemHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)headerViewWithTableView:(UITableView *)tableView{
	static NSString * ID = @"header";
	
	WeeklyItemHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
	
	if (!headerView) {
		headerView = [[WeeklyItemHeaderView alloc]initWithReuseIdentifier:ID];
	}
	return headerView;
}


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
	
	if(self = [super initWithReuseIdentifier:reuseIdentifier]){
		_weeklyItemLabel = [UILabel new];
		_weeklyItemLabel.font = [UIFont systemFontOfSize:15];
		_weeklyItemLabel.textColor = NavColor;
		[self.contentView addSubview:_weeklyItemLabel];
		
		
		_moreLabel = [UILabel new];
		_moreLabel.font = [UIFont systemFontOfSize:14];
		_moreLabel.text = @"更多";
		_moreLabel.tag = self.index;
		[_moreLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreBtnDidClick:)]];
		[self.contentView addSubview:_moreLabel];
		
	}
	return self;
}


- (void)layoutSubviews{
	
	[super layoutSubviews];
	self.weeklyItemLabel.frame = CGRectMake(5, 0, 80, self.height);
	
	CGFloat moreLabelW = 60;
	//在这里设置用户交互属性才有效
	self.moreLabel.userInteractionEnabled = YES;
	self.moreLabel.frame = CGRectMake(kScreenWidth - moreLabelW, 0, moreLabelW, self.height);
}
- (void)moreBtnDidClick:(UITapGestureRecognizer *)tap{
	
	if ([self.delegate respondsToSelector:@selector(headerViewDidClickMoreLabel:viewForItemType:)]) {
		
		[self.delegate headerViewDidClickMoreLabel:self viewForItemType:self.weeklyItemLabel.tag];
	}
}

- (void)setItemModel:(WeeklyItemModel *)itemModel{
	
	self.weeklyItemLabel.text = itemModel.name;
	
	self.weeklyItemLabel.tag = itemModel.type;
}


@end
