#import "DetailViewController.h"
#import "DetailModel.h"

#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "ImageModel.h"
#import "SDWebImageManager.h"
#import <Masonry.h>

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
	
	UIBarButtonItem *share = [UIBarButtonItem barButtonItemByCustomButtonWithImage:@"upload" highlightedImage:@"upload" target:self action:@selector(shareItemClick)];
	
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
		[item setImage:[UIImage imageNamed:@"star1"] forState:UIControlStateNormal];
		
	}else{
		
		item.selected = YES;
		[item setImage:[UIImage imageNamed:@"star-on"] forState:UIControlStateNormal];
	}
	
}

/**
 *  分享按钮点击事件
 */
-(void)shareItemClick{
	
}
/**
 *
 */
-(void)commentItemClick{
	
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
