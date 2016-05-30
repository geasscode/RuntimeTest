//
//  WeeklyItemStageDetatilController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/29.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "WeeklyItemStageDetatilController.h"
#import "WeeklyItemStageDetailModel.h"
#import "WeeklyItemStageCategoryDetail.h"
#include "StageCategoryDetailCell.h"
#import "CategoryDetailFrameModel.h"
#import "StageCategoryHeaderView.h"
#import "DetailViewController.h"
#define kStageDetailUrl @"http://api.tuicool.com/api/mag/detail.json?id=%@&type=%ld"

@interface WeeklyItemStageDetatilController ()
/**
 *  装有HZYWeeklyItemStageDetailModel 模型的数组
 */
@property (nonatomic ,strong) NSArray *stageDetailArray;
/**
 *  用于显示界面的左侧标题
 */
@property (nonatomic ,strong) UILabel *viewTitle;

@end

@implementation WeeklyItemStageDetatilController

- (NSArray *)stageDetailArray{
	
	if (_stageDetailArray == nil) {
		
		_stageDetailArray = [NSArray array];
	}
	
	return _stageDetailArray;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.tableView.sectionHeaderHeight = 40;
	
	//设置控制器只扩展底部
	self.edgesForExtendedLayout = UIRectEdgeBottom;
	
	[self setNav];
	
	[self getData];
	
}

- (void)setNav{
	
	self.viewTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 150, 44)];
	
	self.viewTitle.text = self.text;
	
	self.viewTitle.textColor = [UIColor whiteColor];
	
	[self.navigationController.view addSubview:self.viewTitle];
}

- (void)viewWillAppear:(BOOL)animated{
	
	[super viewWillAppear:animated];
	
	self.viewTitle.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
	
	[super viewWillDisappear:animated];
	
	self.viewTitle.hidden = YES;
}

- (void)getData{
	
	typeof (self) weakSelf = self;
	
	[WeeklyItemStageDetailModel stageDetailRequestURL:[NSString stringWithFormat:kStageDetailUrl,self.stageId,self.type] success:^(NSArray *array) {
		
		weakSelf.stageDetailArray = array;
		
		[weakSelf.tableView reloadData];
		[self.tableView.mj_header endRefreshing];

	}];
	

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	
	return self.stageDetailArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	WeeklyItemStageDetailModel *model = self.stageDetailArray[section];
	
	return model.items.count;
}

/**
 *  tableView返回section的头视图
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	
	StageCategoryHeaderView *header = [StageCategoryHeaderView headerViewWithTableView:tableView];
	
	header.detailModel = self.stageDetailArray[section];
	
	return header;
}

/**
 *  tableView返回cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	StageCategoryDetailCell *cell = [StageCategoryDetailCell cellWithTableView:tableView];
	
	WeeklyItemStageDetailModel *model = self.stageDetailArray[indexPath.section];
	
	cell.frameModel = model.items[indexPath.row];
	
	return cell;
}

/**
 *  tableView返回行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	WeeklyItemStageDetailModel *model = self.stageDetailArray[indexPath.section];
	
	CategoryDetailFrameModel *frameModel = model.items[indexPath.row];
	
	return frameModel.cellHeight;
}

///**
// *  设置sectionView跟随tableView滚动
// */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat sectionHeaderHeight = 40;
	if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
		scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
	}
	else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
		scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	DetailViewController *detail = [[DetailViewController alloc] init];
	
	WeeklyItemStageDetailModel *model = self.stageDetailArray[indexPath.section];
	
	CategoryDetailFrameModel *frameModel = model.items[indexPath.row];
	
	detail.detailTextId = frameModel.detailModel.url;
	
	[self.navigationController pushViewController:detail animated:YES];
	
}



@end
