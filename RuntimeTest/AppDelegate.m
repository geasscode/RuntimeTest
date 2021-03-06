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
#import "APOpenAPI.h"
#import "LaunchAnimationViewController.h"
#import "AdvertiseView.h"
#import "AdvertiseViewController.h"
#import "CBIconfont.h"
#import "LoginViewController.h"

//检测内存泄露。
#import "PLeakSniffer.h"


#define weiboAppKey @"4003638958"
#define appkey @"12f1847875e26"
#define app_secrect @"69471e44e59a7d4bcf068d7b7329d9c8"
#define kRedirectURL @"https://api.weibo.com/oauth2/default.html"
#define weibo_app_secrect @"bd1df8265cc8ffd8db0d69a5501b174a"

@interface AppDelegate ()<WXApiDelegate>

@end


static AppDelegate *appdelegate;

@implementation AppDelegate

+ (AppDelegate*)sharedAppdelegate {
	
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		
		appdelegate = [[AppDelegate alloc] init];
	});
	return appdelegate;
	
}

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



//多语言设置
//当某些库做了多语言，你显示的是只有英文的时候,你需要手动添加中文简体：
//选中Project 然后 选中Info 栏 ，在Locallizations 里添加中文即可。
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

//另一种获取uuid 方式 在VKKeychainIDFV里。
//NSString * uuid = [UIDevice VKKeychainIDFV];

//open url 形式打开网站，请参考 github的VKURLAction
//demo://nativeOpenUrl/openWeb?title=webView&url=http%3A%2F%2Fawhisper.github.io&sign=029505c3be619a88fd0a4ea99932b5cb
- (void)umengTrack {
	
	//设备识别信息
	Class cls = NSClassFromString(@"UMANUtil");
	SEL deviceIDSelector = @selector(openUDIDString);
	NSString *deviceID = nil;
	if(cls && [cls respondsToSelector:deviceIDSelector]){
		deviceID = [cls performSelector:deviceIDSelector];
	}
	NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
													   options:NSJSONWritingPrettyPrinted
														 error:nil];
	
	NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
	
	
	//    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
	[MobClick setLogEnabled:YES];
	UMConfigInstance.appKey = @"5768b29be0f55a3b24002ff2";
//	UMConfigInstance.secret = @"secretstringaldfkals";
	//    UMConfigInstance.eSType = E_UM_GAME;
	[MobClick startWithConfigure:UMConfigInstance];
}

//启动但还没进入状态保存

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
	
	[[CBIconfont instance] initWithConfig:@{
											@(IFFontPath):@"iconfont.ttf",
											@(IFFontIdentify):@{
													@"ic_star":@"\ue600",
													@"ic_fire":@"\ue602",
													@"ic_coffee":@"\ue601",
													}
											}];

	return YES;
}

//基本完成程序准备开始运行
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	//检测内测泄露。
	[[PLeakSniffer sharedInstance] installLeakSniffer];

	//后台Bmob
	[Bmob registerWithAppKey:@"a1605700080f9bfddf67f6ed29e42e12"];

	
	//JSPatch
	
//	[JPEngine startEngine];
	//	对于实时性要求高的 APP，可以在 -applicationDidBecomeActive: 处调用这个接口，这样会在每次用户唤醒 APP 时去同步一次后台，请求次数会增多
	//	applicationDidBecomeActive
	
	//为了安全需要进行RSA Key 对脚本进行加密。
	//	[JSPatch testScriptInBundle]; 不能与 startWithAppKey 一起使用。只用于本地测试，测试完毕后需要去除 .文件里面不能加console.log.
	
	
	[JSPatch startWithAppKey:@"d690051f616bebb7"];
	
//#ifdef DEBUG
//	[JSPatch testScriptInBundle];
//
////	[JSPatch setupDevelopment];
//#endif
	[JSPatch sync];
	
	
//	[JSPatch setupLogger:^(NSString *msg) {
//		DESLog(@"当前内容为%@",msg);
//		
//	}];

	
//	NSDictionay *configs = [JSPatch getConfigParams];
//	//configs == @{@"name": @"bang"}
//	
//	NSString *name = [JSPatch getConfigParam:@"name"];
//	//name == bang
	
	
//	接口请求时间间隔至少为30分钟，也就是30分钟内多次调用 +updateConfigWithAppKey: 只会请求一次。若想 APP 对在线参数响应更实时，可以通过 +setupConfigInterval: 接口修改这个间隔值。
//	[JSPatch updateConfigWithAppKey:@"d690051f616bebb7"];
//	
//	[JSPatch setupUpdatedConfigCallback:^(NSDictionary *configs, NSError *error) {
//		
//	}];
//	[JSPatch setupCallback:^(JPCallbackType type, NSDictionary *data, NSError *error) {
//		switch (type) {
//			case JPCallbackTypeUpdate: {
//				NSLog(@"updated %@ %@", data, error);
//				break;
//			}
//			case JPCallbackTypeRunScript: {
//				NSLog(@"run script %@ %@", data, error);
//				break;
//			}
//			default:
//				break;
//		}
//	}];
	//setupRSAPublicKey,setupDevelopment,
