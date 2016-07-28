//
//  CustomActivity.h
//  RuntimeTest
//
//  Created by desmond on 16/7/27.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomActivity : UIActivity {
	NSString *title;
	UIImage *image;
	NSURL *url;
}

@property (nonatomic, copy) void(^performActivityBlock)();


@end
