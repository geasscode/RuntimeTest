//
//  MainViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/19.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "FoundViewController.h"
#import "DESNavigationController.h"
#import "RuntimeTableViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//	NSArray * array  = @[@"hoem"];
//	NSLog(@"hello");
//	NSArray *classNames = @[@"HomeViewController"];
//	for(NSString *className in classNames){
//		
//		Class dictionaryClass = NSClassFromString(className);
//		UIViewController *vc  = (UIViewController*)[[dictionaryClass alloc] init];
//		
////		UIViewController *vc  = (UIViewController*)[[NSClassFromString(className) alloc] init];
//		DESNavigationController *nc = [[DESNavigationController alloc]initWithRootViewController:vc];
//		nc.view.layer.shadowColor = [UIColor blackColor].CGColor;
//		nc.view.layer.shadowOffset = CGSizeMake(-3.5, 0);
//		nc.view.layer.shadowOpacity = 0.2;
//		[self addChildViewController:nc];
//	}
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoRuntimeTableView:(id)sender {
	RuntimeTableViewController * rumtimeVC = [RuntimeTableViewController new];
	[self.navigationController pushViewController:rumtimeVC animated:YES];
	
}
- (IBAction)gotoContactView:(id)sender {
	
//	[self.navigationController pushViewController:rumtimeVC animated:YES];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
