// GlobalTimelineViewController.m
//
// Copyright (c) 2011–2016 Alamofire Software Foundation ( http://alamofire.org/ )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "GlobalTimelineViewController.h"

#import "Post.h"
#import "PostTableViewCell.h"
#import "AFNetworking.h"
////#import <AFNetworking/AFNetworking.h>
#import <UIRefreshControl+AFNetworking.h>
#import "ViewController.h"
#import "loadXIBFile.h"

@interface GlobalTimelineViewController ()
@property (readwrite, nonatomic, strong) NSArray *posts;
//@property ( nonatomic, strong) UIViewController *vc;

@end

@implementation GlobalTimelineViewController


//当我们用到控制器view时，就会调用控制器view的get方法，在get方法内部，首先判断view是否已经创建，
//如果已存在，则直接返回存在的view，如果不存在，则调用控制器的loadView方法，在控制器没有被销毁的情况下，loadView也可能会被执行多次

- (void)reload:(__unused id)sender {
	self.navigationItem.rightBarButtonItem.enabled = NO;
	
	NSURLSessionTask *task = [Post globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
		NSLog(@"call block return here");
		if (!error) {
			self.posts = posts;
			[self.tableView reloadData];
		}
	}];
	
	[self.refreshControl setRefreshingWithStateOfTask:task];
}

#pragma mark - UIViewController


//1.控制器view的生命周期：viewDidLoad -> viewWillAppear -> viewWillLayoutSubviews -> viewDidLayoutSubviews
//-> viewDidAppear -> viewWillDisappear -> viewDidDisappear
//
//2.内存警告传递过程:手机内存不足产生事件->通知应用程序->调用应用程序代理方法->把事件传递给窗口->窗口传给控制器->调用控制器的内存警告方法


//当控制器的loadView方法执行完毕，view被创建成功后，就会执行viewDidLoad方法，该方法与loadView方法一样，
//也有可能被执行多次。

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = NSLocalizedString(@"AFNetworking", nil);
	
	//	self.vc = [ViewController new];
	
	self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 100.0f)];
	[self.refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
	[self.tableView.tableHeaderView addSubview:self.refreshControl];
	
	self.tableView.rowHeight = 70.0f;
	
	[self reload:nil];
}


- (void)loadView {
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	NSLog(@"viewWillAppear");
}


- (void)injected
{
	NSLog(@"I've been injecteds: %@", self);
}

#pragma mark - UITableViewDataSource



/** 全屏分割线
 *  分割线补上开头空15像素点的，即一条直线从0开始到结束，用到viewDidLayoutSubviews以及willDisplayCell方法。
 */
-(void)viewDidLayoutSubviews
{
	//调整(iOS7以上)表格分隔线边距
	//在iOS7之前系统默认就是全屏的,iOS7时UITableView多了separatorInset属性,
	if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
		self.tableView.separatorInset = UIEdgeInsetsZero;
		//		[self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
	}
	
	//调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
	if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
		//[self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
		self.tableView.layoutMargins = UIEdgeInsetsZero;
		
	}
}
//也可以写在cellForRowAtIndexPath里。
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
	
	//	懒得写if可以直接
	//	cell.layoutMargins = UIEdgeInsetsZero;
	//	cell.separatorInset = UIEdgeInsetsZero;
	
	if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
		[cell setSeparatorInset:UIEdgeInsetsZero];
	}
	if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
		[cell setLayoutMargins:UIEdgeInsetsZero];
	}
}

//self.tableView.estimatedRowHeight = 68.0;
//self.tableView.rowHeight = UITableViewAutomaticDimension;
//配合约束可以动态的计算cell的高度
//然后在cell上放上一个label，讲label的numberOfLines属性设置为0，
//然后设置好label的上下左右约束，然后再对label的内容进行赋值，再次运行你的程序，
//这个时候你的cell就会动态的显示高度了，label的高度取决于你的内容的多少，同时按照你的约束进行显示。

//很多地方都可以用[tableView beginUpdates]来代替[tableView reloadData]来达到更好的效果.

