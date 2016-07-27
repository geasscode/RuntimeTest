//
//  MyViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/5/30.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "MineViewController.h"
#import "MyCollectionViewCell.h"
#import "UserSettings.h"
#import "FavoriteTableViewController.h"
#import "SuggestViewController.h"
#import "LoginViewController.h"
#import "UpdatePasswordViewController.h"
#import <UIImageView+WebCache.h>

#define CELL_WIDTH self.view.bounds.size.width / 3

static NSString *const JDButtonName = @"JDButtonName";
static NSString *const JDButtonInfo = @"JDButtonInfo";
static NSString *const JDNotificationText = @"JDNotificationText";

@interface MineViewController () <UIAlertViewDelegate>

/** 缓存弹出提示框 */
@property (nonatomic, strong) UIAlertView *alertView;

@property (nonatomic, strong) UIButton *backToTopBtn;

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic,assign) NSUInteger currentIndex;

@end

@implementation MineViewController{
	
	UserSettings *user;
	
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

	//另一种跳转方式。
//	NSString *className = self.classNames[indexPath.row];
//	Class class = NSClassFromString(className);
//	if (class) {
//		UIViewController *ctrl = class.new;
//		ctrl.title = _titles[indexPath.row];
//		self.title = @" ";
//		[self.navigationController pushViewController:ctrl animated:YES];
//	}
	NSUInteger MineSetting  = indexPath.row;
	
	switch (MineSetting) {
		case UnRead:
			[self unReadConfig];
			break;
		case Favorite:
			[self favoriteConfig];
			break;
		case Theme:
			[self themeConfig];
			break;
		case Subscribe:
			[self subscribeConfig];
			break;
		case ChangePassword:
			[self changePasswordConfig];
			break;
		case CleanCache:
			[self cleanCacheConfig];
			break;
		case FeedBack:
			[self feedBackConfig];
			break;
		case AboutMe:
			[self aboutMeConfig];
			break;
		case ExitLogin:
			[self exitLoginConfig];
			break;
			
			//当在switch使用枚举类型时，’default’是不需要的
		default:{
			//[self performSegueWithIdentifier:@"isLogin" sender:self];
			[JDStatusBarNotification showWithStatus:@"该功能正在开发中。。。" dismissAfter:2.0
										  styleName:JDStatusBarStyleDark];
			LoginViewController *loginVC = [LoginViewController new];
			[self.navigationController presentViewController:loginVC animated:YES completion:nil];
		}
			break;
	}
	
}



- (void)unReadConfig{
	
	[self goToSpecifiedPage:@"ReaderListViewController"];

//	[JDStatusBarNotification showWithStatus:@"该功能正在开发中。。。" dismissAfter:2.0
//								  styleName:JDStatusBarStyleSuccess];
}

- (void)favoriteConfig{
	
	//			UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoadData" bundle:nil];
	//			FavoriteTableViewController *favorite = (FavoriteTableViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"myfavorite"];
	//			self.hidesBottomBarWhenPushed=YES;
	
	

	//			self.hidesBottomBarWhenPushed=NO;
	
	
//	FavoriteTableViewController *favorite = [FavoriteTableViewController new];
//	[self.navigationController pushViewController:favorite animated:YES];
	[self goToSpecifiedPage:@"FavoriteTableViewController"];

}

-(void)themeConfig{
	
//	[self night];
	[JDStatusBarNotification showWithStatus:@"该功能是整个app的灵魂正在策划中。" dismissAfter:2.0
								  styleName:JDStatusBarStyleSuccess];
}


- (void)normal {
	self.dk_manager.themeVersion = DKThemeVersionNormal;
}

- (void)night {
	self.dk_manager.themeVersion = DKThemeVersionNight;
}


-(void)subscribeConfig{
	//JDStatusBarStyleDark
	[JDStatusBarNotification showWithStatus:@"该功能正在开发中。。。" dismissAfter:2.0
								  styleName:JDStatusBarStyleMatrix];
}

-(void)changePasswordConfig{

//	UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoadData" bundle:nil];
//	UpdatePasswordViewController *changePassword = (UpdatePasswordViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"passwordVC"];
//	
//	[self.navigationController presentViewController:changePassword animated:YES completion:nil];
//	[self.navigationController pushViewController:changePassword animated:YES];
	
	[self goToSpecifiedPage:@"UpdatePasswordViewController"];


}

-(void)cleanCacheConfig{
	
	self.dk_manager.themeVersion = DKThemeVersionNight;
	[self cleanCache];
}

-(void)feedBackConfig{
	
//	__weak typeof(self)weakSelf = self;
//	[self xw_registerToInteractiveTransitionWithDirection:XWInteractiveTransitionGestureDirectionRight  transitonBlock:^(CGPoint startPoint){
//		[weakSelf goToSpecifiedPage:@"SuggestViewController"];
//	} edgeSpacing:0];
	
		[self goToSpecifiedPage:@"SuggestViewController"];

//	SuggestViewController *suggestVC = [SuggestViewController new];
//	[self.navigationController pushViewController:suggestVC animated:YES];
}



