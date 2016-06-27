//
//  AdvertiseViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/6/7.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "AdvertiseViewController.h"

static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";

@interface AdvertiseViewController ()
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation AdvertiseViewController



- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"点击进入广告链接";
	_webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
	_webView.backgroundColor = [UIColor whiteColor];
	if (!self.adUrl) {
		self.adUrl = @"http://www.jianshu.com";
	}
	NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.adUrl]];
	[_webView loadRequest:request];
	[self.view addSubview:_webView];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (void)setAdUrl:(NSString *)adUrl
{
	_adUrl = adUrl;
}

@end
