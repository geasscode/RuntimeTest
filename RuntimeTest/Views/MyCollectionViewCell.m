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
	NSArray *_titleArray;
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
					   @"icon_me_wddd",
					   nil];
	
//	_titleArray = @[@"我的帖子",@"我的收藏",@"我的小组",@"我的消息",@"我的通知",@"清除缓存",@"意见反馈",@"关于我们",@"我的订单"];
}

- (void)setImageForCellWithIndexPath:(NSIndexPath *)indexPath{
	self.nemuItemImage.image = [UIImage imageNamed:_imageNameArray[indexPath.row]];
//	self.textLabel.text = _titleArray[indexPath.row];
}

@end