- (NSInteger)tableView:(__unused UITableView *)tableView
 numberOfRowsInSection:(__unused NSInteger)section{
	
	return (NSInteger)[self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	
	PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[PostTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
	
	cell.post = self.posts[(NSUInteger)indexPath.row];
	
	return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark -UIScrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
				  willDecelerate:(BOOL)decelerate {
	//	NSSet *visiblecells = [NSSet setWithArray:[self.contextView indexPathsForVisibleRows]];
	//	[_set minusSet:visiblecells];
	//
	//	for (NSIndexPath *anIndexPath in _set) {
	//		UITableViewCell *cell = [self.contextView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:anIndexPath];
	//		NSLog(@"%@不在唱歌", cell.textLabel.text);
	//	}
}

- (CGFloat)tableView:(__unused UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [PostTableViewCell heightForCellWithPost:self.posts[(NSUInteger)indexPath.row]];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	/*** 常用跳转方法总结
	 第一种：通过tabBar跳转：
	 UITabBarController *tabbarVC = [[ UITabBarController alloc ] init ];
	 FirstViewController *FVC = [[FirstViewController ] init ];
	 FVC.tabBarItem.title = @"控制器1" ;
	 FVC.tabBarItem.image = [ UIImage imageNamed : @"first.png" ];
	 SecondViewController *SVC = [[SecondViewController ] init ];
	 SVC.tabBarItem.title = @"控制器2" ;
	 SVC. tabBarItem.image = [UIImage imageNamed : @"new.png" ];
	 // 添加子控制器（这些子控制器会自动添加到UITabBarController的 viewControllers 数组中）
	 [tabbarVC addChildViewController :FVC];
	 [tabbarVC addChildViewController :SVC];
	 
	 第二种：通过navigationController跳转：
	 [self.navigationController pushViewController:newC animated:YES]; //跳转到下一页面
	 [self.navigationController popViewControllerAnimated:YES]; //返回上一页面
	 [ self .navigationController popToRootViewControllerAnimated: YES ];  //返回根控制器,即最开始的页面
	 
	 第三种：利用modal跳转
	 [ self presentViewController:SVC animated: YES completion:nil];
	 [ self dismissViewControllerAnimated: YES completion: nil ];
	 ***/
	
	
	//	ViewController *vcB = [self.storyboard instantiateViewControllerWithIdentifier:@"TestUIViewController"];
	//
	//	[vcB setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	//	[viewControllerA presentModalViewController:(UIViewController *)vcB animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	//第四种：storyboard跳转。
	
	//	NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
	//
	//	UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	//
	//	//以下两种方法都行。
	//	ViewController *viewController = [mainStoryBoard instantiateInitialViewController];
	////	ViewController *viewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TestUIViewController"];
	//	[self.navigationController pushViewController:viewController animated:YES];
	
	
	//	storyboard加载的是控制器及控制器view，而xib加载的仅仅只是控制器的view，storyboard会调用控制器的awakeFromNib方法
	//而xib不会。
	
	//另一种初始化storyboard方式：
	//	-(instancetype)init{
	//
	//		if (self = [super init]) {
	//
	//			UIStoryboard *story = [UIStoryboard storyboardWithName:@"YLWUserLoginController" bundle:nil];
	//			self = [story instantiateInitialViewController];
	//		}
	//		return self;
	//
	//	}
	
	//present方式适合弹出modal
	//	[self presentViewController:[mainStoryBoard instantiateInitialViewController] animated:YES completion:nil];
	
	//	//跳转到xib
	
	//	iOS button press causes "unrecognized selector sent to instance" 线连对了，Controller 写错了，Controller是loadXIB
	//		UIViewController *xibTest= [[UIViewController alloc]initWithNibName:@"loadXIBFile" bundle:nil];
	
	//不指定xib名字方式。loadView就会加载与控制器同名的xib（loadXIBFile.xib）
	//	当没有指定xib名称，且没有与控制器同名的xib时，会加载前缀与控制器名相同而不带controller的xib（loadXIB.xib）
	//	如果loadXIB 也删掉就会加载不到显示黑屏，则创建一个空白的xib
	loadXIBFile *xibTest = [[loadXIBFile alloc] init];
	
	[self.navigationController pushViewController:xibTest animated:YES];
	
	
	
}

@end
