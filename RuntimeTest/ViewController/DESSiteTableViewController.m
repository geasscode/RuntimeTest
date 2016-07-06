//
//  DESSiteTableViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/7/6.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DESSiteTableViewController.h"
#import "DESSiteItemModel.h"
#import "ContentTableViewController.h"

@implementation DESSiteTableViewController



- (void)viewDidLoad {
	
	[super viewDidLoad];
	
}

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



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	DESSiteItemModel *model = self.itemModelArray[indexPath.row];
	
	model.didSelected = YES;
	model.count = @"";
	[self.tableView reloadData];
	ContentTableViewController *contentVc = [[ContentTableViewController alloc]init];
	contentVc.hidesBottomBarWhenPushed = YES;
	contentVc.title = model.name;
	NSString *urlstring = [NSString stringWithFormat:@"http://api.tuicool.com/api/sites/%@.json?size=30",model.id];
	NSLog(@"%@",urlstring);
	contentVc.urlstring = urlstring;
	[self.navigationController pushViewController:contentVc animated:YES];
	
}

@end
