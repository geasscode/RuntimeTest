#import "NewsViewController.h"
#import "DetailModel.h"

#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "ImageModel.h"
#import "SDWebImageManager.h"
#import "DESShareView.h"
#import "OpenShareHeader.h"
#import <MessageUI/MessageUI.h>
#import "JMActionSheet.h"
#import "JMPickerActionSheet.h"
#import "JMImagesActionSheet.h"

#import "JMCollectionItem.h"
#import "IonIcons.h"
#import "DBHelper.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "NSObject+PropertyAdd.h"

#define kToolBarHeight 38

@interface NewsViewController ()<UIGestureRecognizerDelegate,UIWebViewDelegate,UIAlertViewDelegate>

@property (nonatomic,weak) UIWebView *webView;

@property (nonatomic,weak) UIToolbar *toolbar;

@property (nonatomic,strong) NSString *content;

@property (nonatomic,strong) NSString *webImageURL;


@property (nonatomic,strong) DetailModel *webModel;


@end

@implementation NewsViewController

#pragma mark - 试图生命周期
- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"正文";
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
	hud.labelText = NSLocalizedString(@"正在加载请稍后...", @"HUD loading title");
	
	[self creatWebview];
	[self creatToolBar];
	
}


-(void)loadDocument:(NSString *)documentName inView:(UIWebView *)webView
{
	NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
	NSURL *url = [NSURL fileURLWithPath:path];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[webView loadRequest:request];
	
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	
	
	[self injectJS:webView];
	
}

