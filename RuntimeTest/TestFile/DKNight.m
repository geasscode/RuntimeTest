//
//  DKNight.m
//  RuntimeTest
//
//  Created by desmond on 16/5/26.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DKNight.h"
#import "DKNightTableViewCell.h"
#import "SuccViewController.h"
#import "PresentingViewController.h"

@implementation DKNight

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.tableView registerClass:[DKNightTableViewCell class] forCellReuseIdentifier:@"Cell"];
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
	
	UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
	navigationLabel.text = @"DKNightVersion";
	navigationLabel.textAlignment = NSTextAlignmentCenter;
	self.navigationItem.titleView = navigationLabel;
	
	UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Present" style:UIBarButtonItemStylePlain target:self action:@selector(present)];
	self.navigationItem.leftBarButtonItem = item;
	
	UIBarButtonItem *normalItem = [[UIBarButtonItem alloc] initWithTitle:@"Normal" style:UIBarButtonItemStylePlain target:self action:@selector(normal)];
	
	normalItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
	UIBarButtonItem *nightItem = [[UIBarButtonItem alloc] initWithTitle:@"Night" style:UIBarButtonItemStylePlain target:self action:@selector(night)];
	
	nightItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
	UIBarButtonItem *redItem = [[UIBarButtonItem alloc] initWithTitle:@"Red" style:UIBarButtonItemStylePlain target:self action:@selector(red)];
	
//	redItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
	
	self.navigationItem.rightBarButtonItems = @[normalItem, nightItem, redItem];
	
//	    self.tableView.dk_backgroundColorPicker =  DKColorPickerWithKey(BG);
	self.tableView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
	self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);
//	navigationLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
	self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
//	self.navigationItem.leftBarButtonItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
	
}

- (void)night {
	self.dk_manager.themeVersion = DKThemeVersionNight;
}

- (void)normal {
	self.dk_manager.themeVersion = DKThemeVersionNormal;
}

- (void)red {
	self.dk_manager.themeVersion = @"RED";
}

- (void)change {
	
	if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
		[self.dk_manager dawnComing];
	} else {
		[self.dk_manager nightFalling];
	}
}

- (void)push {
	[self.navigationController pushViewController:[[SuccViewController alloc] init] animated:YES];
}

- (void)present {
	[self presentViewController:[[PresentingViewController alloc] init] animated:YES completion:nil];
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	DKNightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	cell.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self push];
}

@end
