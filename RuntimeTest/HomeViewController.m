//
//  HomeViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/19.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
//** 导航titileView */
@property (nonatomic, weak) UISegmentedControl *titleView;

//推荐View
@property (nonatomic, strong) UITableView *rmedView;
//headModels，用来控制headView的属性
@property (nonatomic, strong) NSMutableArray *headModels;

/** home的模型 */
@property (nonatomic, strong) NSMutableArray *datas;

/** cell的模型 */
@property (nonatomic, strong) NSMutableArray *cellDatas;

@property (nonatomic, strong) UIImageView *nearImageView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupNavigationItem];
	
    // Do any additional setup after loading the view.
}

//重新定义导航条的状态
- (void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"recomend_btn_gone"] forBarMetrics:UIBarMetricsDefault];
	[super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupNavigationItem{
	//设置导航条titleView
	UISegmentedControl *titleV = [[UISegmentedControl alloc] initWithItems:@[@"推荐", @"附近"]];
	[titleV setTintColor:WNXColor(26, 163, 146)];
	titleV.frame = CGRectMake(0, 0, self.view.bounds.size.width * 0.5, 30);
	//文字设置
	NSMutableDictionary *attDic = [NSMutableDictionary dictionary];
	attDic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
	attDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
	[titleV setTitleTextAttributes:attDic forState:UIControlStateNormal];
	[titleV setTitleTextAttributes:attDic forState:UIControlStateSelected];
	//事件
	titleV.selectedSegmentIndex = 0;
	[titleV addTarget:self action:@selector(titleViewChange:) forControlEvents:UIControlEventValueChanged];
	_titleView = titleV;
	self.navigationItem.titleView = _titleView;
}

#pragma mark - titleViewAction
- (void)titleViewChange:(UISegmentedControl *)sender
{
	if (sender.selectedSegmentIndex == 0) {
		//显示推荐View
		[self.view addSubview:self.rmedView];
		[self.nearImageView removeFromSuperview];
	} else {
		//显示nearView
		[self.view addSubview:self.nearImageView];
		[self.rmedView removeFromSuperview];
	}
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