-(void)aboutMeConfig{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关于我们" message:@"我们是geasscode团队，专注开发iOS应用\n团队成员：geass \n邮   箱：sai3300@163.com" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
	[alert show];
}

-(void)exitLoginConfig{
	
	[AllUtils showPromptDialog:@"提示" andMessage:@"你真的要退出吗？" OKButton:@"确定" OKButtonAction:^(UIAlertAction *action) {
		//把用户名和密码设为nil；
		NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		[userDefaults setObject:nil forKey:@"username"];
		[userDefaults setObject:nil forKey:@"Password"];
		[userDefaults setObject:nil forKey:@"nickname"];
		[userDefaults setObject:nil forKey:@"userId"];
		
		[AccountTool deleteUserInfomation];

		//同时跳转到登录界面；
		[self goToSpecifiedPage:@"LoginViewController"];

//		LoginViewController *loginVC = [LoginViewController new];
//		[self.navigationController presentViewController:loginVC animated:YES completion:nil];
//		[AllUtils jumpToViewController:@"LoginViewController" contextViewController:self handler:nil];
	} cancelButton:@"取消" cancelButtonAction:^(UIAlertAction *action) {
		DESLog(@"取消");
	} contextViewController:self];
	
//	NSArray *data = @[@{JDButtonName:@"Show Notification", JDButtonInfo:@"JDStatusBarStyleDefault", JDNotificationText:@"Better call Saul!"},
//					  @{JDButtonName:@"Show Progress", JDButtonInfo:@"0-100% in 1s", JDNotificationText:@"Some Progress…"},
//					  @{JDButtonName:@"Show Activity Indicator", JDButtonInfo:@"UIActivityIndicatorViewStyleGray", JDNotificationText:@"Some Activity…"},
//					  @{JDButtonName:@"Dismiss Notification", JDButtonInfo:@"Animated", JDNotificationText:@""}];
	
//	[JDStatusBarNotification showWithStatus:@"系统繁忙，请稍后再试。"
//							   dismissAfter:2.0
//								  styleName:@"geass"];
	
}

- (void)addItem:(NSString *)title class:(NSString *)className image:(NSString *)imageName {
	
//	[self.titles addObject:title];
//	[self.classNames addObject:className];
//	[self.images addObject:[YYImage imageNamed:imageName]];
}


//- (void)selectedItemAtIndexPath:(NSIndexPath *)indexPath{

- (void)gotoLoginPage:(NSNotification*)notification{
	[self goToSpecifiedPage:@"LoginViewController"];
}
	
- (void)goToSpecifiedPage:(NSString *)pageName{
	
	//
	
//	__weak typeof(self)weakSelf = self;
//	[self xw_registerToInteractiveTransitionWithDirection:XWInteractiveTransitionGestureDirectionRight  transitonBlock:^(CGPoint startPoint){
//		[weakSelf xw_transition];
//	} edgeSpacing:0];
	


	XWCoolAnimator *animator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypeFoldFromRight];
	animator.toDuration = 1.0f;
	animator.backDuration = 1.0f;

		Class class = NSClassFromString(pageName);

		if (class) {
			UIViewController *ctrl = class.new;
//			ctrl.title = _titles[_currentIndex];
//			self.title = @" ";
			
			if([pageName isEqualToString:@"UpdatePasswordViewController"]){
				
				UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoadData" bundle:nil];
				UpdatePasswordViewController *changePassword = (UpdatePasswordViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"passwordVC"];
				
				[self xw_presentViewController:changePassword withAnimator:animator];

//				[self.navigationController presentViewController:changePassword animated:YES completion:nil];
				return;

			}
			
			if([pageName isEqualToString:@"LoginViewController"]){
				
				[self xw_presentViewController:ctrl withAnimator:animator];
//				[self.navigationController presentViewController:ctrl animated:YES completion:nil];
				return;
			}
			
			
//			[[NSNotificationCenter defaultCenter]postNotificationName:@"NavigationTitleNotification" object:nil userInfo:@{@"title":ctrl}];
			
			[self.navigationController xw_pushViewController:ctrl withAnimator:animator];
//			[self.navigationController pushViewController:ctrl animated:YES];
		}
}

#pragma mark - life circle
- (void)viewDidLoad{
	[super viewDidLoad];
	
	
//	self.titles = @[].mutableCopy;
//	self.classNames = @[].mutableCopy;
//	self.images = @[].mutableCopy;
//
//	[self addItem:@"Twitter" class:@"T1HomeTimelineItemsViewController" image:@"Twitter.jpg"];
//	[self addItem:@"Weibo" class:@"WBStatusTimelineViewController" image:@"Weibo.jpg"];
	[self notificationUI];
	[self backToTopUI];
	
	[self.view addSubview:self.collectionView];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserNameAndAvatar:) name:@"QQAuthorSuccessfulNotification" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserinfo:) name:@"WBAuthorSuccessfulNotification" object:nil];

	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserinfo:) name:@"WXAuthorSuccessfulNotification" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoLoginPage:) name:@"goToLoginPage" object:nil];
	


