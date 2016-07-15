 //
//  LoginViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/6/7.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "ThirdLoginView.h"
#define mainSize    [UIScreen mainScreen].bounds.size

#define offsetLeftHand      60

#define rectLeftHand        CGRectMake(61-offsetLeftHand, 90, 40, 65)
#define rectLeftHandGone    CGRectMake(mainSize.width / 2 - 100, vLogin.frame.origin.y - 22, 40, 40)

#define rectRightHand       CGRectMake(imgLogin.frame.size.width / 2 + 60, 90, 40, 65)
#define rectRightHandGone   CGRectMake(mainSize.width / 2 + 62, vLogin.frame.origin.y - 22, 40, 40)

@interface LoginViewController ()<UITextFieldDelegate>
	
	@property (strong, nonatomic) UITextField *txtUser;
	@property (strong, nonatomic) UITextField *txtPwd;
	@property (strong, nonatomic) UIImageView* imgLeftHand;
	@property (strong, nonatomic) UIImageView* imgRightHand;
	@property (strong, nonatomic) UIImageView* imgLeftHandGone;
	@property (strong, nonatomic) UIImageView* imgRightHandGone;

	@property (strong, nonatomic) UIButton *dismissButton;
    @property (strong, nonatomic) UIButton *loginQQButton;
    @property (strong, nonatomic) UIButton *loginSinaWBButton;
    @property (strong, nonatomic) UIButton *loginTengxunWBButton;
    @property (strong, nonatomic) UIButton *registerButton;
    @property (strong, nonatomic) UIButton *loginButton;
    @property(nonatomic,strong) AppDelegate *globalApp;
    @property(nonatomic,strong) NSUserDefaults *userDefaults;

    @property (nonatomic, weak) ThirdLoginView *thirdView;
    @property (nonatomic, strong) UIButton *dragMeButton;


//NSUserDefaults 详细使用，读取写入，系统类，自定义类的用法，忘记了可以从下面网址回顾。
//http://www.jianshu.com/p/f935659fc637

//	UITextField* txtUser;
//	UITextField* txtPwd;
//	UIImageView* _imgLeftHand;
//	UIImageView* imgRightHand;
//	UIImageView* _imgLeftHandGone;
//	UIImageView* imgRightHandGone;

	@property (assign, nonatomic) JxbLoginShowType showType;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupLoginUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (ThirdLoginView *)thirdView
{
	if (!_thirdView) {
		ThirdLoginView *third = [[ThirdLoginView alloc] initWithFrame:CGRectMake(0, 0, 400, 200)];
		[third setClickLogin:^(LoginType type) {
			
			switch (type) {
				case LoginTypeSina:
					[self WeiboLogin];
					break;
				case LoginTypeQQ:
					//   [self QQLogin];
					break;
				case LoginTypeWechat:
					[self WeChatLogin];
					break;
					
				default:
					break;
			}
			DESLog(@"第三方登录。")
//			[self loginSuccess];
		}];
		third.hidden = NO;
//		third.hidden = YES;
		[self.view addSubview:third];
		_thirdView = third;
	}
	return _thirdView;
}

