//
//  ContentTableViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/5/12.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ContentTableViewController.h"
#import "ArticleModel.h"
#import "ArticleTool.h"
#import "DetailViewController.h"
#import "NewsTableViewCell.h"


@interface ContentTableViewController ()

//使用新语法限制在ArticleModel里。
@property (strong, nonatomic) NSMutableArray<ArticleModel *> * articleModelArray;

//@property (nonatomic,strong) NSMutableArray *articleModelArray;

@property (nonatomic,assign) BOOL islogin;

@end

@implementation ContentTableViewController

#pragma mark - 懒加载
-(NSMutableArray *)articleModelArray{
	
	if (_articleModelArray == nil) {
		_articleModelArray = [[NSMutableArray alloc]init];
	}
	return _articleModelArray;
}

#pragma mark - 视图生命周期方法
- (void)viewDidLoad {
	[super viewDidLoad];
	
	// self.islogin = [HZYUserLoginModel sharedUserLoginModel].isLogin;
	
	self.tableView.rowHeight = 73;
	
	self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		
		
		[self getData];
		[self.tableView.mj_header endRefreshing];
		
	}];
	
	self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
		
		[self footGetData];
		[self.tableView.mj_footer endRefreshing];
		
	}];
	
	[self getNetWorkstate];
	
	[self getData];
	
}
-(void)getNetWorkstate{
	
	//声明一个监控网络的变化的单例类
	AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
	
	[manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
		
		switch (status) {
			case AFNetworkReachabilityStatusUnknown: //未识别的网络
				
				break;
				
			case AFNetworkReachabilityStatusNotReachable:{ //网络未连接
				
				UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络不正常" message:@"当前无网络" preferredStyle:UIAlertControllerStyleAlert];
				UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
				[alert addAction:ac];
				[self presentViewController:alert animated:YES completion:nil];
				break;}
				
			case AFNetworkReachabilityStatusReachableViaWWAN: //数据连接（2,3,4G网络）
				
				break;
				
			case AFNetworkReachabilityStatusReachableViaWiFi: //WiFi网络
				
				
				break;
			default:
				break;
		}
		
	}];
	//开始监控
	[manager startMonitoring];
}


-(void)footGetData{
	
	ArticleModel *lastModel = [self.articleModelArray lastObject];
	
	NSDictionary *par = [[NSDictionary alloc]init];
	if (lastModel) {
		
		par = @{
				@"last_id":lastModel.articleId,
				@"last_time":lastModel.uts
				};
		
	}
	
	if (!self.urlstring) {
		return;
	}
	
	__weak typeof(self) weakself = self;
	[ArticleModel articleModelGetDataWithURLString:self.urlstring title:self.titlename parameters:nil successblack:^(NSArray *modelArray) {
		
		[weakself.articleModelArray  addObjectsFromArray:modelArray];
		
		[weakself.tableView reloadData];
		
	}];
	
	
	
}

-(void)getData{
	
	__weak typeof(self) weakself = self;
	AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
	
	//没有网络就加载缓存中的数据
	if (!manager.isReachable) {
		
		if ([self.titlename isEqualToString:@"热门"]) {
			
			[self.articleModelArray addObjectsFromArray:[ArticleTool Articalsback]];
			
			[self.tableView reloadData];
			
		}
		
	}else {
		
		if (!self.urlstring) {
			return;
		}
		//请求相应界面的数据
		[ArticleModel articleModelGetDataWithURLString:self.urlstring title:self.titlename parameters:nil successblack:^(NSArray *modelArray) {
			
			[weakself.articleModelArray removeAllObjects];
			[weakself.articleModelArray addObjectsFromArray:modelArray];
			
			[weakself.tableView reloadData];
			
		}];
	}
	
		[self.tableView.mj_header endRefreshing];

}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return self.articleModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	ArticleModel *model = self.articleModelArray[indexPath.row];
	
	NSInteger count = model.img.length;
	
	NewsTableViewCell *cell = [NewsTableViewCell cellWithTableView:tableView imageCount:count];
	
	cell.articleModel = model;
	
	return cell;
}

#pragma mark 按钮的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	
	ArticleModel *model = self.articleModelArray[indexPath.row];
	
	//在主界面点击进入详情
	if (self.navigationController) {
		
		DetailViewController *detail = [[DetailViewController alloc]init];
		
		detail.detailTextId = model.articleId;
		
		[self.navigationController pushViewController:detail animated:YES];
		
		
	}else{
		
		//在其他界面进入详情使用通知
		[[NSNotificationCenter defaultCenter]postNotificationName:@"ContentcellPushToDetailTextVCNotification" object:nil userInfo:@{@"DetailTextIdKeyd":model.articleId}];
		
	}
	
}
@end

