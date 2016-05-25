//
//  ActivityItem.m
//  RuntimeTest
//
//  Created by desmond on 16/5/25.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ActivityItem.h"

@implementation ActivityItem

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
//	for (id activityItem in activityItems) {
//		if ([activityItem isKindOfClass:[UIImage class]]) {
//			return YES;
//		}
//		if ([activityItem isKindOfClass:[NSURL class]]) {
//			return YES;
//		}
//	}
	return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
//	for (id activityItem in activityItems) {
//		if ([activityItem isKindOfClass:[UIImage class]]) {
//			image = activityItem;
//		}
//		if ([activityItem isKindOfClass:[NSURL class]]) {
//			url = activityItem;
//		}
//		if ([activityItem isKindOfClass:[NSString class]]) {
//			title = activityItem;
//		}
//	}
}

- (void)scaledImage
{
//	if (image) {
//		CGFloat width = 100.0f;
//		CGFloat height = image.size.height * 100.0f / image.size.width;
//		UIGraphicsBeginImageContext(CGSizeMake(width, height));
//		[image drawInRect:CGRectMake(0, 0, width, height)];
//		UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//		UIGraphicsEndImageContext();
//		image = scaledImage;
//	}
}

- (void)setThumbImage:(SendMessageToWXReq *)req
{
//	if (image) {
//		CGFloat width = 100.0f;
//		CGFloat height = image.size.height * 100.0f / image.size.width;
//		UIGraphicsBeginImageContext(CGSizeMake(width, height));
//		[image drawInRect:CGRectMake(0, 0, width, height)];
//		UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//		UIGraphicsEndImageContext();
//		[req.message setThumbImage:scaledImage];
//	}
}

- (void)performActivity
{
//	SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//	req.scene = scene;
//	//    req.bText = NO;
//	req.message = WXMediaMessage.message;
//	req.message.title = title;
//	//    [self setThumbImage:req];
//	[self scaledImage];
//	[req.message setThumbImage:image];
//	if (url) {
//		WXWebpageObject *webObject = WXWebpageObject.object;
//		webObject.webpageUrl = [url absoluteString];
//		req.message.mediaObject = webObject;
//	} else if (image) {
//		WXImageObject *imageObject = WXImageObject.object;
//		imageObject.imageData = UIImageJPEGRepresentation(image, 1);
//		req.message.mediaObject = imageObject;
//	}
//	[WXApi sendReq:req];
//	[self activityDidFinish:YES];
}





@end
