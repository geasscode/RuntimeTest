//
//  DESNavigationController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/19.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DESNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface DESNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation DESNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationBar.barTintColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+ (void)initialize
{
	
	//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
	//    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
	//    attrs[NSForegroundColorAttributeName] = XCFThemeColor;
	//
	//    UINavigationBar *appearance = [UINavigationBar appearance];
	//    [appearance setTitleTextAttributes:attrs];
//	UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
//	[bar setBackgroundImage:[UIImage imageNamed:@"recomend_btn_gone"] forBarMetrics:UIBarMetricsDefault];
//	//  nc.navigationBar.translucent = NO;
//	//去掉导航条的半透明
//	bar.translucent = NO;
//	
//	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//	dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
//	dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
//	
//	[bar setTitleTextAttributes:dict];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
	if (self.viewControllers.count > 0) {
		// 替换back按钮
		UIBarButtonItem *backBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"backStretchBackgroundNormal"
																		 imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)
																				  target:self
																				  action:@selector(back)];
		viewController.navigationItem.leftBarButtonItem = backBarButtonItem;
		// 隐藏tabbar
		viewController.hidesBottomBarWhenPushed = YES;
	}
	[super pushViewController:viewController animated:animated];
}

- (void)back {
	[self popViewControllerAnimated:YES];
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
