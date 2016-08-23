//
//  MySubscribeViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/8/9.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "MySubscribeViewController.h"
#import "MySubscribeTitleCell.h"
#import "MySubscribeDetailContentCell.h"
#import "MySubscribeTitleAssociateCell.h"
#import "SubscribeModel.h"
#import "TopicModel.h"

#define SelectedTopic self.topicList[self.topicTableView.indexPathForSelectedRow.row]
//xib 记住File Owner 需要连线 View控件。不然出错会没任何提示。然后View 连线至 File Owner 绑定datasource 跟delegate。 最后将table控件 拉向对应代码区中tableView属性。
//复制xib，更改名字时记得将xib中残留的连向旧的属性删掉。

//cell中 xib 界面的identifier 一定要更注册时的identifier 一样，别忘记改。
//cell中 xib 界面的identifier 一定要更注册时的identifier 一样，别忘记改。
//cell中 xib 界面的identifier 一定要更注册时的identifier 一样，别忘记改。


@interface MySubscribeViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 左边的类别数据 */

@property (nonatomic , strong) NSArray *topicList;


/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *topicTableView;

/** 右边的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;

/** 请求参数 */
@property (nonatomic , strong) NSMutableDictionary *params;

/** AFN请求管理者 */
@property (nonatomic , strong) AFHTTPSessionManager *manager;

@end


@implementation MySubscribeViewController

static NSString * const SubscribeTitleID = @"subscribeTitleID";
static NSString * const SubscribeTitleAssociateID = @"subscribeTitleAssociateID";

- (void)loadTopicData
{
	
	self.topicList = @[@"NSHipster中文版",@"唐巧的技术博客",@"OneV's Den",@"sunnyxx的技术博客",@"码农周刊",@"jobble",@"里脊串的开发随笔",@"Casa Taloyum",@"NSHipster",@"叶孤城",@"小笨狼",@"Girl_iOS",@"cocoaChina",@"infoQ",@"dailyWeekly"];
	[self.topicTableView reloadData];
	[self.topicTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
	[self.feedTableView.mj_header beginRefreshing];

}

/**
 * 控件的初始化
 */
- (void)setupTableView
{
	// 注册
	


	

	[self.topicTableView registerNib:[MySubscribeTitleCell nib] forCellReuseIdentifier:SubscribeTitleID];

//	[self.topicTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MySubscribeTitleCell class]) bundle:nil] forCellReuseIdentifier:@"subscribeTitleID"];
	self.topicTableView.delegate = self;
	self.topicTableView.dataSource = self;
	
	[self.feedTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MySubscribeTitleAssociateCell class]) bundle:nil] forCellReuseIdentifier:SubscribeTitleAssociateID];
	self.feedTableView.delegate = self;
	self.feedTableView.dataSource = self;
	// 设置inset
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.topicTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
	self.feedTableView.contentInset = self.topicTableView.contentInset;
	self.feedTableView.rowHeight = 70;
	
	// 设置标题
	self.title = @"推荐关注";
	
	// 设置背景色
	//    self.view.backgroundColor = WYGlobalBg;
	
}

/**
 * 添加刷新控件
 */
- (void)setupRefresh
{
	self.feedTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
}

#pragma mark - 加载用户数据
- (void)loadNewUsers
{
	
	SubscribeModel *subModel =  self.topicList[self.topicTableView.indexPathForSelectedRow.row];
	
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"c"] = @"Iphone_37o_Manu";
	params[@"noParam"] = @"1";
	params[@"vs"] = @"iph370";
	params[@"interfaceVersion"] = @"1";
	self.params = params;
	
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// 左边的类别表格
	if(tableView == self.topicTableView){
	
	   return self.topicList.count;
	}
	return  8;
//	return [SelectedTopic subscribeItems].count;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(tableView == self.topicTableView)
	{
	
		MySubscribeTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:SubscribeTitleID];
		
		NSString * array = self.topicList[indexPath.row];
		cell.topic = self.topicList[indexPath.row];
		return cell;
	}
	else
	{
		MySubscribeTitleAssociateCell * cell = [tableView dequeueReusableCellWithIdentifier:SubscribeTitleAssociateID];
		
		cell.subscribeInfo = [SelectedTopic subscribeItems][indexPath.row];

		return cell;
	}
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(tableView == self.topicTableView){
		// 结束刷新
		
		[self.feedTableView.mj_header endRefreshing];
		
		TopicModel *model = self.topicList[indexPath.row];
		if(model.subscribeItems.count)
		{
			//显示曾经的数据
			[self.feedTableView reloadData];
		}
		else
		{
			// 赶紧刷新表格，马上显示当前category的用户数据，不让用户看见上一个category残留的数据
			[self.feedTableView reloadData];
			
			// 进入下拉刷新状态
//			[self.feedTableView.header beginRefreshing];
		}
		
	}
	else{
		 SubscribeModel *subModel = [SelectedTopic subscribeItems][indexPath.row];
		 NSLog(@"subscribeName:%@",subModel.subscribeName);
	}
}


- (void)viewDidLoad {
	[super viewDidLoad];
	
	// 控件初始化
	[self setupTableView];
	
	// 添加刷新控件
	[self setupRefresh];
	
	// 加载左侧类别数据
	
	[self loadTopicData];
}


#pragma mark - 控制器的销毁
- (void)dealloc
{
	// 停止所有操作
	[self.manager.operationQueue cancelAllOperations];
}

@end
