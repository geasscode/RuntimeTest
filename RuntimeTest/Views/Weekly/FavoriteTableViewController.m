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

@interface FavoriteTableViewController ()
@property (nonatomic, strong) UITableView *favoriteView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation FavoriteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.tabBarController.tabBar.hidden=YES;
	self.navigationController.navigationBarHidden = NO;

	self.view.backgroundColor = [UIColor whiteColor];
	self.navigationItem.title = @"我的收藏";

	//设置允许tableView编辑状态下允许多选
	self.tableView.allowsMultipleSelectionDuringEditing = YES;
	
	//将cell设置为可选择的风格

	[self configureLeftButton];
	[self readDataByDB];

	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"favorite"];
	self.tableView.tableFooterView  = [UITableView new];
	
	self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		
		
		[self readDataByDB];
		[self.tableView.mj_header endRefreshing];
		
	}];

	
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
	[self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 界面配置类
- (void)configureLeftButton {
	UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"qr_toolbar_more_hl"] style:UIBarButtonItemStylePlain target:self action:@selector(handleBack:)];
	self.navigationItem.leftBarButtonItem = left;
}

#pragma  mark - 数据类
- (void)readDataByDB {
	self.dataSource = [DBHelper getListData];
}



#pragma  mark - lazying load
- (NSMutableArray *)dataSource {
	if (!_dataSource) {
		self.dataSource = [NSMutableArray array];
	}
	return _dataSource;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
	return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favorite" forIndexPath:indexPath];
	DetailModel *model = self.dataSource[indexPath.row];
	cell.textLabel.text = model.title;
	return cell;
	
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
	DetailModel *model = self.dataSource[indexPath.row];
	[DBHelper deleteData:model.id];
	[self.dataSource removeObject:model];
	[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
	return @"删除";
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//	UIView *view = [[UIView alloc] init];
// view.backgroundColor = UIColorFromRGB(0xF6F6F6);
// self.tableView.selectedBackgroundView = view;
	DetailModel *model = self.dataSource[indexPath.row];
	DetailViewController *detail = [[DetailViewController alloc] init];
	detail.detailTextId = model.detatilArticleId;
	[self.navigationController pushViewController:detail animated:YES];
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
