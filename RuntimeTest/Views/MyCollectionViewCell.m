//
//  MyCollectionViewCell.m
//  RuntimeTest
//
//  Created by desmond on 16/5/30.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell{
	NSMutableArray *_imageNameArray;
}

- (void)awakeFromNib{
	_imageNameArray = [NSMutableArray arrayWithObjects:
					   @"icon_me_wdtz",
					   @"icon_me_wdcc",
					   @"icon_me_group",
					   @"icon_me_wdxx",
					   @"icon_me_notice",
					   @"icon_me_qchc",
					   @"icon_me_yjfk",
					   @"icon_me_about",
					   nil];
}

- (void)setImageForCellWithIndexPath:(NSIndexPath *)indexPath{
	self.nemuItemImage.image = [UIImage imageNamed:_imageNameArray[indexPath.row]];
}

@end
