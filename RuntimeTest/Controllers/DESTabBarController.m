//
//  DESTabBarController.m
//  RuntimeTest
//
//  Created by desmond on 16/5/9.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DESTabBarController.h"
#import "WeeklyTableViewController.h"
#import "scanViewController.h"
#import "ContactInfoTableViewController.h"
#import "MainViewController.h"
#import "DESNavigationController.h"
#import "SigmaTableViewController.h"
#import "ArticleHomeViewController.h"
#import "BarCodeViewController.h"
@implementation DESTabBarController
+ (void)initialize {
	
	//修改Tabbar Item的属性
	NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
	normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
	normalAttrs[NSForegroundColorAttributeName] = kTabBarNormalColor;
	
	NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
	selectedAttrs[NSFontAttributeName] = normalAttrs[NSFontAttributeName];
	selectedAttrs[NSForegroundColorAttributeName] =kThemeColor;
	
	UITabBarItem *appearance = [UITabBarItem appearance];
	[appearance setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
	[appearance setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
	
	
}

- (void)viewDidLoad {
	
	UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoadData" bundle:nil];
	MainViewController *mainVC = (MainViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"mainVC"];
	
	 

	[self setupChildViewController:mainVC
							 title:@"首页"
							 image:@"tabCDeselected"
					 selectedImage:@"tabDSelected"];
	
	[self setupChildViewController:[[ArticleHomeViewController alloc] init]
							 title:@"文章"
							 image:@"tabADeselected"
					 selectedImage:@"tabASelected"];
	
	[self setupChildViewController:[[WeeklyTableViewController alloc] init]
							 title:@"周刊"
							 image:@"tabBDeselected"
					 selectedImage:@"tabBSelected"];
	
//	[self setupChildViewController:[[scanViewController alloc] init]
//							 title:@"二维码"
//							 image:@"tabCDeselected"
//					 selectedImage:@"tabCSelected"];
	
	[self setupChildViewController:[[BarCodeViewController alloc] init]
							 title:@"二维码"
							 image:@"tabCDeselected"
					 selectedImage:@"tabCSelected"];
	
	[self setupChildViewController:[[ContactInfoTableViewController alloc] init]
							 title:@"通讯录"
							 image:@"tabDDeselected"
					 selectedImage:@"tabDSelected"];
	
}

- (void)setupChildViewController:(UIViewController *)childController
						   title:(NSString *)title
						   image:(NSString *)image
				   selectedImage:(NSString *)selectedImage {
	childController.title = title;
	[childController.tabBarItem setImage:[UIImage imageNamed:image]];
	[childController.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImage]];
	DESNavigationController *navCon = [[DESNavigationController alloc] initWithRootViewController:childController];
	navCon.title = title;
	
	[self addChildViewController:navCon];
}

@end
