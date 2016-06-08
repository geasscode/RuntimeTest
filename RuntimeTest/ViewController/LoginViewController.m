//
//  LoginViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/6/7.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[UIApplication sharedApplication].statusBarHidden = YES;
}

- (IBAction)dismissButtonClick:(UIButton *)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
}

#pragma mark - 第三方登录Action
- (IBAction)thirdPlatformLoginAction:(UIButton *)sender {
	switch (sender.tag) {
		case 0:
			[self WeChatLogin];
			break;
		case 1:
			[self WeiboLogin];
			break;
		case 2:
			//   [self QQLogin];
			break;
			
		default:
			break;
	}
	
}

/**
 *  通过SSO方式和author 2.0 方式进行授权
 */
- (void)WeiboLogin{
	WBAuthorizeRequest *request = [WBAuthorizeRequest request];
	request.redirectURI = @"https://api.weibo.com/oauth2/default.html";
	request.scope = @"all";
	[WeiboSDK sendRequest:request];
	[self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  微信登录
 */
- (void)WeChatLogin {
	
//	[[AppDelegate sharedAppdelegate] getWXCodeStringWithController:self];
	[self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
