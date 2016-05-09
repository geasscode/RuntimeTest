//
//  AppDelegate.m
//  RuntimeTest
//
//  Created by desmond on 16/3/17.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "AppDelegate.h"
#import "GlobalTimelineViewController.h"
#import "Store.h"
#import <AFNetworking/AFNetworking.h>
#import "OpenShareHeader.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "DESTabBarController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

//设置LaunchScreen url 如果不生效需要将app删除重新装。
//http://blog.csdn.net/riven_wn/article/details/49275157
//1、application didFinishLaunchingWithOptions：当应用程序启动时执行，应用程序启动入口，只在应用程序启动时执行一次。若用户直接启动，lauchOptions内无数据,若通过其他方式启动应用，lauchOptions包含对应方式的内容。
//2、applicationWillResignActive：在应用程序将要由活动状态切换到非活动状态时候，要执行的委托调用，如 按下 home 按钮，返回主屏幕，或全屏之间切换应用程序等。
//3、applicationDidEnterBackground：在应用程序已进入后台程序时，要执行的委托调用。
//4、applicationWillEnterForeground：在应用程序将要进入前台时(被激活)，要执行的委托调用，刚好与applicationWillResignActive 方法相对应。
//5、applicationDidBecomeActive：在应用程序已被激活后，要执行的委托调用，刚好与applicationDidEnterBackground 方法相对应。
//6、applicationWillTerminate：在应用程序要完全推出的时候，要执行的委托调用，这个需要要设置UIApplicationExitsOnSuspend的键值。



//初次启动：
//iOS_didFinishLaunchingWithOptions
//iOS_applicationDidBecomeActive
//按下home键：
//iOS_applicationWillResignActive
//iOS_applicationDidEnterBackground
//点击程序图标进入：
//iOS_applicationWillEnterForeground
//iOS_applicationDidBecomeActive
@synthesize store = _store;

- (Store *)store
{
	if (_store == nil) {
		_store = [Store store];
	}
	return _store;
}

+ (instancetype)sharedDelegate
{
	return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	//第一步：注册key
	[OpenShare connectQQWithAppId:@"1103194207"];
	[OpenShare connectWeiboWithAppKey:@"402180334"];
	[OpenShare connectWeixinWithAppId:@"wxd930ea5d5a258f4f"];
	
	
	//RuntimeTableViewController 有关于tableView的用法。
//	屏蔽掉除电池电量的各种状态，需要再info.plist 指定 View controller-based status bar appearance  BOOL值设为NO
//	就是把控制器控制状态栏的权限给禁了，用UIApplication来控制。但是这种做法在iOS9不建议使用了，
//	建议我们使用吧那个BOOL值设为YES，然后用控制器的方法来管理状态栏
	[application setStatusBarStyle:UIStatusBarStyleLightContent];
//	[NSThread sleepForTimeInterval:3.0];//设置启动页面时间

	NSLog(@"execute didFinishLaunchingWithOptions");
	// Override point for customization after application launch.
	NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
	[NSURLCache setSharedURLCache:URLCache];
	
	[[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
	
	self.window = [[UIWindow alloc] init];
	self.window.frame = [UIScreen mainScreen].bounds;
	self.window.rootViewController = [[DESTabBarController alloc] init];
	[self.window makeKeyAndVisible];
	
	
	
//	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
//	UITableViewController *viewController = [[GlobalTimelineViewController alloc] initWithStyle:UITableViewStylePlain];
//	viewController.tableView = tableView;
//	self.navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
//	self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
//	
//	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//	self.window.backgroundColor = [UIColor whiteColor];
//	self.window.rootViewController = self.navigationController;
//	[self.window makeKeyAndVisible];

	return YES;
}


//- (UIStatusBarStyle)preferredStatusBarStyle {
//
//	//ios 9 使用此方法。后将View controller-based status bar appearance  BOOL值设为YES
//	
//	return UIStatusBarStyleLightContent;
//	
//}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	NSLog(@"execute applicationWillResignActive");

}

//当应用程序进入后台时,应该保存用户数据或状态信息，所有没写到磁盘的文件或信息，
//在进入后台时，最后都写到磁盘去，因为程序可能在后台被杀死。释放尽可能释放的内存。
//方法有大概5秒的时间让你完成这些任务。如果超过时间还有未完成的任务，你的程序就会被终止而且从内存中清除。
- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	
	NSLog(@"execute applicationDidEnterBackground");
	
//	如果还需要长时间的运行任务，可以在该方法中调用
//	[application beginBackgroundTaskWithExpirationHandler:^{
//		
//		NSLog(@"begin Background Task With Expiration Handler");
//		
//	}];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	NSLog(@"execute applicationWillEnterForeground");

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	NSLog(@"execute applicationDidBecomeActive");
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	NSLog(@"execute applicationWillTerminate");

	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
	if ([OpenShare handleOpenURL:url]) {
		return YES;
	}
	//这里可以写上其他OpenShare不支持的客户端的回调，比如支付宝等。
	return YES;
}

@end