-(void)injectJS:(UIWebView *)webView{
	//js方法遍历图片添加点击事件 返回图片个数
	static  NSString * const jsGetImages =
	@"function getImages(){\
	var objs = document.getElementsByTagName(\"img\");\
	for(var i=0;i<objs.length;i++){\
	objs[i].onclick=function(){\
	document.location.href=\"jscallbackoc://saveImage_*\"+this.src;\
	};\
	};\
	return objs.length;\
	};";
	
	[webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
	
	//通过这个控制字体大小。默认是100%。
	int fontSize = 100;
	NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'", fontSize];
	[webView stringByEvaluatingJavaScriptFromString:jsString];
	
	//注入自定义的js方法后别忘了调用 否则不会生效
	[webView stringByEvaluatingJavaScriptFromString:@"getImages()"];//调用js方法
	
	// 禁用用户选择
	[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
	
	// 禁用长按弹出框
	[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}


- (void)performJSMethodWithURL:(NSString *)url protocolName:(NSString *)name performViewController:(UIViewController *)viewController {
	/*
	 跳转url ：        jscallbackoc://sendMessage_number2_number3_*100$100$99
	 protocolName：   jscallbackoc://
	 方法名：          sendMessage:number2:number3
	 参数：            100，100，99
	 
	 方法名和参数组合为oc的方法为：- (void)sendMessage:(NSString *)number number2:(NSString *)number2 number3:(NSString *)number3
	 */
	
	// 获得协议后面的路径为： sendMessage_number2_*200$300
	NSString *path = [url substringFromIndex:name.length];
	
	// 利用“*”切割路径，“*”前面是方法名，后面是参数
	NSArray *subpaths = [path componentsSeparatedByString:@"*"];
	
	// 方法名 methodName == sendMessage:number2:
	// 下面的方法是把"_"替换为"?', js返回的url里面把“:”直接省略了，只能在js里面使用“_”来表示，然后在oc里面再替换回“:”
	NSString *methodName =[[subpaths firstObject ] stringByReplacingOccurrencesOfString:@"_" withString:@":"];
	
	// 参数  200$300，每个参数之间使用符号$链接（避免和url里面的其他字符混淆，因为一般url里面不会出现这个字符）
	NSArray *params = nil;
	if (subpaths.count == 2) {
		params = [[subpaths lastObject] componentsSeparatedByString:@"$"];
	}
	NSLog(@"方法名：%@-----参数：%@", methodName,params);
	// 调用NSObject类扩展方法，传递多个参数
	[viewController performSelector:NSSelectorFromString(methodName) withObjects:params];
}

#pragma mark - 创建webview
-(void)creatWebview{
	
	UIWebView *webview = [[UIWebView alloc]init];
	self.webView = webview;
	self.webView.backgroundColor = [UIColor colorWithRed:248 / 255.0 green:248 / 255.0 blue:248 / 255.0 alpha:1];
	
	
	UILongPressGestureRecognizer * longPressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
	longPressed.delegate = self;
	
	[self.webView addGestureRecognizer:longPressed];
	
	
	//	[self loadDocument:@"现有的本地word文档.docx" inView:webview];
	
	
	
	[self.view addSubview:webview];
	
	//	///自动适应大小
	//	webview.scalesPageToFit = YES;
	//
	//	///关闭下拉刷新效果
	//	webview.scrollView.bounces = NO;
	
	//设置是否透明
	webview.opaque = YES;
	webview.delegate = self;
	[webview mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.top.left.right.equalTo(super.view);
		make.bottom.equalTo(super.view.mas_bottom).mas_offset(-kToolBarHeight);
		
	}];
	
	
	
	
	
	
	
}

/**
 *  创建底部的toolBar
 */
-(void)creatToolBar{
	
	UIToolbar *toolbar = [[UIToolbar alloc]init];
	
	self.toolbar = toolbar;
	toolbar.backgroundColor = [UIColor whiteColor];
	toolbar.barTintColor = [UIColor whiteColor];
	[self.view addSubview:toolbar];
	toolbar.frame = CGRectMake(0, kScreenHeight - kToolBarHeight,kScreenWidth, kToolBarHeight);
	
	UIBarButtonItem *wait = [UIBarButtonItem barButtonItemByCustomButtonWithImage:@"article_detail_late" highlightedImage:@"" target:self action:@selector(waitreadItemClick:)];
	
	UIBarButtonItem *save = [UIBarButtonItem barButtonItemByCustomButtonWithImage:@"star1" highlightedImage:@"star-on" target:self action:@selector(saveItemClick:)];
	
	UIBarButtonItem *share = [UIBarButtonItem barButtonItemByCustomButtonWithImage:@"upload" highlightedImage:@"upload" target:self action:@selector(shareItemClick:)];
	
	UIBarButtonItem *comment = [UIBarButtonItem barButtonItemByCustomButtonWithImage:@"bottom_bar_comment" highlightedImage:@"bottom_bar_comment" target:self action:@selector(commentItemClick)];
	
	//添加空隙
	UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	toolbar.items = @[wait,fixedSpace,save,fixedSpace,share,fixedSpace,comment];
	
}



- (void)longPressed:(UITapGestureRecognizer*)recognizer{
	
	//只在长按手势开始的时候才去获取图片的url
	if (recognizer.state != UIGestureRecognizerStateBegan) {
		return;
	}
	
	CGPoint touchPoint = [recognizer locationInView:self.webView];
	
	NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
	NSString *urlToSave = [self.webView stringByEvaluatingJavaScriptFromString:js];
	
	if (urlToSave.length == 0) {
		return;
	}
	
	NSLog(@"获取到图片地址：%@",urlToSave);
	_webImageURL = urlToSave;
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要保存吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
	[alert show];
}

//可以识别多个手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	return YES;
}


#pragma mark - UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		//NSInteger index = _imagesDisplayView.imagesScrollView.contentOffset.x / kScreenWidth;
		
		//这段代码移值到新的project 没有任何问题。但是此项目就出现了问题。估计某些库的rumtime除了问题。 具体在哪以我技术难以查找。
		NSString *webImageURL = @"http://img1.tuicool.com/FfqABjf.jpg";
		NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:webImageURL]];
		UIImage* webURL = [UIImage imageWithData:data];
		UIImageWriteToSavedPhotosAlbum(webURL, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
		
	}
	
}

