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

//- (void)awakeFromNib{
//	_imageNameArray = [NSMutableArray arrayWithObjects:
//					   @"icon_me_wdtz",
//					   @"icon_me_wdcc",
//					   @"icon_me_group",
//					   @"icon_me_wdxx",
//					   @"icon_me_notice",
//					   @"icon_me_qchc",
//					   @"icon_me_yjfk",
//					   @"icon_me_about",
//					   @"icon_me_wddd",
//					   nil];
//	
////	_titleArray = @[@"我的帖子",@"我的收藏",@"我的小组",@"我的消息",@"我的通知",@"清除缓存",@"意见反馈",@"关于我们",@"我的订单"];
//}

- (void)setImageForCellWithIndexPath:(NSIndexPath *)indexPath{
//	self.nemuItemImage.image = [UIImage imageNamed:_imageNameArray[indexPath.row]];
	
	self.mineImageView.image = [UIImage imageNamed:_imageNameArray[indexPath.row]];
	self.mineTextLabel.text = _titleArray[indexPath.row];

}



- (instancetype)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		
		_imageNameArray = [NSMutableArray arrayWithObjects:
						   @"noReadNews",
						   @"favorite",
						   @"theme",
						   @"orderNews",
						   @"password",
						   @"clean",
						   @"myFeedBack",
						   @"aboutMe",
						   @"changeMyPassword",
						   nil];
		
		_titleArray = @[@"未读文章",@"我的收藏",@"主题切换",@"我的订阅",@"修改密码",@"清除缓存",@"意见反馈",@"关于我们",@"忘记密码"];
		self.backgroundColor = [UIColor whiteColor];
		self.mineImageView.frame = CGRectMake(10, 10, 60, 60);
		self.mineImageView.center = CGPointMake(self.contentView.center.x,self.contentView.center.y - 10);
		[self addSubview:self.mineImageView];
		
		self.mineTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height- 30,frame.size.width, 20)];
		self.mineTextLabel.textAlignment = NSTextAlignmentCenter;
		self.mineTextLabel.textColor = [UIColor blackColor];
		self.mineTextLabel.font = [UIFont systemFontOfSize:13];
		[self addSubview:self.mineTextLabel];
	}
	return self;
}

- (UIImageView *)mineImageView{
	if (!_mineImageView) {
		_mineImageView = [[UIImageView alloc]init];
	}
	//    _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
	//    _imageView.layer.borderWidth = 0.5;
	return _mineImageView;
}

@end
