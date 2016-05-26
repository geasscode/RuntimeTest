//
//  PresentingViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/5/26.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "PresentingViewController.h"

@implementation PresentingViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
	[button setFrame:CGRectMake(self.view.frame.size.height / 2.0, 0, self.view.frame.size.width, self.view.frame.size.height / 2.0)];
	button.center = CGPointMake(self.view.center.x, self.view.center.y * 1.5);
	[button setTitle:@"Back" forState:UIControlStateNormal];
	
	UIButton *switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[switchButton addTarget:self action:@selector(switchColor) forControlEvents:UIControlEventTouchUpInside];
	[switchButton setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2.0)];
	switchButton.center = CGPointMake(self.view.center.x, self.view.center.y * 0.5);
	[switchButton setTitle:@"SwitchColor" forState:UIControlStateNormal];
	
	[self.view addSubview:button];
	[self.view addSubview:switchButton];
	
	self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
	[button dk_setTitleColorPicker:DKColorPickerWithKey(TINT) forState:UIControlStateNormal];
	[switchButton dk_setTitleColorPicker:DKColorPickerWithKey(TINT) forState:UIControlStateNormal];
	
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
	
}

- (void)back {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)switchColor {
	if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
		[self.dk_manager dawnComing];
	} else {
		[self.dk_manager nightFalling];
	}
}

@end
