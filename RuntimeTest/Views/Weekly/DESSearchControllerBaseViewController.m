//
//  DESSearchControllerBaseViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/6/22.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DESSearchControllerBaseViewController.h"
#import "DBHelper.h"
#import "DetailViewController.h"
#import "NewsViewController.h"
#import "DESSearchResultsViewController.h"

NSString *const DESSearchControllerBaseViewControllerTableViewCellIdentifier = @"searchCell";

@interface DESSearchControllerBaseViewController ()

@property (copy) NSArray *allResults;

@property (readwrite, copy) NSArray *visibleResults;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation DESSearchControllerBaseViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
	[super viewDidLoad];
	//如果父类有的话优先调用父类的方法，由于父类有个forCellReuseIdentifier:@"favorite" 造成 favorite 与 searchCell不匹配。就会提示
	//unable to dequeue a cell with identifier - must register a nib or a class for the identifier
	//请仔细检查，仔细检查，仔细检查。复制带来的bug。
	[self configureTableViewUI];
	[self configureNavgationItem];
	self.allResults = [DBHelper getListData];
	self.visibleResults = self.allResults;
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[self.tableView reloadData];
}

- (void)readDataByDB {
	self.visibleResults = [DBHelper getListData];
}

- (void)configureTableViewUI{
	//设置允许tableView编辑状态下允许多选
	self.tableView.allowsMultipleSelectionDuringEditing = YES;
	
	//将cell设置为可选择的风格
	//还是用代码的方式注册cell 比较保险，防止莫名其妙的出现 unable to dequeue a cell with identifier，在storyboard cell 里写了有时也会出这个错。
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"searchCell"];
	self.tableView.tableFooterView  = [UITableView new];
	//	self.tableView.tableHeaderView=self.searchBar;
	
	self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		
//		[self readDataByDB];
		[self.tableView.mj_header endRefreshing];
		
	}];
	self.dk_manager.themeVersion = DKThemeVersionNight;
	self.tableView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
	self.tableView.separatorColor = [UIColor darkGrayColor];
	//	self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);
	
}
- (void)configureNavgationItem {
	
	self.tabBarController.tabBar.hidden=YES;
	self.navigationController.navigationBarHidden = NO;
	
	self.view.backgroundColor = [UIColor whiteColor];
	self.navigationItem.title = @"我的收藏";
	
	UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backStretchBackgroundNormal"] style:UIBarButtonItemStylePlain target:self action:@selector(handleBack)];
	
	self.navigationItem.leftBarButtonItem = left;
	
	//系统自带的Barbutton 样式。
	UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchArtical)];
	
	self.navigationItem.rightBarButtonItem = right;
	
//	UISearchBar *searchView = [[UISearchBar alloc] init];
//	searchView.placeholder = @"搜索";
////	[searchView setDelegate:self];
//	[searchView setKeyboardType:UIKeyboardTypeDefault];
//	self.navigationItem.titleView = searchView;
//	
	self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
	
}

- (void)searchArtical{
	
	
	// Create the search results view controller and use it for the UISearchController.
	
	UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoadData" bundle:nil];
//	DESSearchResultsViewController *searchResultsController  = (DESSearchResultsViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"DESSearchResultsViewControllerStoryboardIdentifier"];
	
	DESSearchResultsViewController *searchResultsController  = [DESSearchResultsViewController new];
	
	//	DESSearchResultsViewController *searchResultsController = [self.storyboard instantiateViewControllerWithIdentifier:DESSearchResultsViewControllerStoryboardIdentifier];
	
	// Create the search controller and make it perform the results updating.
	self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
	self.searchController.searchResultsUpdater = searchResultsController;
	self.searchController.searchBar.delegate = searchResultsController;
	self.searchController.hidesNavigationBarDuringPresentation = NO;
//	self.definesPresentationContext = YES;

	// Present the view controller.

	[self.navigationController presentViewController:self.searchController animated:YES completion:nil];
	
	
}
- (void)handleBack {
	[self.navigationController popViewControllerAnimated:YES];
	//[self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - Property Overrides

- (void)setFilterString:(NSString *)filterString {
	_filterString = filterString;
	
	if (!filterString || filterString.length <= 0) {
		self.visibleResults = self.allResults;
	}
	else {
		
		//也可以用title beginswith
		NSPredicate *predicate =[NSPredicate predicateWithFormat:@"title contains[c] %@", filterString];
		
		NSMutableArray *filterResults =[[NSMutableArray alloc] init];
		filterResults = [[self.allResults filteredArrayUsingPredicate:predicate] mutableCopy];
		NSLog(@"predicate  = %@ -------  filter=%@",predicate,filterResults);
		self.visibleResults = filterResults;

		//自己不会宁可在网上找到更好的方法也不用下面看起来就过时，low的方法。
//		NSMutableArray *tempResults = [NSMutableArray array];
//		NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
//
//		for (int i = 0; i < self.allResults.count; i++) {
//			NSString *storeString = [(DetailModel *)self.allResults[i] title];
//			NSRange storeRange = NSMakeRange(0, storeString.length);
//			NSRange foundRange = [storeString rangeOfString:filterString options:searchOptions range:storeRange];
//			if (foundRange.length) {
//				NSDictionary *dic=@{@"name":storeString};
//				
//				[tempResults addObject:dic];
//			}
//			
//		}
//		
////		[_visibleResults removeAllObjects];
//		[self.allResults addObjectsFromArray:tempResults];
//		NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"self contains[c] %@", filterString];
//		self.visibleResults = [self.allResults filteredArrayUsingPredicate:filterPredicate];
	}
	
	[self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.visibleResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//	return [tableView dequeueReusableCellWithIdentifier:AAPLSearchControllerBaseViewControllerTableViewCellIdentifier forIndexPath:indexPath];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
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

//改变UITableView的header、footer背景颜色，这是个很常见的问题。之前知道的一般做法是，通过实现tableView: viewForHeaderInSection:返回一个自定义的View，里面什么都不填，只设背景颜色。但是今天发现一个更简洁的做法。

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
	[DBHelper deleteData:model.id];
	
	NSMutableArray *results =[[NSMutableArray alloc] init];
	[results addObjectsFromArray:self.allResults];
	[results removeObject:model];
	self.visibleResults = results;
	[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
	return @"删除";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	[self.searchController.searchBar becomeFirstResponder];
	
	
	if ([self.searchController isActive]) {
		[self.searchController setActive:NO];
	} else {
		
		DetailModel *model = self.visibleResults[indexPath.row];
		DetailViewController *detail = [[DetailViewController alloc] init];
		
		detail.detailTextId = model.detatilArticleId;
		
//		[self.presentingViewController.navigationController pushViewController:detail animated:YES];

	   [self.navigationController pushViewController:detail animated:YES];
	}

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	
	
	[self.searchController.searchBar becomeFirstResponder];
	
	
	if ([self.searchController isActive]) {
		[self.searchController setActive:NO];
	} else {
		
		DetailModel *model = self.visibleResults[0];
		DetailViewController *detail = [[DetailViewController alloc] init];
		detail.detailTextId = model.detatilArticleId;
		[self.navigationController pushViewController:detail animated:YES];
	}


}





@end