//	testScriptInBundle 在上线之前需要对脚本进行本地测试，看看运行是否正常。
//	[JSPatch setupUserData:@{
//							 @"userId": @"100867",
//							 @"location": @"guangdong"
//							 }];
	
//	NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
//	NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
//	[JPEngine evaluateScript:script];
	
	//如果开发者自己做了错误捕捉，可以调用下面方法关闭友盟的错误统计：
	

	[MobClick setCrashReportEnabled:NO];
	

	
	[self saveDataToFile];
	//  友盟的方法本身是异步执行，所以不需要再异步调用
	[self umengTrack];
	//第一步：注册key
	
	[OpenShare connectWeixinWithAppId:@"wxd930ea5d5a258f4f"];
	[OpenShare connectQQWithAppId:@"101128744" secret:@"cc893ef392e383df22142a474d4abea6"];
	[OpenShare connectWeiboWithAppKey:@"4003638958"];
	
//	[OpenShare connectQQWithAppId:@"1103194207"];
//	[OpenShare connectWeiboWithAppKey:@"4003638958"];
//	[OpenShare connectWeixinWithAppId:@"wx9ad490e6428d5a7f"];
	
	
	
	//weibo 登录
	[WeiboSDK registerApp:weiboAppKey];
	
	[WXApi registerApp:@"wx8011e108b672eee2" withDescription:@"一念永恒"];

	//QQ 登录
//	[UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];

	//Mob  记住这里有个大坑就是plist白名单一定要设置LSApplicationQueriesSchemes，直接从demo里面的source 复制。
	//不然会出现qq或者微信icon显示不了。
	
	//当提示 Can't share because platform QQ did not set URL Scheme:QQ06071A28， Please try again after set
	//URL Scheme 时 ,果断在Target －》 info －》URL Types 添加一行QQ06071A28。
	
	
