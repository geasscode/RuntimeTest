//
//  ReaderListViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/7/18.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ReaderListViewController.h"
#import "DetailModel.h"
#import "DBHelper.h"
#import "DetailViewController.h"



@interface ReaderListViewController ()

@end

@implementation ReaderListViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.tableView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	
	DetailModel *model = self.visibleResults[indexPath.row];
	DetailViewController *detail = [[DetailViewController alloc] init];
	
	detail.detailTextId = model.detatilArticleId;
	[self dismissViewControllerAnimated:YES completion:nil];
	//		[self.presentingViewController.navigationController pushViewController:detail animated:YES];
	[self.navigationController pushViewController:detail animated:YES];
	
}

@end

@interface ReaderListBaseViewController ()

@property (copy) NSArray *allResults;

@property (readwrite, copy) NSArray *visibleResults;

@end

@implementation ReaderListBaseViewController


- (void)viewDidLoad {
	
	[super viewDidLoad];


	[self configureTableViewUI];
	[self configureNavgationItem];
	self.allResults = [DBHelper getReaderList];
	self.visibleResults = self.allResults;
	

	
}


- (void)configureNavgationItem {
	
	self.tabBarController.tabBar.hidden=YES;
	self.navigationController.navigationBarHidden = NO;
	
	self.view.backgroundColor = [UIColor whiteColor];
	self.navigationItem.title = @"未读列表";
	
	UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backStretchBackgroundNormal"] style:UIBarButtonItemStylePlain target:self action:@selector(handleBack)];
	
	self.navigationItem.leftBarButtonItem = left;
	
	
	self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
	
}




- (void)configureTableViewUI{
	//设置允许tableView编辑状态下允许多选
	self.tableView.allowsMultipleSelectionDuringEditing = YES;
	
	//将cell设置为可选择的风格
	//还是用代码的方式注册cell 比较保险，防止莫名其妙的出现 unable to dequeue a cell with identifier，在storyboard cell 里写了有时也会出这个错。
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"readerList"];
	self.tableView.tableFooterView  = [UITableView new];
	//	self.tableView.tableHeaderView=self.searchBar;
	
	self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		
		//		[self readDataByDB];
		[self.tableView.mj_header endRefreshing];
		
	}];
	self.dk_manager.themeVersion = DKThemeVersionNight;
//	self.tableView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
	self.tableView.separatorColor = [UIColor darkGrayColor];
	//	self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);
	
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.visibleResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//	return [tableView dequeueReusableCellWithIdentifier:AAPLSearchControllerBaseViewControllerTableViewCellIdentifier forIndexPath:indexPath];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"readerList" forIndexPath:indexPath];
	DetailModel *model = self.visibleResults[indexPath.row];
	cell.textLabel.text = model.title;
	cell.textLabel.textColor = [UIColor colorWithRed:128 / 255.0 green:127 / 255.0 blue:125 / 255.0 alpha:1];
	cell.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
	return cell;
	
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	DetailModel *model = self.visibleResults[indexPath.row];
	cell.textLabel.text = model.title;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return  1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 60;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
	//	view.tintColor = [UIColor clearColor];
	
	view.tintColor = [UIColor redColor];
	
	
	//	改变文字的颜色：
	UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
	[footer.textLabel setTextColor:[UIColor whiteColor]];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
	//删除对应的单元格的数据
	DetailModel *model = self.visibleResults[indexPath.row];
	[DBHelper deleteReaderList:model.id];
	
	NSMutableArray *results =[[NSMutableArray alloc] init];
	[results addObjectsFromArray:self.allResults];
	[results removeObject:model];
	self.visibleResults = results;
	[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
	return @"删除";
}




- (void)handleBack {
	[self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}



@end
