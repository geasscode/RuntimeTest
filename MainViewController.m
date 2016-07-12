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
#import "BarCodeViewController.h"
#import "ZYKeyboardUtil.h"
#import "FirstViewController.h"
#import "DownloadTestVC.h"
#import "ReadFeedbackTableViewController.h"
#define MARGIN_KEYBOARD 20


@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITextField *hideKeyboardTest;
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50)];
	[btn setTitle:@"JSPatch Test" forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(handleBtn:) forControlEvents:UIControlEventTouchUpInside];
	[btn setBackgroundColor:[UIColor grayColor]];
	[self.view addSubview:btn];

	//查看源码
//	clang -rewrite-objc MyClass.m
	
	//用户好评系统test
	LBToAppStore *toAppStore = [[LBToAppStore alloc]init];
	toAppStore.myAppID = @"1067787090";
	[toAppStore showGotoAppStore:self];
	
	
	self.hideKeyboardTest.delegate = self;
	
	[self configKeyBoardRespond];

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


- (void)configKeyBoardRespond {
	
	
//	ZYKeyboardUtil 通过lazy方式注册键盘通知监听者，核心工作围绕一个model和四个Block(一个主功能Block和三个附加Block)，内部类KeyboardInfo作为model存储着每次处理时所需的键盘信息。animateWhenKeyboardAppearAutomaticAnimBlock作全自动处理，animateWhenKeyboardAppearBlock作键盘展示时的处理，animateWhenKeyboardDisappearBlock作键盘收起时的处理，而printKeyboardInfoBlock用作在必要时输出键盘信息。AppearBlock和DisappearBlock统一做了UIViewAnimation，自定义处理事件时只需要编写需要的界面变化即可。
	
	self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
	
	__weak MainViewController *weakSelf = self;
	
	//自定义键盘弹出处理
#pragma explain - use animateWhenKeyboardAppearAutomaticAnimBlock, animateWhenKeyboardAppearBlock must be nil.
	/*
	 [_keyboardUtil setAnimateWhenKeyboardAppearBlock:^(int appearPostIndex, CGRect keyboardRect, CGFloat keyboardHeight, CGFloat keyboardHeightIncrement) {
	 
	 NSLog(@"\n\n键盘弹出来第 %d 次了~  高度比上一次增加了%0.f  当前高度是:%0.f"  , appearPostIndex, keyboardHeightIncrement, keyboardHeight);
	 
	 //处理
	 UIWindow *window = [UIApplication sharedApplication].keyWindow;
	 CGRect convertRect = [weakSelf.mainTextField.superview convertRect:weakSelf.mainTextField.frame toView:window];
	 
	 if (CGRectGetMinY(keyboardRect) - MARGIN_KEYBOARD < CGRectGetMaxY(convertRect)) {
	 CGFloat signedDiff = CGRectGetMinY(keyboardRect) - CGRectGetMaxY(convertRect) - MARGIN_KEYBOARD;
	 //updateOriginY
	 CGFloat newOriginY = CGRectGetMinY(weakSelf.view.frame) + signedDiff;
	 weakSelf.view.frame = CGRectMake(weakSelf.view.frame.origin.x, newOriginY, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
	 }
	 }];
	 */
	
	
	//全自动键盘弹出处理 (需调用keyboardUtil 的 adaptiveViewHandleWithController:adaptiveView:)
#pragma explain - use animateWhenKeyboardAppearBlock, animateWhenKeyboardAppearAutomaticAnimBlock will be invalid.
	[_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
		[keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.hideKeyboardTest, nil];
	}];
	
	
	//自定义键盘收起处理(如不配置，则默认启动自动收起处理)
#pragma explain - if not configure this Block, automatically itself.
	
	 [_keyboardUtil setAnimateWhenKeyboardDisappearBlock:^(CGFloat keyboardHeight) {
	 NSLog(@"\n\n键盘在收起来~  上次高度为:+%f", keyboardHeight);
	 
	 //uodateOriginY
	 CGFloat newOriginY = 0;
	 weakSelf.view.frame = CGRectMake(weakSelf.view.frame.origin.x, newOriginY, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
	 }];
	
	
	
	//获取键盘信息
	[_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
		//弹出前是y是－200，弹出后是64.textField 被隐藏掉了，应该再加上setAnimateWhenKeyboardDisappearBlock 重置Y坐标。
		NSLog(@"\n\n拿到键盘信息 和 ZYKeyboardUtil对象,%f,%f",weakSelf.view.frame.origin.x,weakSelf.view.frame.origin.y);
	}];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoTestView:(id)sender {
	
	ReadFeedbackTableViewController *readFeedBack  = [ReadFeedbackTableViewController new];
	[self.navigationController pushViewController:readFeedBack animated:YES];

//	
//	DownloadTestVC *downloadTest = [DownloadTestVC new];
//	[self.navigationController pushViewController:downloadTest animated:YES];
	
	/*
	
	UIImage * webImage = [UIImage new];
		NSString *webImageURL = @"http://img1.tuicool.com/FfqABjf.jpg";
	
//	UIImage *img = [UIImage imageNamed:@"arrow.png"];
	
	NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:webImageURL]];
	UIImage* webURL = [UIImage imageWithData:data];
												  
												  //UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
//	UIImageWriteToSavedPhotosAlbum(webURL, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

	
	UIImageWriteToSavedPhotosAlbum(webURL, self, nil,nil );
	
//	FirstViewController *firstVC = [FirstViewController new];
//	[self.navigationController pushViewController:firstVC animated:YES];

	*/
//	UIButton *btn = (UIButton *)sender;
//	
//	[btn addTarget:self action:@selector(handleBtn:) forControlEvents:UIControlEventTouchUpInside];

//	[self handleBtn:sender];
}

- (void)handleBtn:(id)sender
{
	
	    NSLog(@"hello");
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
	
	BarCodeViewController *barcode = [BarCodeViewController new];
	[self.navigationController pushViewController:barcode animated:YES];
//	scanViewController * scan = [scanViewController new];
//	[self.navigationController pushViewController:scan animated:YES];
}

- (IBAction)gotoNewsView:(id)sender {
	
	MyHomeViewController * newsHome = [MyHomeViewController new];
	[self.navigationController pushViewController:newsHome animated:YES];
}


//解决虚拟键盘挡住UITextField的方法


#pragma mark delegate
//点击编辑区以外的地方
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[self.hideKeyboardTest resignFirstResponder];
}

//实现轻触 Return 关闭键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self.hideKeyboardTest resignFirstResponder];

	return YES;
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