//	支持QQ所需的相关配置及代码 登录QQ互联（http://connect.qq.com/ ）注册成为开发者并登记应用取得AppId，然后打开下图位置，在URL Types中添加QQ的AppID，其格式为：”QQ” ＋ AppId的16进制（如果appId转换的16进制数不够8位则在前面补0，如转换的是：5FB8B52，则最终填入为：QQ05FB8B52 注意：转换后的字母要大写） 转换16进制的方法：echo ‘ibase=10;obase=16;801312852′|bc，其中801312852为QQ的AppID
	
	[SMSSDK registerApp:@"12f1847875e26" withSecret:@"69471e44e59a7d4bcf068d7b7329d9c8"];
	//shareSDK
	
	
	[ShareSDK registerApp:@"2160fe96d444"
	 
		  activePlatforms:@[
							@(SSDKPlatformTypeSinaWeibo),
							@(SSDKPlatformTypeTencentWeibo),
							@(SSDKPlatformTypeMail),
							@(SSDKPlatformTypeSMS),
							@(SSDKPlatformTypeCopy),
							@(SSDKPlatformTypeWechat),
							@(SSDKPlatformTypeQQ),
							@(SSDKPlatformTypeYinXiang),
							@(SSDKPlatformTypeEvernote),
							@(SSDKPlatformTypeAliPaySocial),

							]
				 onImport:^(SSDKPlatformType platformType)
	 {
		 switch (platformType)
		 {
			 case SSDKPlatformTypeWechat:
				 [ShareSDKConnector connectWeChat:[WXApi class]];

				 break;
			 case SSDKPlatformTypeQQ:
				 [ShareSDKConnector connectQQ:[QQApiInterface class]
							tencentOAuthClass:[TencentOAuth class]];
				 break;
			 case SSDKPlatformTypeSinaWeibo:
				 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
				 break;
		
			 case SSDKPlatformTypeAliPaySocial:
				 [ShareSDKConnector connectAliPaySocial:[APOpenAPI class]];
				 break;

			 default:
				 break;
		 }
	 }
		  onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
	 {
		 
		 switch (platformType)
		 {
			 case SSDKPlatformTypeSinaWeibo:
				 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
				 [appInfo SSDKSetupSinaWeiboByAppKey:@"4003638958"
										   appSecret:@"648b387fda4b6e1c62c0f9febf84c7cc"
										 redirectUri:@"http://www.sharesdk.cn"
											authType:SSDKAuthTypeBoth];
				 break;
			 case SSDKPlatformTypeTencentWeibo:
				 //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
				 [appInfo SSDKSetupTencentWeiboByAppKey:@"801307650"
											  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
											redirectUri:@"http://www.sharesdk.cn"];
				 break;
			
			
			 case SSDKPlatformTypeWechat:
				 [appInfo SSDKSetupWeChatByAppId:@"wx9ad490e6428d5a7f"
									   appSecret:@"23eb8a329249afff95d00d8b3aa13f85"];
				 break;
			 case SSDKPlatformTypeQQ:
				 [appInfo SSDKSetupQQByAppId:@"101128744"
									  appKey:@"cc893ef392e383df22142a474d4abea6"
									authType:SSDKAuthTypeBoth];
				 break;
			
		
				 //印象笔记分为国内版和国际版，注意区分平台
				 //设置印象笔记（中国版）应用信息
			 case SSDKPlatformTypeYinXiang:
				 
				 //设置印象笔记（国际版）应用信息
			 case SSDKPlatformTypeEvernote:
				 [appInfo SSDKSetupEvernoteByConsumerKey:@"sharesdk-7807"
										  consumerSecret:@"d05bf86993836004"
												 sandbox:YES];
				 break;
				 
			 case SSDKPlatformTypeAliPaySocial:
				 [appInfo SSDKSetupAliPaySocialByAppId:@"2015072400185895"];
				 break;
				 
			 default:
				 break;

		 }
	 }];


	
	//JPush
	NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
	
	if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
		//可以添加自定义categories
		[JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
														  UIUserNotificationTypeSound |
														  UIUserNotificationTypeAlert)
											  categories:nil];
	} else {
		//categories 必须为nil
		[JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
														  UIRemoteNotificationTypeSound |
														  UIRemoteNotificationTypeAlert)
											  categories:nil];
	}
	
	//如不需要使用IDFA，advertisingIdentifier 可为nil
	[JPUSHService setupWithOption:launchOptions appKey:appKey
						  channel:channel
				 apsForProduction:isProduction
			advertisingIdentifier:advertisingId];
	

	
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
	
//	self.window = [[UIWindow alloc] init];
//	self.window.frame = [UIScreen mainScreen].bounds;
	
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

//	LaunchAnimationViewController *launchVC = [[LaunchAnimationViewController alloc] init];
//	self.window.rootViewController = launchVC;
	
	
//	self.window.rootViewController = [[DESTabBarController alloc] init];
//	[self.window makeKeyAndVisible];
	
	//AdvertiseView *advertise = [AdvertiseView new];
	
//	self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];

	self.window.rootViewController = [[DESTabBarController alloc] init];
	[self.window makeKeyAndVisible];
	
	/*
	// 1.判断沙盒中是否存在广告图片，如果存在，直接显示
	NSString *filePath = [advertise getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
	
	BOOL isExist = [advertise isFileExistWithFilePath:filePath];
	if (isExist) {// 图片存在
		
		AdvertiseView *advertiseView = [[AdvertiseView alloc] initWithFrame:self.window.bounds];
		advertiseView.filePath = filePath;
		[advertiseView show];
		
	}
	
	// 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
	[advertise getAdvertisingImage];
   */
	return YES;
}


//- (UIStatusBarStyle)preferredStatusBarStyle {
//
//	//ios 9 使用此方法。后将View controller-based status bar appearance  BOOL值设为YES
//	
//	return UIStatusBarStyleLightContent;
//	
//}

//当应用程序将要入非活动状态执行，应用程序不接收消息或事件，比如来电话了
- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	
	//这个亮度就是在你完全退出这个app后还是会保持的 所以当我们不需要这个亮度继续保持的时候 我们需要在app的代理方法里做些处理 :
	[[UIScreen mainScreen] setBrightness: 0.5];//0.5是自己设定认为比较合适的亮度值
	

	NSLog(@"execute applicationWillResignActive");

}

//当程序被推送到后台的时候调用。所以要设置后台继续运行，则在这个函数里面设置即可：

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

