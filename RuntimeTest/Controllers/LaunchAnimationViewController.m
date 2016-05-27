//
//  LaunchAnimationViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/5/27.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "LaunchAnimationViewController.h"

#import "AppDelegate.h"
#import <UIImage+GIF.h>
#import "DESTabBarController.h"

@interface LaunchAnimationViewController ()

@end

@implementation LaunchAnimationViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIImageView *launchAnimationView = nil;
	if (self.view.bounds.size.width == 414.0) {
		launchAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 260)];
	}else{
		launchAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 250)];
	}
	
	UIImage *gifImage = [UIImage sd_animatedGIFNamed:@"iPhone-6-Crop"];
	launchAnimationView.image = gifImage;
	[self.view addSubview:launchAnimationView];
	
	[UIView animateWithDuration:0.3 delay:1.6 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
		launchAnimationView.alpha = 0;
	} completion:^(BOOL finished) {
		AppDelegate *delegate = (id)[UIApplication sharedApplication].delegate;
//		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//		delegate.window.rootViewController=[storyboard instantiateInitialViewController];
		delegate.window.rootViewController= [[DESTabBarController alloc] init];
		[delegate.window makeKeyAndVisible];
	}];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
