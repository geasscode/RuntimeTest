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
	self.view.backgroundColor = [UIColor whiteColor];
	self.navigationItem.title = @"我的收藏";
	[self configureLeftButton];
	[self readDataByDB];

	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"favorite"];
	self.tableView.tableFooterView  = [UITableView new];
	
	self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		
		
		[self readDataByDB];
		[self.tableView.mj_header endRefreshing];
		
	}];

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
