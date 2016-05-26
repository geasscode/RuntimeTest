//
//  SuccViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/5/26.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "SuccViewController.h"

@implementation SuccViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
	self.navigationController.navigationBar.dk_tintColorPicker = DKColorPickerWithKey(TINT);
	
	UITextField *textField = [[UITextField alloc] init];
	textField.frame = self.view.frame;
	textField.dk_textColorPicker = DKColorPickerWithKey(TEXT);
	[self.view addSubview:textField];
}

@end
