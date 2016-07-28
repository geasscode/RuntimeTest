//
//  WeiboActivity.m
//  RuntimeTest
//
//  Created by desmond on 16/7/27.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "WeiboActivity.h"

@implementation WeiboActivity


//- (void)performActivity {
//    if (self.performActivityBlock) {
//        self.performActivityBlock();
//    }
//    [self activityDidFinish:YES];
//}

- (UIImage *)activityImage
{
	return [UIImage imageNamed:@"weibo"];
}

- (NSString *)activityTitle
{
	return @"新浪微博";
}


@end
