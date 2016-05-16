#import "DetailViewController.h"
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

#define kToolBarHeight 38

@interface DetailViewController ()<UIWebViewDelegate>

@property (nonatomic,weak) UIWebView *webView;

@property (nonatomic,weak) UIToolbar *toolbar;

@property (nonatomic,strong) NSString *content;

@property (nonatomic,strong) DetailModel *webModel;

@end

@implementation DetailViewController

#pragma mark - 试图生命周期
- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"正文";
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
	hud.labelText = NSLocalizedString(@"正在加载请稍后...", @"HUD loading title");
	
	
	
	[self creatWebview];
	
	[self creatToolBar];
}


#pragma mark - 创建webview
-(void)creatWebview{
	
	UIWebView *webview = [[UIWebView alloc]init];
	self.webView = webview;
	self.webView.backgroundColor = [UIColor colorWithRed:248 / 255.0 green:248 / 255.0 blue:248 / 255.0 alpha:1];
	[self.view addSubview:webview];
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

/**
 *  分享按钮点击事件
 */
-(void)shareItemClick:(id)sender{
	
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	
	return YES;
}


@end