-(void)setupLoginUI{
	
//	UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_register_background.png"]];
//	[self.view addSubview:background];
//	[self.view sendSubviewToBack:background];
//	self.view.contentMode = UIViewContentModeScaleToFill;
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_register_background"]];
	

	
	UIImageView* imgLogin = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 211 / 2, 100, 211, 109)];
	imgLogin.image = [UIImage imageNamed:@"owl-login"];
	imgLogin.layer.masksToBounds = YES;
	[self.view addSubview:imgLogin];
	
	_imgLeftHand = [[UIImageView alloc] initWithFrame:rectLeftHand];
	_imgLeftHand.image = [UIImage imageNamed:@"owl-login-arm-left"];
	[imgLogin addSubview:_imgLeftHand];
	
	_imgRightHand = [[UIImageView alloc] initWithFrame:rectRightHand];
	_imgRightHand.image = [UIImage imageNamed:@"owl-login-arm-right"];
	[imgLogin addSubview:_imgRightHand];
	
	UIView* vLogin = [[UIView alloc] initWithFrame:CGRectMake(15, 200, kScreenWidth - 30, 160)];
	vLogin.layer.borderWidth = 0.5;
	vLogin.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	vLogin.backgroundColor = [UIColor clearColor];
	[self.view addSubview:vLogin];
	
	_imgLeftHandGone = [[UIImageView alloc] initWithFrame:rectLeftHandGone];
	_imgLeftHandGone.image = [UIImage imageNamed:@"icon_hand"];
	[self.view addSubview:_imgLeftHandGone];
	
	_imgRightHandGone = [[UIImageView alloc] initWithFrame:rectRightHandGone];
	_imgRightHandGone.image = [UIImage imageNamed:@"icon_hand"];
	[self.view addSubview:_imgRightHandGone];
	
	_txtUser = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, vLogin.frame.size.width - 60, 44)];
	_txtUser.delegate = self;
	_txtUser.layer.cornerRadius = 5;
	_txtUser.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	_txtUser.layer.borderWidth = 0.5;
	_txtUser.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
	_txtUser.leftViewMode = UITextFieldViewModeAlways;
	UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
	imgUser.image = [UIImage imageNamed:@"iconfont-user"];
	[_txtUser.leftView addSubview:imgUser];
	[vLogin addSubview:_txtUser];
	
	_txtPwd = [[UITextField alloc] initWithFrame:CGRectMake(30, 90, vLogin.frame.size.width - 60, 44)];
	_txtPwd.delegate = self;
	_txtPwd.layer.cornerRadius = 5;
	_txtPwd.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	_txtPwd.layer.borderWidth = 0.5;
	_txtPwd.secureTextEntry = YES;
	_txtPwd.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
	_txtPwd.leftViewMode = UITextFieldViewModeAlways;
	UIImageView* imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
	imgPwd.image = [UIImage imageNamed:@"iconfont-password"];
	[_txtPwd.leftView addSubview:imgPwd];
	[vLogin addSubview:_txtPwd];
	
	self.dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 50, 50)];
	[self.dismissButton setImage:[UIImage imageNamed:@"dismissBtn_Nav"] forState:UIControlStateNormal];
	[self.dismissButton addTarget:self action:@selector(dismissButtonClicked) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.dismissButton];
	
	
	
	self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 380, kScreenWidth-30, 50)];
	self.loginButton.backgroundColor = [UIColor clearColor];
	self.loginButton.layer.cornerRadius = 5;
	self.loginButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	self.loginButton.layer.borderWidth = 0.5;
	[self.loginButton.titleLabel setFont:[UIFont systemFontOfSize:15]];


	[self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.loginButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateHighlighted];
	[self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
	[self.loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];

	[self.view addSubview:self.loginButton];
	

	 self.registerButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 20, 80, 50)];
	[self.registerButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
	[self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.registerButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateHighlighted];
	[self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
	[self.registerButton addTarget:self action:@selector(registerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:self.registerButton];
 
	[self dargMeButtonUI];
	
	
	
	[self.thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.equalTo(@0);
		make.height.equalTo(@60);
		make.bottom.equalTo(@-60);
//		.offset(-40);
	}];
	
//	_loginQQButton = [[UIButton alloc] initWithFrame:CGRectMake(40, kScreenHeight-120, 200, 100)];
//	[_loginQQButton setImage:[UIImage imageNamed:@"login_QQ_icon"] forState:UIControlStateNormal];
//	[_loginQQButton addTarget:self action:@selector(qqButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:_loginQQButton];
//	
//	
//	_loginSinaWBButton = [[UIButton alloc] initWithFrame:CGRectMake(250, kScreenHeight-120, 200, 100)];
//	[_loginSinaWBButton setImage:[UIImage imageNamed:@"login_sina_icon"] forState:UIControlStateNormal];
//	[_loginSinaWBButton addTarget:self action:@selector(sinaButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:_loginSinaWBButton];
//	
//	_loginTengxunWBButton = [[UIButton alloc] initWithFrame:CGRectMake(450, kScreenHeight-120, 200, 100)];
//	[_loginTengxunWBButton setImage:[UIImage imageNamed:@"login_tecent_icon"] forState:UIControlStateNormal];
//	[_loginTengxunWBButton addTarget:self action:@selector(tecentButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:_loginTengxunWBButton];
	


}



- (void)dragMeButtonClicked:(UIPanGestureRecognizer *)panGesture{
	CGPoint transitionP = [panGesture translationInView:panGesture.view];
	CGFloat transitionX = fmax(20, fmin(_dragMeButton.center.x + transitionP.x, kScreenWidth - 20));
	CGFloat transitionY = fmax(64 + 20, fmin(_dragMeButton.center.y + transitionP.y, kScreenHeight- 20));
	_dragMeButton.center = CGPointMake(transitionX, transitionY);
	[panGesture setTranslation:CGPointZero inView:panGesture.view];
}

-(void)dargMeButtonUI{
	
	
	
//	_dragMeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, kScreenHeight-20 , 40, 40)];
	
	
	_dragMeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_dragMeButton.titleLabel.font = [UIFont systemFontOfSize:13];
	_dragMeButton.titleLabel.textAlignment = 1;
	
	[_dragMeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[_dragMeButton addTarget:self action:@selector(gotoTopPosition) forControlEvents:UIControlEventTouchUpInside];
	
	
	[_dragMeButton addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragMeButtonClicked:)]];
	[_dragMeButton setTitle:@"点我\n拖我" forState:UIControlStateNormal];
	_dragMeButton.backgroundColor = [UIColor lightGrayColor];
	_dragMeButton.titleLabel.numberOfLines = 0;
	_dragMeButton.titleLabel.font = [UIFont systemFontOfSize:12];
		_dragMeButton.bounds = CGRectMake(0, 0, 40, 40);
		_dragMeButton.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
	_dragMeButton.layer.cornerRadius = 20;
	[self.view addSubview:_dragMeButton];
}