//判断图片保存状态


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
	if(!error){
		NSLog(@"Photo saved to library!");
	}
	else{
		NSLog(@"Saving failed :(");
	}
}

-(void)saveImage:(NSString *)imageURL
{
	NSLog(@"获取到图片地址：%@",imageURL);
}

/**
 *  带读按钮点击事件
 */
-(void)waitreadItemClick:(UIButton *)item{
	
	if(item.selected){
		
		item.selected = NO;
		[item setImage:[UIImage imageNamed:@"article_detail_late"] forState:UIControlStateNormal];
		
	}else{
		
		item.selected = YES;
		[item setImage:[UIImage imageNamed:@"article_detail_late_on"] forState:UIControlStateNormal];
	}
	
}
/**
 *  收藏按钮的点击事件
 */
-(void)saveItemClick:(UIButton *)item{
	
	if(item.selected){
		
		item.selected = NO;
		[DBHelper deleteData:_webModel.id];
		[item setImage:[UIImage imageNamed:@"star1"] forState:UIControlStateNormal];
		
	}else{
		
		DetailModel *model = [DetailModel new];
		model.title = _webModel.title;
		model.url = _webModel.url;
		model.detatilArticleId = _webModel.detatilArticleId;
		model.feed_title = _webModel.feed_title;
		
		MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
		
		if([DBHelper insertData:model]){
			hud.labelText = NSLocalizedString(@"收藏成功", @"HUD loading title");
			
		}
		else{
			
			hud.labelText =  [model.title isEqualToString:@""] || !model.title ? @"加载完成才能收藏哦？" : @"已经收藏";
		}
		
		hud.mode = MBProgressHUDModeText;
		hud.dimBackground = YES;
		
		[hud showAnimated:YES whileExecutingBlock:^{
			sleep(1);
		} completionBlock:^{
			[hud removeFromSuperViewOnHide];
		}];
		
		item.selected = YES;
		[item setImage:[UIImage imageNamed:@"star-night"] forState:UIControlStateNormal];
	}
	
}


-(void)sdkShareMethod{
	//1、创建分享参数
	NSArray* imageArray = @[[UIImage imageNamed:@"icon.jpg"]];
	
	
	NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
	[shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@",_webModel.title]
									 images:imageArray
										url:[NSURL URLWithString:_webModel.url]
									  title:[NSString stringWithFormat:@"%@",_webModel.title]
									   type:SSDKContentTypeAuto];
	//2、分享（可以弹出我们的分享菜单和编辑界面）
	//要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
	
	
	[ShareSDK showShareActionSheet:nil
							 items:nil
					   shareParams:shareParams
			   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
				   
				   switch (state) {
					   case SSDKResponseStateSuccess:
					   {
						   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
																			   message:nil
																			  delegate:nil
																	 cancelButtonTitle:@"确定"
																	 otherButtonTitles:nil];
						   [alertView show];
						   break;
					   }
					   case SSDKResponseStateFail:
					   {
						   if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
						   {
							   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
																			   message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
																			  delegate:nil
																	 cancelButtonTitle:@"OK"
																	 otherButtonTitles:nil, nil];
							   [alert show];
							   break;
						   }
						   else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
						   {
							   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
																			   message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
																			  delegate:nil
																	 cancelButtonTitle:@"OK"
																	 otherButtonTitles:nil, nil];
							   [alert show];
							   break;
						   }
						   else
						   {
							   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
																			   message:[NSString stringWithFormat:@"%@",error]
																			  delegate:nil
																	 cancelButtonTitle:@"OK"
																	 otherButtonTitles:nil, nil];
							   [alert show];
							   break;
						   }
						   break;
					   }
						   
					   case SSDKResponseStateCancel:
					   {
						   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
																			   message:nil
																			  delegate:nil
																	 cancelButtonTitle:@"确定"
																	 otherButtonTitles:nil];
						   [alertView show];
						   break;
					   }
						   
					   default:
						   break;
				   }
				   
				   
			   }
	 ];
}

