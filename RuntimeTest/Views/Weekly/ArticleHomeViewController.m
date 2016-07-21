//
//  ArticleHomeViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ArticleHomeViewController.h"
#import "TitleModel.h"

#import "DetailViewController.h"
//#import "SearchViewController.h"

@interface ArticleHomeViewController ()


@end

@implementation ArticleHomeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	[self setNav];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToDetailText:) name:@"ContentcellPushToDetailTextVCNotification" object:nil];
	
	self.titleModelArray = [TitleModel titleModelGetModelArrayWith:@"titleArray.plist"];
	
	[self setUI];
	
}

-(void)dealloc{
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
}




#pragma mark - 设置导航栏
/**
 *  设置导航栏
 */
-(void)setNav{
	
	UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchBtn)];
	
//	UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"more1"] style:UIBarButtonItemStylePlain target:self action:@selector(moreBtn)];
	
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 5, 60, 30)]];
	
	//设置字体记得在plist增加 Font provided by application
	
//	UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
//	titleLabel.text = @"文章";
//	[titleLabel setFont:[UIFont fontWithName:@"LiSu" size:30]];
//	titleLabel.textColor = [UIColor whiteColor];
//	titleLabel.textAlignment = NSTextAlignmentCenter;
//	[self.navigationController.navigationBar addSubview:titleLabel];
//	titleLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 28);
	
	self.navigationItem.leftBarButtonItem = leftItem;
//	self.navigationItem.rightBarButtonItem = rightItem;
	
}
/**
 *  导航栏搜索(左侧)按钮
 */
-(void)searchBtn{
	
//	HZYSearchViewController *searchVC = [[HZYSearchViewController alloc]init];
//	
//	HZYNavigationController *nav = [[HZYNavigationController alloc]initWithRootViewController:searchVC];
//	
//	[self.navigationController presentViewController:nav animated:YES completion:nil];
	
}
/**
 *  导航栏更多(右侧)按钮
 */
-(void)moreBtn{
	
}

#pragma mark - push到详细页面的通知方法
-(void)pushToDetailText:(NSNotification *)notification{
	
	DetailViewController *detail = [[DetailViewController alloc]init];
	
	detail.detailTextId = notification.userInfo[@"DetailTextIdKeyd"];
	
	[self.navigationController pushViewController:detail animated:YES];
	
	
}





@end