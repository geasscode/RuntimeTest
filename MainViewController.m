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

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
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