//不使用第三方的如ShareSDK方式，这种方式比较安全，但是功能单一。没法统计只能分享。好处是安全，体积小。适合需求不多的情况。
-(void)shareMethod:(id)sender{
	JMActionSheetCollectionItem *collectionItem = [[JMActionSheetCollectionItem alloc] init];
	NSMutableArray *collectionItems = [NSMutableArray new];
	JMCollectionItem *item = [[JMCollectionItem alloc] init];
	item.actionName = @"微信朋友圈";
	item.actionImage = [UIImage imageNamed:@"share_pyquan"];
	[collectionItems addObject:item];
	
	item = [[JMCollectionItem alloc] init];
	item.actionName = @"微信好友";
	item.actionImage = [UIImage imageNamed:@"share_weixin"];
	[collectionItems addObject:item];
	
	item = [[JMCollectionItem alloc] init];
	item.actionName = @"短信";
	item.actionImage = [UIImage imageNamed:@"share_msg"];
	[collectionItems addObject:item];
	
	item = [[JMCollectionItem alloc] init];
	item.actionName = @"新浪微博";
	item.actionImage = [UIImage imageNamed:@"share_sina"];
	[collectionItems addObject:item];
	
	item = [[JMCollectionItem alloc] init];
	item.actionName = @"QQ";
	item.actionImage = [UIImage imageNamed:@"share_qq"];
	[collectionItems addObject:item];
	
	item = [[JMCollectionItem alloc] init];
	item.actionName = @"QQ空间";
	item.actionImage = [UIImage imageNamed:@"share_qzone"];
	[collectionItems addObject:item];
	
	collectionItem.elements = (NSArray <JMActionSheetCollectionItem> *)collectionItems;
	collectionItem.collectionActionBlock = ^(JMCollectionItem *selectedValue){
		NSString *theString = selectedValue.actionName;
		NSArray *items = @[@"微信朋友圈", @"微信好友", @"短信", @"新浪微博", @"QQ",@"QQ空间"];
		NSUInteger shareBtnType = [items indexOfObject:theString];
		
		switch (shareBtnType) {
			case SharePyQuan:{
				// 分享到朋友圈
				[self pyqClick];
				break;
			}
			case ShareWeix:{
				[self wxFriendClick];
				// 发给微信好友
				break;
			}case ShareMsg:{
				// 点击了短信
				[self sendMessage];
				break;
			}case ShareSina:{
				// 分享到微博
				[self sinaWBClick];
				break;
			}case ShareQQ:{
				// 发给QQ好友
				[self qqFriend];
				break;
			}case ShareQzone:{
				// 分享到QQ空间
				[self qzone];
				break;
			}default:{
				NSLog(@"默认");
				break;
			}
		}
		
		
		NSLog(@"collectionItem selectedValue %@",selectedValue.actionName);
	};
	
	JMActionSheetDescription *desc = [[JMActionSheetDescription alloc] init];
	desc.actionSheetTintColor = [UIColor grayColor];
	desc.actionSheetCancelButtonFont = [UIFont boldSystemFontOfSize:17.0f];
	desc.actionSheetOtherButtonFont = [UIFont systemFontOfSize:16.0f];
	desc.title = @"分享方式";
	JMActionSheetItem *cancelItem = [[JMActionSheetItem alloc] init];
	cancelItem.title = @"取消";
	desc.cancelItem = cancelItem;
	
	
	
	desc.items = @[collectionItem];
	[JMActionSheet showActionSheetDescription:desc inViewController:self fromView:sender permittedArrowDirections:UIPopoverArrowDirectionAny];
}

