//
//  HomeViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/26.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "MyHomeViewController.h"
#import "HomeTableView.h"
#import "HomeTableViewCell.h"
#import "HomeViewModel.h"
#import "HomeModel.h"
#import "HomeDetailViewController.h"//详情页
#import "CustomerItem.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"





@interface MyHomeViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) HomeTableView *homeTableView;
@end

@implementation MyHomeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self setTitle:@"iOS头条"];
	
	self.dataArr=[NSMutableArray array];
	
	[self configNav];
	//布局View
	[self setUpView];
	//数据处理
	[self dataAccess];
}

- (void)configNav{
	UIButton *settingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
	[settingBtn setFrame:CGRectMake(0.0, 0.0, 23.0, 23.0)];
	[settingBtn setImage:[UIImage imageNamed:@"navigationbar_setting"] forState:UIControlStateNormal];
	[self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:settingBtn]];
}

#pragma mark - setUpView
- (void)setUpView{
	[self.view addSubview:self.homeTableView];
}

- (HomeTableView *)homeTableView{
	if (!_homeTableView) {
		_homeTableView=[[HomeTableView alloc]initWithFrame:self.view.bounds];
		[_homeTableView setDelegate:self];
		[_homeTableView setDataSource:self];
		[_homeTableView setRowHeight:80.0];
	}
	return _homeTableView;
}

#pragma mark DataAccess
- (void)dataAccess{
	HomeViewModel *homeViewModel=[[HomeViewModel alloc]init];
	
	__WeakSelf__ wSelf=self;
	[homeViewModel handleDataWithSuccess:^(NSArray *arr) {
		
		[wSelf.dataArr removeAllObjects];
		[wSelf.dataArr addObjectsFromArray:arr];
		dispatch_async(dispatch_get_main_queue(), ^{
			[wSelf.homeTableView reloadData];
		});
		
	} failure:^(NSError *error) {
		NSLog(@"请求失败 error:%@",error.description);
	}];
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.dataArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	HomeModel *model=self.dataArr[indexPath.row];
	HomeDetailViewController *homeDetailVC=[[HomeDetailViewController alloc]init];
	[homeDetailVC setNavTitle:model.newsTitle];
	[homeDetailVC setUrlStr:model.newsLink];
	[self.navigationController pushViewController:homeDetailVC animated:YES];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableView dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *cellIde=@"cellIde";
	HomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIde];
	if (!cell) {
		cell=[[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
	}
	
	[cell setData:self.dataArr[indexPath.row]];
	
	return cell;
}


//- setItem:(CustomerItem *)item
//{
//	_item = item;
// 
//	// 占位图片
//	UIImage *placeholder = [UIImage imageNamed:@"placeholderImage"];
// 
//	// 从内存\沙盒缓存中获得原图
//	UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.originalImage];
//	if (originalImage) { // 如果内存\沙盒缓存有原图，那么就直接显示原图（不管现在是什么网络状态）
//		[self.imageView sd_setImageWithURL:[NSURL URLWithString:item.originalImage] placeholderImage:placeholder];
//	} else { // 内存\沙盒缓存没有原图
//		AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
//		if (mgr.isReachableViaWiFi) { // 在使用Wifi, 下载原图
//			[self.imageView sd_setImageWithURL:[NSURL URLWithString:item.originalImage] placeholderImage:placeholder];
//		} else if (mgr.isReachableViaWWAN) { // 在使用手机自带网络
//			//     用户的配置项假设利用NSUserDefaults存储到了沙盒中
//			//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"alwaysDownloadOriginalImage"];
//			//    [[NSUserDefaults standardUserDefaults] synchronize];
//#warning 从沙盒中读取用户的配置项：在3G\4G环境是否仍然下载原图
//			BOOL alwaysDownloadOriginalImage = [[NSUserDefaults standardUserDefaults] boolForKey:@"alwaysDownloadOriginalImage"];
//			if (alwaysDownloadOriginalImage) { // 下载原图
//				[self.imageView sd_setImageWithURL:[NSURL URLWithString:item.originalImage] placeholderImage:placeholder];
//			} else { // 下载小图
//				[self.imageView sd_setImageWithURL:[NSURL URLWithString:item.thumbnailImage] placeholderImage:placeholder];
//			}
//		} else { // 没有网络
//			UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.thumbnailImage];
//			if (thumbnailImage) { // 内存\沙盒缓存中有小图
//				[self.imageView sd_setImageWithURL:[NSURL URLWithString:item.thumbnailImage] placeholderImage:placeholder];
//			} else {
//				[self.imageView sd_setImageWithURL:nil placeholderImage:placeholder];
//			}
//		}
//	}
//}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end