- (void)dismissButtonClicked{
	
   [self dismissViewControllerAnimated:YES completion:nil];

//	if (self.is2FAUI) {
//		self.is2FAUI = NO;
//	}else{
//		[self dismissViewControllerAnimated:YES completion:nil];
//	}
}

- (void)gotoTopPosition{
	
}

- (void)loginButtonClicked{
	
	
//	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//		[self presentViewController:[[MainViewController alloc] init] animated:NO completion:^{
//			[self.player stop];
//			[self.player.view removeFromSuperview];
//			self.player = nil;
//		}];
//	});
	
	NSString *username = [self.txtUser.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *password = [self.txtPwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSLog(@"current width is %f and %f ",kScreenWidth,kScreenHeight);
	//在这里进行查询，登录；
	BmobQuery *query = [BmobQuery queryWithClassName:USER_TABLE];
	[query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
		if (!error) {
			
			BOOL isSuccessful = false;
			for (BmobObject *obj in array) {
				
				if ([[obj objectForKey:@"username"] isEqualToString:username] && [[obj objectForKey:@"Password"] isEqualToString:password]) {
					//表示登录成功；
					//登录成功要进行一次查询，查询出该用户的nickname；
					NSString *nickname = [obj objectForKey:@"nickname"];
					
					self.globalApp.GLOBAL_NICKNAME = nickname;
					self.globalApp.GLOBAL_USERNAME = username;
					self.globalApp.GLOBAL_USERID = [obj objectForKey:@"objectId"];
					self.globalApp.GLOBAL_PASSWORD = password;
					
					[self.userDefaults setObject:[obj objectForKey:@"objectId"] forKey:@"userId"];
					[self.userDefaults setObject:username forKey:@"username"];
					[self.userDefaults setObject:password forKey:@"Password"];
					[self.userDefaults setObject:nickname forKey:@"nickname"];
					
					isSuccessful = true;
					break;
				}//if();
			}//for();
			if (isSuccessful) {
				
				[self dismissViewControllerAnimated:YES completion:nil];
				UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoadData" bundle:nil];
				MainViewController *mainVC = (MainViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"mainVC"];
				[self.navigationController pushViewController:mainVC animated:YES];
			
			} else {
				
				[AllUtils showPromptDialog:@"提示" andMessage:@"登录失败，请输入正确的用户名和密码！" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
			}
		}else{
			
			[AllUtils showPromptDialog:@"提示" andMessage:@"网络异常，请稍候再试！" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
		}
	}];

}

- (void)qqButtonClicked{
}

- (void)sinaButtonClicked{
}

- (void)tecentButtonClicked{
}

-(void)registerButtonClicked{
	
	RegisterViewController *registerVC = [[[NSBundle mainBundle] loadNibNamed:@"RegisterViewController" owner:nil options:nil] lastObject];
	
	[self presentViewController:registerVC animated:YES completion:nil];

//	[self.navigationController pushViewController:registerVC animated:YES];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
	if ([textField isEqual:_txtUser]) {
		if (_showType != JxbLoginShowType_PASS)
		{
			_showType = JxbLoginShowType_USER;
			return;
		}
		_showType = JxbLoginShowType_USER;
		[UIView animateWithDuration:0.5 animations:^{
			_imgLeftHand.frame = CGRectMake(_imgLeftHand.frame.origin.x - offsetLeftHand, _imgLeftHand.frame.origin.y + 30, _imgLeftHand.frame.size.width, _imgLeftHand.frame.size.height);
			
			_imgRightHand.frame = CGRectMake(_imgRightHand.frame.origin.x + 48, _imgRightHand.frame.origin.y + 30, _imgRightHand.frame.size.width, _imgRightHand.frame.size.height);
			
			
			_imgLeftHandGone.frame = CGRectMake(_imgLeftHandGone.frame.origin.x - 70, _imgLeftHandGone.frame.origin.y, 40, 40);
			
			_imgRightHandGone.frame = CGRectMake(_imgRightHandGone.frame.origin.x + 30, _imgRightHandGone.frame.origin.y, 40, 40);
			
			
		} completion:^(BOOL b) {
		}];
		
	}
	else if ([textField isEqual:_txtPwd]) {
		if (_showType == JxbLoginShowType_PASS)
		{
			_showType = JxbLoginShowType_PASS;
			return;
		}
		_showType = JxbLoginShowType_PASS;
		[UIView animateWithDuration:0.5 animations:^{
			_imgLeftHand.frame = CGRectMake(_imgLeftHand.frame.origin.x + offsetLeftHand, _imgLeftHand.frame.origin.y - 30, _imgLeftHand.frame.size.width, _imgLeftHand.frame.size.height);
			_imgRightHand.frame = CGRectMake(_imgRightHand.frame.origin.x - 48, _imgRightHand.frame.origin.y - 30, _imgRightHand.frame.size.width, _imgRightHand.frame.size.height);
			
			
			_imgLeftHandGone.frame = CGRectMake(_imgLeftHandGone.frame.origin.x + 70, _imgLeftHandGone.frame.origin.y, 0, 0);
			
			_imgRightHandGone.frame = CGRectMake(_imgRightHandGone.frame.origin.x - 30, _imgRightHandGone.frame.origin.y, 0, 0);
			
		} completion:^(BOOL b) {
		}];
	}
}


- (IBAction)registerNewUser:(id)sender {
	

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
	
	[[AppDelegate sharedAppdelegate] getWXCodeStringWithController:self];
	[self dismissViewControllerAnimated:YES completion:nil];
}



//- (IBAction)loginBtn:(id)sender {
//	if ([CheckUtil isStrEmpty:accountTf.text]) {
//		[CheckUtil showAlertWithMessage:@"账号不能为空" delegate:self];
//		return;
//	}
//	
//	if ([CheckUtil isStrEmpty:passwordTf.text]) {
//		[CheckUtil showAlertWithMessage:@"密码不能为空" delegate:self];
//		return;
//	}
//	
//	[BmobUser loginInbackgroundWithAccount:accountTf.text andPassword:passwordTf.text block:^(BmobUser *user, NSError *error) {
//		if (user) {
//			//跳转
//			ShowUserMessageViewController *showUser = [[ShowUserMessageViewController alloc] init];
//			showUser.title = @"用户信息";
//			
//			[self.navigationController pushViewController:showUser animated:YES];
//		} else {
//			[CheckUtil showAlertWithMessage:[error description] delegate:self];
//		}
//	}];
//	
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



//当访问CGRect里的x, y, width, 或 height时，应该使用CGGeometry函数而不是直接通过结构体来访问。引用Apple的CGGeometry：
//
//CGRect frame = self.view.frame;
//CGFloat x = CGRectGetMinX(frame);
//CGFloat y = CGRectGetMinY(frame);
//CGFloat width = CGRectGetWidth(frame);
//CGFloat height = CGRectGetHeight(frame);
//CGRect frame = CGRectMake(0.0, 0.0, width, height);
//不应该：
//
//CGRect frame = self.view.frame;
//CGFloat x = frame.origin.x;
//CGFloat y = frame.origin.y;
//CGFloat width = frame.size.width;
//CGFloat height = frame.size.height;
//CGRect frame = (CGRect){ .origin = CGPointZero, .size = frame.size };


@end
