//
//  FavoriteCell.m
//  RuntimeTest
//
//  Created by desmond on 16/5/16.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "FavoriteCell.h"

@implementation FavoriteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self.contentView addSubview:self.lblTitle];
		[self.contentView addSubview:self.lblTag];
	}
	return self;
}
- (UILabel *)lblTag {
	if (!_lblTag) {
		self.lblTag = [[UILabel alloc] initWithFrame:CGRectMake(5, 7, 50, 30)];
		_lblTag.font = [UIFont systemFontOfSize:16];
	}
	return _lblTag;
}
- (UILabel *)lblTitle {
	if (!_lblTitle) {
		self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(55, 7, kScreenWidth - 70, 30)];
		_lblTitle.font = [UIFont systemFontOfSize:16];
	}
	return _lblTitle;
}

@end
