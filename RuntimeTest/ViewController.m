//
//  ViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/3/17.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)injected
{
	NSLog(@"I've been injecteds: %@", self);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
- (IBAction)dismissVC:(id)sender {
	[ self dismissViewControllerAnimated: YES completion: nil ];
}

@end
