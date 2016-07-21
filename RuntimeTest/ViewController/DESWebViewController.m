//
//  DESWebViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/6/30.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DESWebViewController.h"


@interface DESWebViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation DESWebViewController
- (void)viewDidLoad {
	[super viewDidLoad];
	
//	self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//	self.webView.backgroundColor = [UIColor whiteColor];
//	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cocoachina.com/ios/20160621/16764.html"]]];
//	[self.view addSubview:self.webView];
}
@end


//@implementation UIViewController (DESPublic)
//- (UINavigationController*)des_navigationController
//{
//	UINavigationController* nav = nil;
//	if ([self isKindOfClass:[UINavigationController class]]) {
//		nav = (id)self;
//	}
//	else {
//		if ([self isKindOfClass:[UITabBarController class]]) {
//			nav = [((UITabBarController*)self).selectedViewController des_navigationController];
//		}
//		else {
//			nav = self.navigationController;
//		}
//	}
//	return nav;
//}
//@end