//	self.collectionView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);

	}





- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	[UIApplication sharedApplication].statusBarHidden = NO;
	self.navigationController.navigationBarHidden = YES;
	
	user = [AccountTool getUserInformation];
	
	if (user.name) {
		
		self.userNameLabel.text = user.name;
		
		[self.headImageView sd_setImageWithURL:[NSURL URLWithString:user.avatar_large]];
		
		if(user.hasLocalUser){
			//本地登录随便选个图片。暂时没有打算用户自己选择图片的功能。
			self.headImageView.image = [UIImage imageNamed:@"bg_headinmage"];
		}
		
		
	}else {
		
		self.userNameLabel.text = @"未登录";
		
		self.headImageView.image = [UIImage imageNamed:@"bg_headinmage"];
	}
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	self.tabBarController.tabBar.hidden = NO;
}


-(void)notificationUI{
	
	[JDStatusBarNotification addStyleNamed:@"geass"
								   prepare:^JDStatusBarStyle *(JDStatusBarStyle *style) {
									   style.barColor = [UIColor colorWithRed:0.056 green:0.478 blue:0.998 alpha:1.000];
									   style.textColor = [UIColor whiteColor];
									   style.animationType = JDStatusBarAnimationTypeBounce;
									   style.font = [UIFont fontWithName:@"Courier-Bold" size:14.0];
									   style.progressBarColor = [UIColor colorWithRed:0.986 green:0.062 blue:0.598 alpha:1.000];
									   style.progressBarHeight =40.0;
									   style.progressBarPosition = JDStatusBarProgressBarPositionTop;
									   return style;
								   }];
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
		
		UserSettings *user1 = [[UserSettings alloc] init];

		user1.id = [notification.userInfo[@"unionid"] integerValue];
		
		user1.name = notification.userInfo[@"nickname"];
		
		user1.gender = notification.userInfo[@"sex"];
		
		user1.avatar_large = notification.userInfo[@"headimgurl"];
		
		user1.userDescription = @"暂无个人介绍";
		
		[AccountTool saveUserInformation:user1];
//
		self.userNameLabel.text = user1.name;

		[self.headImageView sd_setImageWithURL:[NSURL URLWithString:user1.avatar_large]];
		
	}else {
		
		//保存登录信息
		UserSettings *user1 = [[UserSettings alloc] init];

		user1.id = [notification.userInfo[@"id"] integerValue];
		
		user1.name = notification.userInfo[@"name"];
		
		user1.userDescription = notification.userInfo[@"description"];
		
		user1.gender = notification.userInfo[@"gender"];
		
		user1.avatar_large = notification.userInfo[@"avatar_large"];
		
		[AccountTool saveUserInformation:user1];
//
		self.userNameLabel.text = user1.name;

		[self.headImageView sd_setImageWithURL:[NSURL URLWithString:user1.avatar_large]];
	}
}

- (void)updateUserNameAndAvatar:(NSNotification*)notification{
	//修改登录状态
	isLogin = YES;
	
	//qq 登录其实是qq空间登录，以下是返回的用户信息。
	//	"access_token" = 56D4EBBD6E20A7E4128EF054FCBDF59D;
	//	city = "";
	//	country = "\U9a6c\U5176\U987f";
	//	encrytoken = fa03dda5b1db48fcb53b9e75fdf499ae;
	//	"expires_in" = 7776000;
	//	figureurl = "http://thirdapp3.qlogo.cn/qzopenapp/b025b6dd00a560fc873e07a7763aa6cfdb9c090ebe66c828b7e05d02fcf095f6/50";
	//	gender = "\U7537";
	//	"is_lost" = 0;
	//	"is_yellow_high_vip" = 0;
	//	"is_yellow_vip" = 0;
	//	"is_yellow_year_vip" = 0;
	//	msg = "";
	//	nickname = Cloud;
	//	openid = 3A0075632368105EDEA1156E1BB44B78;
	//	"pay_token" = 53EA07B25A3249242BE08D441E0610B2;
	//	pf = "openmobile_ios";
	//	pfkey = 96163a92d1a0fdcd2843a14fcab6ddb5;
	//	province = "";
	//	ret = 0;
	//	"user_cancelled" = NO;
	//	"yellow_vip_level" = 0;
	
	//保存登录信息
	UserSettings *user1 = [[UserSettings alloc] init];
	
	user1.id = [notification.userInfo[@"openid"] integerValue];
	
	user1.name = notification.userInfo[@"nickname"];
	
	user1.userDescription = notification.userInfo[@"msg"];
	
	user1.gender = notification.userInfo[@"gender"];
	
	user1.avatar_large = notification.userInfo[@"figureurl"];
	
	[AccountTool saveUserInformation:user1];
	//
	self.userNameLabel.text = user1.name;
	
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:user1.avatar_large]];
	
}

#pragma mark - 点击个人头像后相应的操作
- (IBAction)loginButtonAction:(id)sender {
	
	if (user.name) {
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
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotoLoginPage" object:nil];

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

