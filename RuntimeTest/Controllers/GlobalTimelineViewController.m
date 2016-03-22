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
#import <AFNetworking/AFNetworking.h>
#import <UIRefreshControl+AFNetworking.h>
#import "ViewController.h"

@interface GlobalTimelineViewController ()
@property (readwrite, nonatomic, strong) NSArray *posts;
//@property ( nonatomic, strong) UIViewController *vc;

@end

@implementation GlobalTimelineViewController

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


- (void)injected
{
	NSLog(@"I've been injecteds: %@", self);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(__unused UITableView *)tableView
 numberOfRowsInSection:(__unused NSInteger)section
{
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
	
	NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);

//	UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	
	
	//导航方式
//	ViewController *viewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TestUIViewController"];
//	[self.navigationController pushViewController:viewController animated:YES];
	
	//present方式适合弹出modal
//	[self presentViewController:[mainStoryBoard instantiateInitialViewController] animated:YES completion:nil];
	
	//跳转到xib
	UIViewController *xibTest= [[UIViewController alloc]initWithNibName:@"loadXIBFile" bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:xibTest animated:YES];
	

	
}

@end
