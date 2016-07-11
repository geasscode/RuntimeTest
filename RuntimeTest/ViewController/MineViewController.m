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
#import "LoginViewController.h"
#define CELL_WIDTH self.view.bounds.size.width / 3

@interface MineViewController () <UIAlertViewDelegate>

/** 缓存弹出提示框 */
@property (nonatomic, strong) UIAlertView *alertView;

@property (nonatomic, strong) UIButton *backToTopBtn;


@end

@implementation MineViewController{
	
	User *user;
	
}

- (UICollectionView*)collectionView{
	if (!_collectionView) {
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		
		// 设置垂直间距
		flowLayout.minimumInteritemSpacing = 1;
		// 设置最小行间距
		flowLayout.minimumLineSpacing = 1;
		flowLayout.itemSize = CGSizeMake(CELL_WIDTH -1 , CELL_WIDTH -1);
		
		// 设置滚动方向（默认垂直滚动）
		//flowLayout = UICollectionViewScrollDirectionHorizontal;
		
		// 设置边缘的间距，默认是{0，0，0，0}
		//flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);

		
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, headBackgroundImage.frame.size.height , kScreenWidth, kScreenWidth) collectionViewLayout:flowLayout];
		
		//更严谨一点的方法加上NSStringFromClass
//	    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
		
		//纯代码无xib 注册 registerClass 方式
		[_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];


//		[_collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
		
		_collectionView.scrollEnabled = YES;
		_collectionView.backgroundColor = [UIColor clearColor];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		
		
//		_collectionView.showsHorizontalScrollIndicator = YES;
//		_collectionView.showsVerticalScrollIndicator = NO;
//		[_collectionView setBounces:NO];
	}
	return _collectionView;
//	return [self initWithCollectionViewLayout:flowLayout];

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return 9;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	[cell setImageForCellWithIndexPath:indexPath];
//	cell.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];

	
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
			
		
			self.dk_manager.themeVersion = DKThemeVersionNight;
			
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
		
		LoginViewController *loginVC = [LoginViewController new];
		[self.navigationController presentViewController:loginVC animated:YES completion:nil];
//		[self performSegueWithIdentifier:@"isLogin" sender:self];
	}
}

#pragma mark - life circle
- (void)viewDidLoad{
	[super viewDidLoad];
	
	
	
	[self backToTopUI];
	
	[self.view addSubview:self.collectionView];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserinfo:) name:@"WBAuthorSuccessfulNotification" object:nil];
//	self.collectionView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);

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


-(void)backToTopUI{
	self.backToTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	_backToTopBtn.frame = CGRectMake(kScreenWidth - 50, kScreenHeight - 200, 40, 40);
	_backToTopBtn.layer.cornerRadius = 20;
	_backToTopBtn.layer.borderColor = [UIColor blackColor].CGColor;
	_backToTopBtn.clipsToBounds = YES;
	_backToTopBtn.titleLabel.font = [UIFont systemFontOfSize:10];
	_backToTopBtn.hidden = YES;
	[_backToTopBtn setBackgroundImage:[UIImage imageNamed:@"go_top"] forState:UIControlStateNormal];
	[_backToTopBtn setTitle:@"回顶部" forState:UIControlStateNormal];
	[_backToTopBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[_backToTopBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
	[_backToTopBtn addTarget:self action:@selector(backToTopAction) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_backToTopBtn];

}

- (void)backToTopAction{
	
	self.collectionView.contentOffset = CGPointZero;
	_backToTopBtn.hidden = YES;
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
		
		LoginViewController *loginVC = [LoginViewController new];
		
		[self.navigationController presentViewController:loginVC animated:YES completion:nil];
		
		//未登录状态下进入登录页面
//		[self performSegueWithIdentifier:@"isLogin" sender:self];
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


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//	if ([segue.identifier isEqualToString:@"showDetail"])
//	{
//		NSIndexPath *selectedIndexPath = [self.collectionView indexPathsForSelectedItems][0];
//		
//		// load the image, to prevent it from being cached we use 'initWithContentsOfFile'
//		NSString *imageNameToLoad = [NSString stringWithFormat:@"%ld_full", (long)selectedIndexPath.row];
//		UIImage *image = [UIImage imageNamed:imageNameToLoad];
//		DetailViewController *detailViewController = segue.destinationViewController;
//		detailViewController.image = image;
//	}
//}

@end