//当程序从后台将要重新回到前台时候调用，这个刚好跟上面的那个方法相反：

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	[application setApplicationIconBadgeNumber:0];
	[application cancelAllLocalNotifications];
	NSLog(@"execute applicationWillEnterForeground");

}
//当应用程序入活动状态执行，这个刚好跟上面那个方法相反
- (void)applicationDidBecomeActive:(UIApplication *)application {
	NSLog(@"execute applicationDidBecomeActive");
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

//当程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作：

- (void)applicationWillTerminate:(UIApplication *)application {
	NSLog(@"execute applicationWillTerminate");

	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
	
//	由于之前混合各种SDK，一直没有排查到使用SSO 登录不到的原因，现在凶手就在这里。
// [WeiboSDK handleOpenURL:url delegate:self]; 没执行到是不会执行代理方法  didReceiveWeiboResponse的。
	
	//使用OpenShare 的方式授权登录。
	//新浪微博这个不用OpenShare的方式，直接用原生的SDK。
	NSString * value = options[@"UIApplicationOpenURLOptionsSourceApplicationKey"];
	//com.tencent.xin
	
	[WXApi handleOpenURL:url delegate:self];

	if([value isEqualToString:@"com.sina.weibo"]){
		
	return [WeiboSDK handleOpenURL:url delegate:self];

	}
	
	if ([OpenShare handleOpenURL:url]) {
		return YES;
	}
	
	//单纯使用WX，WB 授权登录取消下面两行注释。
//	[WXApi handleOpenURL:url delegate:self];
//	return [WeiboSDK handleOpenURL:url delegate:self];
	
	//这里可以写上其他OpenShare不支持的客户端的回调，比如支付宝等。
	return YES;
}





- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	
	NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
	
	[self developerInstall:deviceToken];

	[JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
	[JPUSHService handleRemoteNotification:userInfo];
	NSLog(@"userInfo %@",[userInfo description]);
	[BmobPush handlePush:userInfo];
	
	NSLog(@"收到通知:%@", [self logDic:userInfo]);
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
	[JPUSHService handleRemoteNotification:userInfo];
	NSLog(@"收到通知:%@", [self logDic:userInfo]);
	completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
	[JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}



- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
	if ([response isKindOfClass:[WBSendMessageToWeiboResponse class]]) {
		NSString *title = NSLocalizedString(@"发送结果", nil);
		NSString *message = [NSString stringWithFormat:@"%@: %d\\n%@: %@\\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
		
		WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
		NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
		if (accessToken)
		{
			self.access_token = accessToken;
		}
		NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
		if (userID) {
			self.userID = userID;
		}
		NSLog(@"返回状态%ld  %@   %@",response.statusCode,response.userInfo,response.requestUserInfo);
		
	}else if([response isKindOfClass:[WBAuthorizeResponse class]]){
		self.userID = [(WBAuthorizeResponse *)response userID];
		self.access_token = [(WBAuthorizeResponse *)response accessToken];
		self.refresh_token = [(WBAuthorizeResponse *)response refreshToken];
		self.expirationDate = [(WBAuthorizeResponse *)response expirationDate];
		[self refreshUserInfo];
	}
}

- (void)refreshUserInfo{
	NSString * urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@" ,self.access_token,self.userID];
	
	NSData *userInfoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
	
	NSDictionary *userInfoDict = [NSJSONSerialization JSONObjectWithData:userInfoData options:NSJSONReadingAllowFragments error:nil];
	
	NSLog(@"%@",userInfoDict);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"WBAuthorSuccessfulNotification" object:nil userInfo:userInfoDict];
	
}


#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp{
	
	if ([resp isKindOfClass:[SendAuthResp class]]) {
		SendAuthResp *temp=(SendAuthResp*)resp;
		//根据code获取
		[self getAccess_token:temp.code];
	}
}

-(void)getWXCodeStringWithController:(id)vc
{
	//构造SendAuthReq结构体
	SendAuthReq * req =[[SendAuthReq alloc] init];
	req.scope = @"snsapi_userinfo,snsapi_base,snsapi_contact" ;
	req.state = @"owner";
	
	//第三方向微信终端发送一个SendAuthReq消息结构
	LoginViewController *controller = (LoginViewController*)vc;
	
	[WXApi sendAuthReq:req viewController:controller delegate:self];
}

/**
 *  根据code获取access_token
 *
 *  @param code code
 */
-(void)getAccess_token:(NSString*)code{
	
	NSString *urlStr =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",@"wx8011e108b672eee2",@"52b79fcca9ca43fcc7cd37358c7f3feb",code];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		
		NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
		
		NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
		
		if (dic) {
			
			NSString *access_token = [dic objectForKey:@"access_token"];
			NSString *openId = [dic objectForKey:@"openid"];
			
			[self getUserInfoWithAccess_token:access_token andOpenId:openId];
		}
	});
	
}

