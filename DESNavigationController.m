//
//  DESNavigationController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/19.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DESNavigationController.h"

@interface DESNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation DESNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+ (void)initialize
{
	UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
	[bar setBackgroundImage:[UIImage imageNamed:@"recomend_btn_gone"] forBarMetrics:UIBarMetricsDefault];
	//  nc.navigationBar.translucent = NO;
	//去掉导航条的半透明
	bar.translucent = NO;
	
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
	dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
	
	[bar setTitleTextAttributes:dict];
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
