//
//  ContactTableViewCell.m
//  RuntimeTest
//
//  Created by desmond on 16/4/21.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ContactTableViewCell.h"

@implementation ContactTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		//布局View
		[self setUpView];
	}
	return self;
}

- (void)setUpView{
	//头像
	[self.contentView addSubview:self.headImageView];
	//姓名
	[self.contentView addSubview:self.nameLabel];
}
- (UIImageView *)headImageView{
	if (!_headImageView) {
		_headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5.0, 5.0, 40.0, 40.0)];
		[_headImageView setContentMode:UIViewContentModeScaleAspectFill];
	}
	return _headImageView;
}
- (UILabel *)nameLabel{
	if (!_nameLabel) {
		_nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(50.0, 5.0, WNXAppWidth-60.0, 40.0)];\
		[_nameLabel setFont:[UIFont systemFontOfSize:16.0]];
	}
	return _nameLabel;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
