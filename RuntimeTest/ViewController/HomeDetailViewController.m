//
//  HomeDetailViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/26.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "HomeDetailView.h"

@interface HomeDetailViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) HomeDetailView *homeDetailView;
@end

@implementation HomeDetailViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self setTitle:_navTitle];
	[self.view setBackgroundColor:kAppMainBgColor];
	
	[self.view addSubview:self.homeDetailView];
}

- (HomeDetailView *)homeDetailView{
	if (!_homeDetailView) {
		_homeDetailView=[[HomeDetailView alloc]initWithFrame:self.view.bounds];
		[_homeDetailView setDelegate:self];
		NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
		[_homeDetailView loadRequest:request];
	}
	return _homeDetailView;
}

#pragma mark - UIWebView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
	
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
