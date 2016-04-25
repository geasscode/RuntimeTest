//
//  PhotoCell.m
//  RuntimeTest
//
//  Created by desmond on 16/4/25.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell



+ (UINib *)nib
{
	return [UINib nibWithNibName:@"PhotoCell" bundle:nil];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
	[super setHighlighted:highlighted animated:animated];
	if (highlighted) {
		self.photoTitleLabel.shadowColor = [UIColor darkGrayColor];
		self.photoTitleLabel.shadowOffset = CGSizeMake(3, 3);
	} else {
		self.photoTitleLabel.shadowColor = nil;
	}
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