//最简单的方式。
-(void)activityItems{
	//Bookmark, Add To Reading List, and Add To Homescreen are only available in safari, unless you define them yourself. To add those buttons, you need to create an applicationActivities NSArray, populated with UIActivity objects for various services. You can pass this array into the initWithActivityItems:applicationActivities:
	
	//	UIActivityViewController中的服务分为了两种，UIActivityCategoryAction和UIActivityCategoryShare,UIActivityCategoryAction表示在最下面一栏的操作型服务,比如Copy、Print;UIActivityCategoryShare表示在中间一栏的分享型服务，比如一些社交软件。
	
	
	//用系统自带的方法增加qq收藏，微信收藏，分享到朋友圈。新浪微博。待实现。
	//	NSArray* imageArray = @[[UIImage imageNamed:@"icon.jpg"]];
	
	NSString *title = _webModel.title;
	
	NSString *description = _webModel.title;;
	
	
	//要显示存储图像icon首先要有图片。
	UIImage *imageIcon = [UIImage imageNamed:@"icon.jpg"];
	//当有URL 时才能显示添加到阅读列表。
	NSURL *URL = [NSURL URLWithString:_webModel.url];
	
	//	UISimpleTextPrintFormatter *printData = [[UISimpleTextPrintFormatter alloc] initWithText:self.title];
	NSArray *activityItems = @[title, description,imageIcon,URL];
	UIActivityViewController *activityViewController = [[UIActivityViewController alloc]
														initWithActivityItems:activityItems applicationActivities:nil];
	
	
	activityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	
	//排除不需要的功能如AirDrop
	activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop,UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypeAssignToContact];
	
	//	NSURL *URL = [NSURL URLWithString:@"http://nshipster.com/uiactivityviewcontroller"];
	//	[[SSReadingList defaultReadingList] addReadingListItemWithURL:URL
	//															title:@"NSHipster"
	//													  previewText:@"..."
	//															error:nil];
	
	activityViewController.popoverPresentationController.sourceView = self.view;
	
	
	
	
	//	UIPopoverPresentationController *popover = activityViewController.popoverPresentationController;
	//	if (popover) {
	//		popover.sourceView = self.view;
	//		popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
	//	}
	
	
	// 写一个bolck，用于completionHandler的初始化
	//	UIActivityViewControllerCompletionHandler myBlock = ^(NSString *activityType,BOOL completed) {
	//		NSLog(@"%@", activityType);
	//
	//		if(completed) {
	//			NSLog(@"completed");
	//		} else
	//		{
	//			NSLog(@"cancled");
	//		}
	//		[activityViewController dismissViewControllerAnimated:YES completion:Nil];
	//	};
	//
	
	activityViewController.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
		NSLog(@"Finished with activity %@", activityType);
		
		if(completed) {
			NSLog(@"completed");
		} else
		{
			NSLog(@"cancled");
		}
		//		[activityViewController dismissViewControllerAnimated:YES completion:Nil];
	};
	
	// 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
	//	activityViewController.completionHandler = myBlock;
	
	
	//if iPhone
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		[self presentViewController:activityViewController animated:YES completion:nil];
	}
	//if iPad
	else {
		// Change Rect to position Popover
		UIBarButtonItem *shareBarButtonItem = self.navigationItem.leftBarButtonItem;
		UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
		[popup presentPopoverFromBarButtonItem:shareBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
	
	//	[self presentViewController:activityViewController animated:YES completion:nil];
}
/**
 *  分享按钮点击事件
 */
-(void)shareItemClick:(id)sender{
	
	//	[self shareMethod:sender];
	//	[self sdkShareMethod];
	[self activityItems];
}
/**
 *
 */
-(void)commentItemClick{
	
}

#pragma mark -- ShareViewDelegate
-(void)didClickShareBtn:(ShareBtn)type {
	
	switch (type) {
		case SharePyQuan:{
			// 分享到朋友圈
			[self pyqClick];
			break;
		}
		case ShareWeix:{
			[self wxFriendClick];
			// 发给微信好友
			break;
		}case ShareMsg:{
			// 点击了短信
			[self sendMessage];
			break;
		}case ShareSina:{
			// 分享到微博
			[self sinaWBClick];
			break;
		}case ShareQQ:{
			// 发给QQ好友
			[self qqFriend];
			break;
		}case ShareQzone:{
			// 分享到QQ空间
			[self qzone];
			break;
		}default:{
			NSLog(@"默认");
			break;
		}
	}
}

#pragma mark - 配置分享信息
- (OSMessage *)shareMessage {
	OSMessage *message = [[OSMessage alloc] init];
	NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
	fmt.dateFormat = @"yyyy年MM月dd日HH时mm分ss秒";
	NSString *now = [fmt stringFromDate:[NSDate date]];
	message.title = [NSString stringWithFormat:@"%@",_webModel.title];
	
	//	UIImage *img = [UIImage imageNamed:@"icon"];
	//	message.image = UIImageJPEGRepresentation(img, 1.0);
	message.image = [UIImage imageNamed:@"icon"];
	// 缩略图
	//	UIImage *psdIcon = [UIImage imageNamed:@"psb"];
	//	message.thumbnail = UIImageJPEGRepresentation(psdIcon, 1.0);
	//	message.thumbnail = [UIImage imageNamed:@"psb"];
	//一直找不到原因，直到比较dic 中的 thumbData 发现字节大的通不过，于是尝试注释 thumbnail。结果通过。
	//	只是提示应用数据出错。没有其他有帮助的信息，估计NSData大小有限制。
	
	message.desc = [NSString stringWithFormat:@"%@",_webModel.title];
	message.link= _webModel.url;
	return message;
}

#pragma mark - 分享到微博
- (void)sinaWBClick {
	OSMessage *message = [self shareMessage];
	[OpenShare shareToWeibo:message Success:^(OSMessage *message) {
		NSLog(@"分享到sina微博成功:\%@",message);
	} Fail:^(OSMessage *message, NSError *error) {
		NSLog(@"分享到sina微博失败:\%@\n%@",message,error);
	}];
}

#pragma mark - 分享给QQ好友
- (void)qqFriend {
	OSMessage *message = [self shareMessage];
	[OpenShare shareToQQFriends:message Success:^(OSMessage *message) {
		NSLog(@"分享到QQ好友成功:%@",message);
	} Fail:^(OSMessage *message, NSError *error) {
		NSLog(@"分享到QQ好友失败: %@\n%@",message,error);
	}];
	
}

#pragma mark - 分享到QQ空间
- (void)qzone{
	OSMessage *message = [self shareMessage];
	[OpenShare shareToQQZone:message Success:^(OSMessage *message) {
		NSLog(@"分享到QQ空间成功:%@",message);
	} Fail:^(OSMessage *message, NSError *error) {
		NSLog(@"分享到QQ空间失败:%@\n%@",message,error);
	}];
}

#pragma mark - 分享给微信好友
- (void)wxFriendClick{
	OSMessage *message = [self shareMessage];
	[OpenShare shareToWeixinSession:message Success:^(OSMessage *message) {
		NSLog(@"微信分享到会话成功：\n%@",message);
	} Fail:^(OSMessage *message, NSError *error) {
		NSLog(@"微信分享到会话失败：\n%@\n%@",error,message);
	}];
}

#pragma mark - 分享到朋友圈
- (void)pyqClick{
	OSMessage *message = [self shareMessage];
	[OpenShare shareToWeixinTimeline:message Success:^(OSMessage *message) {
		NSLog(@"微信分享到朋友圈成功：\n%@",message);
	} Fail:^(OSMessage *message, NSError *error) {
		NSLog(@"微信分享到朋友圈失败：\n%@\n%@",error,message);
	}];
}

#pragma mark - 发送短信
- (void)sendMessage{
	
	
	if( [MFMessageComposeViewController canSendText] ){
		MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
		// 短信的接收人
		controller.recipients = nil;//[NSArray arrayWithObject:@""]
		controller.body = _webModel.content;
		controller.messageComposeDelegate = self;
		[self presentViewController:controller animated:YES completion:nil];
	}else{
		NSLog(@"您的设备没有发送短信功能");
	}
}

#pragma mark -- MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
	[controller dismissViewControllerAnimated:NO completion:nil];
	
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"发送取消");
			break;
		case MessageComposeResultFailed:// send failed
			NSLog(@"发送失败");
			break;
		case MessageComposeResultSent:
			NSLog(@"发送成功");
			break;
		default:
			break;
	}
}


