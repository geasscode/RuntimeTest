//
//  SuggestViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/6/13.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "SuggestViewController.h"
#import "SuggestView.h"


@interface SuggestViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property (nonatomic, strong) SuggestView *rootView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong)     UILabel *label;
@end

@implementation SuggestViewController

- (void)loadView {
	self.rootView = [[SuggestView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.view = _rootView;
}
- (void)viewDidLoad {
	
	self.tabBarController.tabBar.hidden=YES;
	self.navigationController.navigationBarHidden = NO;
	self.label = [[UILabel alloc]initWithFrame:CGRectMake(3, 4, 300, 20)];
	self.label.enabled = NO;
	self.label.text = @"请反馈问题或建议，帮助我们不断改进！";
	self.label.font =  [UIFont systemFontOfSize:15];
	self.label.textColor = [UIColor colorWithRed:225 / 255.0 green:220 / 255.0 blue:225 / 255.0 alpha:1.0];
	[_rootView.content addSubview:self.label];
	
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
	self.navigationItem.title = @"意见反馈";
//	[self configureLeftButton];
	[self configureRightButton];
	_rootView.content.delegate = self;
	_rootView.email.delegate = self;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


#pragma mark UITextFileDelegate

//点击空白区域，会触发的方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	//回收键盘
	[self.textField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	self.textField = textField;
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

#pragma mark - UITextViewDelegate设置默认文字

- (void)textViewDidChange:(UITextView *)textView {
	
	if (textView.text.length == 0) {
		[self.label setHidden:NO];
	} else {
		[self.label setHidden:YES];
	}
}
#pragma mark - 界面配置类
- (void)configureLeftButton {
	UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"qr_toolbar_more_hl"] style:UIBarButtonItemStylePlain target:self action:@selector(handleBack:)];
	self.navigationItem.leftBarButtonItem = left;
	
}
- (void)configureRightButton {
	UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(handleSend:)];
	self.navigationItem.rightBarButtonItem = right;
	
}


- (void)handleSend:(UIBarButtonItem *)item {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"反馈提醒" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
	if (_rootView.content.text.length  < 5) {
		alert.message = @"别吝啬，多留点字吧~";
	} else {
		
		BmobObject *feedbackObj = [[BmobObject alloc] initWithClassName:@"Feedback"];
		[feedbackObj setObject:_rootView.email.text forKey:@"contact"];
		[feedbackObj setObject:_rootView.content.text forKey:@"content"];
		[feedbackObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
			if (isSuccessful) {
				//发送推送
				BmobPush *push = [BmobPush push];
				BmobQuery *query = [BmobInstallation query];
				//条件为isDeveloper是true
				[query whereKey:@"isDeveloper" equalTo:[NSNumber numberWithBool:YES] ];
				[push setQuery:query];
				//推送内容为反馈的内容
				[push setMessage:_rootView.content.text];
				alert.message = @"反馈成功";
				[alert show];


				[push sendPushInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
					NSLog(@"push error =====>%@",[error description]);
				}];
			}
		}];
		_rootView.content.text = @"";
		_rootView.email.text = @"";
	}
}

@end
