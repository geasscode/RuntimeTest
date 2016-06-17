//
//  MyViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/5/30.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "MineViewController.h"
#import "MyCollectionViewCell.h"
#import "User.h"
#import "FavoriteTableViewController.h"
#import "SuggestViewController.h"
#define CELL_WIDTH self.view.bounds.size.width / 3

@interface MineViewController () <UIAlertViewDelegate>

/** 缓存弹出提示框 */
@property (nonatomic, strong) UIAlertView *alertView;

@end

@implementation MineViewController{
	
	User *user;
	
}

- (UICollectionView*)collectionView{
	if (!_collectionView) {
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		flowLayout.minimumInteritemSpacing = 1;
		flowLayout.minimumLineSpacing = 1;
		flowLayout.itemSize = CGSizeMake(CELL_WIDTH -1 , CELL_WIDTH -1);
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, headBackgroundImage.frame.size.height , kScreenWidth, kScreenWidth) collectionViewLayout:flowLayout];
		[_collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
		_collectionView.scrollEnabled = YES;
		_collectionView.backgroundColor = [UIColor clearColor];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
	}
	return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return 9;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	[cell setImageForCellWithIndexPath:indexPath];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	
	
	if (user) {
		
		if (indexPath.row == 5) {
			
			[MBProgressHUD showHUDAddedTo:self.view animated:YES];
			
//			[[SDImageCache sharedImageCache] cleanDisk];
			
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
				
				[MBProgressHUD hideHUDForView:self.view animated:YES];
				
			});
		}else {
			
//			AboutZealerViewController *aboutZealerVC = [[AboutZealerViewController alloc] init];
//			[self.navigationController pushViewController:aboutZealerVC animated:YES];
		}
	}else {
		
		if(indexPath.row == 1){
			
//			UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoadData" bundle:nil];
//			FavoriteTableViewController *favorite = (FavoriteTableViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"myfavorite"];
//			self.hidesBottomBarWhenPushed=YES;
			FavoriteTableViewController *favorite = [FavoriteTableViewController new];
			[self.navigationController pushViewController:favorite animated:YES];
//			self.hidesBottomBarWhenPushed=NO;
			return;
		}
		
		else if (indexPath.row ==5){
			[self cleanCache];
			return;
		}
		
		else if (indexPath.row ==6){
			SuggestViewController *suggestVC = [SuggestViewController new];
			[self.navigationController pushViewController:suggestVC animated:YES];
			return;
		}
		
		else if (indexPath.row ==7){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关于我们" message:@"我们是geasscode团队，专注开发iOS应用\n团队成员：geass \n邮   箱：sai3300@163.com" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
			[alert show];
			return;

		}
		
		[self performSegueWithIdentifier:@"isLogin" sender:self];
	}
}

#pragma mark - life circle
- (void)viewDidLoad{
	[super viewDidLoad];
	
	[self.view addSubview:self.collectionView];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserinfo:) name:@"WBAuthorSuccessfulNotification" object:nil];
	
	}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	[UIApplication sharedApplication].statusBarHidden = NO;
	self.navigationController.navigationBarHidden = YES;
	
//	user = [AccountTool getUserInformation];
//	
//	if (user.name) {
//		
//		self.userNameLabel.text = user.name;
//		
//		[self.headImageView sd_setImageWithURL:[NSURL URLWithString:user.avatar_large]];
//	}else {
//		
//		self.userNameLabel.text = @"未登录";
//		
//		self.headImageView.image = [UIImage imageNamed:@"bg_headinmage"];
//	}
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - 更新授权后的个人信息
- (void)updateUserinfo:(NSNotification*)notification{
	//修改登录状态
	isLogin = YES;
	
	if ([notification.name isEqualToString:@"WXAuthorSuccessfulNotification"]) {
		
//		User *user1 = [[User alloc] init];
//		
//		user1.id = [notification.userInfo[@"unionid"] integerValue];
//		
//		user1.name = notification.userInfo[@"nickname"];
//		
//		user1.gender = notification.userInfo[@"sex"];
//		
//		user1.avatar_large = notification.userInfo[@"headimgurl"];
//		
//		user1.userDescription = @"暂无个人介绍";
//		
//		[AccountTool saveUserInformation:user1];
//		
//		self.userNameLabel.text = user1.name;
//		
//		[self.headImageView sd_setImageWithURL:[NSURL URLWithString:user1.avatar_large]];
		
	}else {
		
		//保存登录信息
//		User *user1 = [[User alloc] init];
//		
//		user1.id = [notification.userInfo[@"id"] integerValue];
//		
//		user1.name = notification.userInfo[@"name"];
//		
//		user1.userDescription = notification.userInfo[@"description"];
//		
//		user1.gender = notification.userInfo[@"gender"];
//		
//		user1.avatar_large = notification.userInfo[@"avatar_large"];
//		
//		[AccountTool saveUserInformation:user1];
//		
//		self.userNameLabel.text = user1.name;
//		
//		[self.headImageView sd_setImageWithURL:[NSURL URLWithString:user1.avatar_large]];
	}
}

#pragma mark - 点击个人头像后相应的操作
- (IBAction)loginButtonAction:(id)sender {
	
	if (user) {
		//登录状态下查看个人信息
//		UserInfoDetailViewController *userInfoDetailVC = [[UserInfoDetailViewController alloc] init];
//		
//		[self.navigationController pushViewController:userInfoDetailVC animated:YES];
	}else {
		
		//未登录状态下进入登录页面
		[self performSegueWithIdentifier:@"isLogin" sender:self];
	}
}


- (void)cleanCache{
	NSString *path = WNXCachesPath;
	NSFileManager *fileManager=[NSFileManager defaultManager];
	float folderSize;
	if ([fileManager fileExistsAtPath:path]) {
		//拿到算有文件的数组
		NSArray *childerFiles = [fileManager subpathsAtPath:path];
		//拿到每个文件的名字,如有有不想清除的文件就在这里判断
		for (NSString *fileName in childerFiles) {
			//将路径拼接到一起
			NSString *fullPath = [path stringByAppendingPathComponent:fileName];
			folderSize += [self fileSizeAtPath:fullPath];
		}
		
		self.alertView = [[UIAlertView alloc] initWithTitle:@"清理缓存" message:[NSString stringWithFormat:@"缓存大小为%.2fM,确定要清理缓存吗?", folderSize] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
		[self.alertView show];
		self.alertView.delegate = self;
	}
}


//计算单个文件夹的大小
-(float)fileSizeAtPath:(NSString *)path{
	
	NSFileManager *fileManager=[NSFileManager defaultManager];
	
	if([fileManager fileExistsAtPath:path]){
		
		long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
		return size/1024.0/1024.0;
	}
	return 0;
}

- (void)dealloc{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"WBAuthorSuccessfulNotification" object:nil];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXAuthorSuccessfulNotification" object:nil];
}


#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex) {
		//点击了确定,遍历整个caches文件,将里面的缓存清空
		NSString *path = WNXCachesPath;
		NSFileManager *fileManager=[NSFileManager defaultManager];
		if ([fileManager fileExistsAtPath:path]) {
			NSArray *childerFiles=[fileManager subpathsAtPath:path];
			for (NSString *fileName in childerFiles) {
				//如有需要，加入条件，过滤掉不想删除的文件
				NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
				[fileManager removeItemAtPath:absolutePath error:nil];
			}
		}
	}
	
	self.alertView = nil;
}

@end
