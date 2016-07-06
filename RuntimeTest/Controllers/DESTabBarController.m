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
#import "MineViewController.h"
#import "AdvertiseViewController.h"
#import "DESSiteTableViewController.h"

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

//知识点，看到好的文章的知识点可以随时补充到这个项目来。
//nil是OC的，空对象，地址指向空（0）的对象。对象的字面零值
//
//* Nil是Objective-C类的字面零值
//
//* NULL是C的，空地址，地址的数值是0，是个长整数
//
//* NSNull用于解决向NSArray和NSDictionary等集合中添加空值的问题

- (void)viewDidLoad {
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAd) name:@"pushtoad" object:nil];

	
	UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoadData" bundle:nil];
	MainViewController *mainVC = (MainViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"mainVC"];
	
//	对于storyboard中的UI 组建直接new 一个会黑屏，必须加载storyboard。
	MineViewController *mine = (MineViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"mineVC"];

	
	 

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
	
//	[self setupChildViewController:[[BarCodeViewController alloc] init]
//							 title:@"二维码"
//							 image:@"tabCDeselected"
//					 selectedImage:@"tabCSelected"];
	
	[self setupChildViewController:[[DESSiteTableViewController alloc] init]
							 title:@"站点"
							 image:@"tabCDeselected"
					 selectedImage:@"tabCSelected"];
	
//	[self setupChildViewController:[[ContactInfoTableViewController alloc] init]
//							 title:@"通讯录"
//							 image:@"tabDDeselected"
//					 selectedImage:@"tabDSelected"];
	
	[self setupChildViewController:mine
							 title:@"我的"
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
	
//	去掉BackBarButtonItem的文字
//	[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//														 forBarMetrics:UIBarMetricsDefault];
	
//	// 修改标题位置
//	childController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -10);
//	// 修改图片位置
//	childController.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
//	
//	// 批量修改属性
//	for (UIBarItem *item in self.tabBarController.tabBar.items) {
//		[item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//									  [UIFont fontWithName:@"Helvetica" size:19.0], NSFontAttributeName, nil]
//							forState:UIControlStateNormal];
//	}
//	
//	// 设置选中和未选中字体颜色
//	[[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
//	
//	//未选中字体颜色
//	[[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateNormal];
//	
//	//选中字体颜色
//	[[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor cyanColor]} forState:UIControlStateSelected];
	
	DESNavigationController *navCon = [[DESNavigationController alloc] initWithRootViewController:childController];
	navCon.title = title;
	
	
	
	
	[self addChildViewController:navCon];
}

//- (void)pushToAd {
//	
//
//	AdvertiseViewController *adVc = [[AdvertiseViewController alloc] init];
//	
//	DESNavigationController *navCon = [[DESNavigationController alloc] initWithRootViewController:adVc];
//	
//	navCon.title = @"pic";
//
//}

@end
