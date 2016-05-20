//
//  MainViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/19.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MyHomeViewController.h"
#import "FoundViewController.h"
#import "DESNavigationController.h"
#import "RuntimeTableViewController.h"
#import "PhotosViewController.h"
#import "scanViewController.h"
#import "WeeklyTableViewController.h"
#import "LBToAppStore.h"
#import <SMS_SDK/SMSSDK.h>


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//查看源码
//	clang -rewrite-objc MyClass.m
	
	//用户好评系统
	LBToAppStore *toAppStore = [[LBToAppStore alloc]init];
	toAppStore.myAppID = @"1067787090";
	[toAppStore showGotoAppStore:self];

    // Do any additional setup after loading the view.
//	NSArray * array  = @[@"hoem"];
//	NSLog(@"hello");
//	NSArray *classNames = @[@"HomeViewController"];
//	for(NSString *className in classNames){
//		
//		Class dictionaryClass = NSClassFromString(className);
//		UIViewController *vc  = (UIViewController*)[[dictionaryClass alloc] init];
//		
////		UIViewController *vc  = (UIViewController*)[[NSClassFromString(className) alloc] init];
//		DESNavigationController *nc = [[DESNavigationController alloc]initWithRootViewController:vc];
//		nc.view.layer.shadowColor = [UIColor blackColor].CGColor;
//		nc.view.layer.shadowOffset = CGSizeMake(-3.5, 0);
//		nc.view.layer.shadowOpacity = 0.2;
//		[self addChildViewController:nc];
//	}
	
	
	//AES ＋ BASE64 加密及解密调用。
	//字符串加密
//	NSString *key = @"12345678";
//	
//	NSString *secret = @"aes Bison base64";
//	
//	
//	NSLog(@"字符串加密---%@",[secret AES256_Encrypt:key]);
//	
//	//字符串解密
//	NSLog(@"字符串解密---%@",[[secret AES256_Encrypt:key] AES256_Decrypt:key]);
//	
//	
//	//NSData加密+base64
//	
//	NSData *plain = [secret dataUsingEncoding:NSUTF8StringEncoding];
//	
//	NSData *cipher = [plain AES256_Encrypt:key];
//	
//	NSLog(@"NSData加密+base64++++%@",[cipher newStringInBase64FromData]);
//	
//	
//	//解密
//	
//	plain = [cipher AES256_Decrypt:key];
//	
//	NSLog(@"NSData解密+base64++++%@", [[NSString alloc] initWithData:plain encoding:NSUTF8StringEncoding]);
	
	
	
	// 获取时间间隔
#define TICK   CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define TOCK   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)gotoWeeklyView:(id)sender {
	
	//换一种方式push vc。
	Class class = NSClassFromString(@"WeeklyTableViewController");
	if (class) {
		UIViewController *vc = [class new];
		[self.navigationController pushViewController:vc animated:YES];
	}
//	WeeklyTableViewController * weeklyVC = [WeeklyTableViewController new];
//	[self.navigationController pushViewController:weeklyVC animated:YES];
	
}

- (IBAction)gotoRuntimeTableView:(id)sender {
	RuntimeTableViewController * rumtimeVC = [RuntimeTableViewController new];
	[self.navigationController pushViewController:rumtimeVC animated:YES];
	
}

- (IBAction)gotoContactView:(id)sender {
	
//	[self.navigationController pushViewController:rumtimeVC animated:YES];

}

- (IBAction)gotoPhotoView:(id)sender {
	
	PhotosViewController *photosViewController = [[PhotosViewController alloc] initWithNibName:@"PhotosViewController"  bundle:nil];
	
	[self.navigationController pushViewController:photosViewController animated:YES];

}
- (IBAction)gotoMessagePage:(id)sender {
	
	/**
	 *  @from                    v1.1.1
	 *  @brief                   获取验证码(Get verification code)
	 *
	 *  @param method            获取验证码的方法(The method of getting verificationCode)
	 *  @param phoneNumber       电话号码(The phone number)
	 *  @param zone              区域号，不要加"+"号(Area code)
	 *  @param customIdentifier  自定义短信模板标识 该标识需从官网http://www.mob.com上申请，审核通过后获得。(Custom model of SMS.  The identifier can get it  from http://www.mob.com  when the application had approved)
	 *  @param result            请求结果回调(Results of the request)
	 */
 
	[SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"18588826294"
								   zone:@"86"
					   customIdentifier:nil
								 result:^(NSError *error){
	 if (!error) {
		 NSLog(@"获取验证码成功");
	 } else {
		 NSLog(@"错误信息：%@",error);
	 }
								 }];
	

	/**
	 * @from               v1.1.1
	 * @brief              提交验证码(Commit the verification code)
	 *
	 * @param code         验证码(Verification code)
	 * @param phoneNumber  电话号码(The phone number)
	 * @param zone         区域号，不要加"+"号(Area code)
	 * @param result       请求结果回调(Results of the request)
	 */
//	[SMSSDK commitVerificationCode:self.verifyCodeField.text phoneNumber:_phone zone:_areaCode result:^(NSError *error) {
//		
//		if (!error) {
//			
//			NSLog(@"验证成功");
//			
//		}
//		else
//		{
//			NSLog(@"错误信息：%@",error);
//			
//		}
//	}];
	

}

- (IBAction)gotoBarcodeView:(id)sender {
	scanViewController * scan = [scanViewController new];
	[self.navigationController pushViewController:scan animated:YES];
}

- (IBAction)gotoNewsView:(id)sender {
	
	MyHomeViewController * newsHome = [MyHomeViewController new];
	[self.navigationController pushViewController:newsHome animated:YES];
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
