//
//  ImageModel.m
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel


+(NSArray *)idleImages{
	
	//存放动画图片的数组
	NSMutableArray *idleImages = [NSMutableArray array];
	for (NSUInteger i = 1; i<=60; i++) {
//		UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_refresh_%zd", i]];
		
		UIImage *image = [UIImage imageNamed:@"icon_listheader_animation_1"];

		[idleImages addObject:image];
	}
	
	return idleImages.copy;
	
}


+(NSArray *)pullingImages{
	
	// 设置即将刷新状态的动画图片（一松开就会刷新的状态）
	NSMutableArray *refreshingImages = [NSMutableArray array];
	UIImage *image1 = [UIImage imageNamed:@"icon_listheader_animation_1"];
	[refreshingImages addObject:image1];
	UIImage *image2 = [UIImage imageNamed:@"icon_listheader_animation_2"];
	[refreshingImages addObject:image2];

//	NSMutableArray *refreshingImages = [NSMutableArray array];
//	for (NSUInteger i = 1; i<=3; i++) {
//		UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_refresh_%zd", i]];
//		[refreshingImages addObject:image];
//	}
//	
	return refreshingImages.copy;
	
}

@end