#pragma mark 获取数据
//赋值之后加载获取数据模型 拼接html webview加载html
-(void)setDetailTextId:(NSString *)detailTextId{
	
	_detailTextId = detailTextId;
	
	__weak typeof(self) weakself = self;
	[DetailModel detileNewsModelGetWithdetailTextId:detailTextId success:^(DetailModel *model) {
		
		weakself.webModel = model;
		
		NSURL *file = [[NSBundle mainBundle] URLForResource:@"article_detail.html" withExtension:nil];
		
		NSString *htmlstring = [NSString stringWithContentsOfURL:file encoding:NSUTF8StringEncoding error:nil];
		
		
		//替换内容中的img
		NSString *contensHtmlString = model.content;
		
		contensHtmlString = [self getImageWith:contensHtmlString imageArray:model.images];
		
		htmlstring = [htmlstring stringByReplacingOccurrencesOfString:@"%@title" withString:model.title];
		htmlstring = [htmlstring stringByReplacingOccurrencesOfString:@"%@feed" withString:model.feed_title];
		htmlstring = [htmlstring stringByReplacingOccurrencesOfString:@"%@time" withString:model.time];
		
		htmlstring = [htmlstring stringByReplacingOccurrencesOfString:@"%@content" withString:contensHtmlString];
		
		[self.webView loadHTMLString:htmlstring baseURL:file];
		
		[MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
		
	}];
	
}
/**
 *  获得HTML中的image 重新设置image的CSS样式以适应屏幕的大小
 */
-(NSString *)getImageWith:(NSString *)contensHtmlString imageArray:(NSArray *)images{
	
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<img\\ssrc[^>]*/>" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
	NSArray *result = [regex matchesInString:contensHtmlString options:NSMatchingReportCompletion range:NSMakeRange(0, contensHtmlString.length)];
	
	NSMutableArray *num = [NSMutableArray array];
	
	for (NSTextCheckingResult *item in result) {
		
		NSString * imgHtml = [contensHtmlString substringWithRange:[item rangeAtIndex:0]];
		[num addObject:imgHtml];
		
	}
	
	//循环遍历得到的结果
	for (int i = 0; i < num.count; i++) {
		//从内容中截取出图片的url链接<img ars = ...> 用来匹配查找
		NSString *imgHtml = num[i];
		for (ImageModel *imageModel in images) {
			
			//说明找到了对应的模型数据
			if ([imgHtml rangeOfString:imageModel.image_id].location != NSNotFound) {
				
				
				CGFloat newW = imageModel.w > self.webView.bounds.size.width -20 ? self.webView.bounds.size.width -20 : imageModel.w;
				
				NSString *newimgHtml = [NSString stringWithFormat:@"<img src=\"%@\" width = '%.0f' class=\"alignCenter\" />",imageModel.src,newW];
				
				contensHtmlString = [contensHtmlString stringByReplacingOccurrencesOfString:imgHtml withString:newimgHtml];
				
			}
			
		}
	}
	
	return contensHtmlString;
}

#pragma mark - webview的代理方法


//拦截跳转url，如果跳转过来的url包含了前缀"jscallbackoc://，就说明使我们自定义的方法，
//我们需要做拦截处理，转换为oc方法，但是其他跳转url就不做任务处理。
//每次网页在需要跳转之前，就会执行该方法。返回yes，表示可以跳转。返回no，表示不跳转。我们可以在这个方法里面拦截到跳转的url，然后做处理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	//点击web页面的图片调用如下代码
	NSString *url = [[request URL] absoluteString];
	NSString *protocolName = @"jscallbackoc://";
	
	if ( [url hasPrefix:protocolName]) {
		[self performJSMethodWithURL:url protocolName:protocolName performViewController:self ];
		return NO;
	}
	return YES;
	
}



@end