/**
 *  根据得到的access_token和openid得到用户个人信息
 *
 *  @param access_token_ access_token
 *  @param openId_       openid
 */
-(void)getUserInfoWithAccess_token:(NSString*)access_token_ andOpenId:(NSString*)openId_{
	
	NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token_, openId_];
	
	NSURL *zoneUrl=[NSURL URLWithString:url];
	
	//微信第三方登录时必须异步加载
	dispatch_async(dispatch_get_main_queue(), ^{
		
		NSData *data = [NSData dataWithContentsOfURL:zoneUrl];
		
		NSDictionary *userInfoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"WXAuthorSuccessfulNotification" object:nil userInfo:userInfoDic];
	});
}



- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//	return [ShareSDK handleOpenURL:url wxDelegate:self];
	
	[WXApi handleOpenURL:url delegate:self];
	return [WeiboSDK handleOpenURL:url delegate:self];
	
}


// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
	if (![dic count]) {
		return nil;
	}
	NSString *tempStr1 =
	[[dic description] stringByReplacingOccurrencesOfString:@"\\u"
												 withString:@"\\U"];
	NSString *tempStr2 =
	[tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
	NSString *tempStr3 =
	[[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
	NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
	NSString *str =
	[NSPropertyListSerialization propertyListFromData:tempData
									 mutabilityOption:NSPropertyListImmutable
											   format:NULL
									 errorDescription:NULL];
	return str;
}


- (void)saveDataToFile{
	
	NSFileManager *manager = [[NSFileManager alloc]init];
	self.window.backgroundColor = [UIColor whiteColor];
	NSArray *hostList = @[@"头条",@"娱乐",@"热点",@"体育",@"泉州",@"网易号",@"财经",@"科技",@"汽车",@"时尚",@"图片",@"跟贴",@"房产",@"直播",@"轻松一刻",@"段子",@"军事",@"历史",@"家居",@"独家",@"游戏",@"健康",@"政务",@"哒哒趣闻",@"美女",@"NBA",@"社会",@"彩票"];
	
	NSArray *addList = @[@"漫画",@"影视歌",@"中国足球",@"国际足球",@"CBA",@"跑步",@"手机",@"数码",@"移动互联",@"云课堂",@"态度公开课",@"旅游",@"读书",@"酒香",@"教育",@"亲子",@"暴雪游戏",@"情感",@"艺术",@"博客",@"论坛",@"型男",@"萌宠"];
	NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString * documentDirectory = [paths objectAtIndex:0];
	
	NSString * BtnList = [documentDirectory stringByAppendingPathComponent:@"BtnList.txt"];
	NSString * ADDList = [documentDirectory stringByAppendingPathComponent:@"ADDList.txt"];
	if (![manager fileExistsAtPath:BtnList] ) {
		
		
		[manager createFileAtPath:BtnList contents:nil attributes:nil];
		[hostList writeToFile:BtnList atomically:YES];
		
	}
	if ( ![manager fileExistsAtPath:ADDList]) {
		[manager createFileAtPath:ADDList contents:nil attributes:nil];
		[addList writeToFile:ADDList atomically:YES];
		
	}

}


/**
 * 本例子程序，是以本台手机作为开发者接收推送的设备 ，主要是演示推送功能。
 * 故如果是开发者的话会在Installation添加字段isDeveloper并设置为true，普通用户则设置为false
 */





-(void)developerInstall:(NSData*)deviceToken{
	BmobInstallation    *installation = [BmobInstallation installation];
	[installation setDeviceTokenFromData:deviceToken];
	[installation setObject:[NSNumber numberWithBool:YES] forKey:@"isDeveloper"];
	[installation saveInBackground];
}

-(void)userInstall:(NSData*)deviceToken{
	BmobInstallation *installation = [BmobInstallation installation];
	[installation setObject:[NSNumber numberWithBool:NO] forKey:@"isDeveloper"];
	[installation setDeviceTokenFromData:deviceToken];
	//用户订阅sport频道的内容
	[installation subsccribeToChannels:@[@"sport"]];
	[installation saveInBackground];
}


////直接退出app
//- (void)exitApplication {
//	AppDelegate *app = [UIApplication sharedApplication].delegate;
//	UIWindow *window = app.window;
//
//	[UIView animateWithDuration:1.0f animations:^{
//		window.alpha = 0;
//	} completion:^(BOOL finished) {
//		exit(0);
//	}];
//}

@end
