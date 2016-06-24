//
//  FavoriteTableViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/5/16.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "FavoriteTableViewController.h"
#import "DBHelper.h"
#import "FavoriteCell.h"
#import "DetailViewController.h"
#import "DESSearchResultsViewController.h"

@interface FavoriteTableViewController ()<UISearchBarDelegate,UISearchDisplayDelegate>
@property (nonatomic, strong) UITableView *favoriteView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UISearchBar *searchBar;//搜索框
@property (nonatomic, strong) UISearchController *searchController;


@end

@implementation FavoriteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
//	[self configureTableViewUI];
	//[self configureNavgationItem];
//	[self readDataByDB];

	self.tableView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);

//	* nil是OC的，空对象，地址指向空（0）的对象。对象的字面零值
//	
//	* Nil是Objective-C类的字面零值
//	
//	* NULL是C的，空地址，地址的数值是0，是个长整数
//	
//	* NSNull用于解决向NSArray和NSDictionary等集合中添加空值的问题
//	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"favorite"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)searchArtical{
//
//	
//	// Create the search results view controller and use it for the UISearchController.
//	
//	UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoadData" bundle:nil];
//	DESSearchResultsViewController *searchResultsController  = (DESSearchResultsViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"DESSearchResultsViewControllerStoryboardIdentifier"];
//
////	DESSearchResultsViewController *searchResultsController = [self.storyboard instantiateViewControllerWithIdentifier:DESSearchResultsViewControllerStoryboardIdentifier];
//	
//	// Create the search controller and make it perform the results updating.
//	self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
//	self.searchController.searchResultsUpdater = searchResultsController;
//	self.searchController.hidesNavigationBarDuringPresentation = NO;
//	// Present the view controller.
//	[self presentViewController:self.searchController animated:YES completion:nil];
//
//	
//}
//- (void)handleBack {
//	[self.navigationController popViewControllerAnimated:YES];
//	//[self.navigationController popToRootViewControllerAnimated:YES];
//}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//	
//	//self.visibleResults.count
//	return self.dataSource.count;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//	
//	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favorite" forIndexPath:indexPath];
//	DetailModel *model = self.dataSource[indexPath.row];
//	cell.textLabel.text = model.title;
//	cell.textLabel.textColor = [UIColor colorWithRed:128 / 255.0 green:127 / 255.0 blue:125 / 255.0 alpha:1];
//	cell.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
//	return cell;
//	
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//	return  1;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//	return 60;
//}
//
////改变UITableView的header、footer背景颜色，这是个很常见的问题。之前知道的一般做法是，通过实现tableView: viewForHeaderInSection:返回一个自定义的View，里面什么都不填，只设背景颜色。但是今天发现一个更简洁的做法。
//
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
////	view.tintColor = [UIColor clearColor];
//	
//	view.tintColor = [UIColor redColor];
//
//	
////	改变文字的颜色：
//	UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
//	[footer.textLabel setTextColor:[UIColor whiteColor]];
//}
//
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//	//删除对应的单元格的数据
//	DetailModel *model = self.dataSource[indexPath.row];
//	[DBHelper deleteData:model.id];
//	[self.dataSource removeObject:model];
//	[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//}
//
//-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//	return @"删除";
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//	UIView *view = [[UIView alloc] init];
// view.backgroundColor = UIColorFromRGB(0xF6F6F6);
// self.tableView.selectedBackgroundView = view;
//	DetailModel *model = self.dataSource[indexPath.row];
	DetailModel *model = self.visibleResults[indexPath.row];

	DetailViewController *detail = [[DetailViewController alloc] init];
	detail.detailTextId = model.detatilArticleId;
	[self.navigationController pushViewController:detail animated:YES];
}


@end
