//
//  CustomActivity.m
//  RuntimeTest
//
//  Created by desmond on 16/7/27.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "CustomActivity.h"

@implementation CustomActivity


#pragma mark  操作


+ (UIActivityCategory)activityCategory
{
	return UIActivityCategoryShare;
}

- (NSString *)activityType
{
	return NSStringFromClass([self class]);
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
	
	if (activityItems.count > 0){
		return YES;
	}
	return NO;
	
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
	for (id activityItem in activityItems) {
		if ([activityItem isKindOfClass:[UIImage class]]) {
			image = activityItem;
		}
		if ([activityItem isKindOfClass:[NSURL class]]) {
			url = activityItem;
		}
		if ([activityItem isKindOfClass:[NSString class]]) {
			title = activityItem;
		}
	}
}

- (void)performActivity {
	
	
	//这里就可以关联外面的app进行分享操作了
	//也可以进行一些数据的保存等操作
	//操作的最后必须使用下面方法告诉系统分享结束了
	
	if (self.performActivityBlock) {
		self.performActivityBlock();
	}
	[self activityDidFinish:YES];
}

@end
