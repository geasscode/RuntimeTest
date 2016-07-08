//
//  DESBaseTableViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/7/6.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DESBaseTableViewController.h"
#import "DESSiteItemModel.h"
#import "DESSiteItemTableViewCell.h"

@interface DESBaseTableViewController ()



@end

@implementation DESBaseTableViewController



-(BOOL)isLogin{
	
//	return [[YLWUserLoginModel sharedUserLoginModel] isLogin];
	return YES;
	
}

-(NSArray *)itemModelArray{
	
	if (_itemModelArray == nil) {
		_itemModelArray = [[NSArray alloc]init];
	}
	return _itemModelArray;
	
}


-(UIButton *)footView{
	
	if (_footView == nil) {
		_footView = [[UIButton alloc]init];
		//        _footView.backgroundColor = [UIColor redColor];
		_footView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
		
		[_footView setTitle:@"+ 订阅更多站点" forState:UIControlStateNormal];
		
		_footView.titleLabel.font = [UIFont systemFontOfSize:13];
		
		[_footView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
		
		
		[_footView addTarget:self action:@selector(moreSiteClick) forControlEvents:UIControlEventTouchUpInside];
		
		
	}
	return _footView;
}

-(void)moreSiteClick{
	
	NSLog(@"获得更多站点");
	
}



- (void)viewDidLoad {
	
	[super viewDidLoad];
	
//	[self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DESSiteItemTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"SiteCellIdentifier"];
	
	//注册系统自带的cell
//	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SiteCellIdentifier"];

	
	//默认使用上面那个省略下面这行，但是有自定义style 还是使用这个。
	//	if (cell == nil) {
	//		cell= [[DESSiteItemTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SiteCellIdentifier"];
	//	}
	//

	[self setNav];
	
	[self getSiteData];
	
	self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		
		[self getSiteData];
		[self.tableView.mj_header endRefreshing];
		
	}];
	
}


#pragma mark - 设置导航栏
/**
 *  设置导航栏
 */
-(void)setNav{
	
	
	UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"more1"] style:UIBarButtonItemStylePlain target:self action:@selector(moreBtn)];
	
	
	self.navigationItem.rightBarButtonItem = rightItem;
	
	self.navigationItem.leftBarButtonItem = nil;
	
}

#pragma mark 导航栏更多(右侧)按钮
/**
 *  导航栏更多(右侧)按钮
 */
-(void)moreBtn{
	
	
	
}

#pragma mark 获取数据
/**
 *  获取站点的数据
 */
-(void)getSiteData{
	
	__weak typeof(self) weakself = self;
	[DESSiteItemModel siteItemModelWithURLstring:@"http://api.tuicool.com/api/sites/user_default.json" lastArray:(NSArray *)self.itemModelArray  successblock:^(NSArray *itemArray) {
		
		weakself.itemModelArray = itemArray;
		[weakself.tableView reloadData];
		weakself.tableView.tableFooterView = weakself.footView;
		
	}];
	
	
	
}




- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return self.itemModelArray.count;
	
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	DESSiteItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SiteCellIdentifier"];
	
	if (cell == nil) {
		cell= [[DESSiteItemTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SiteCellIdentifier"];
	}
	
	
	DESSiteItemModel *model = self.itemModelArray[indexPath.row];
	
	cell.siteItemModel = model;
	
	return cell;
}

@end
