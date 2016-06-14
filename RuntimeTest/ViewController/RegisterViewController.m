//
//  RegisterViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/6/13.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"
#import "RegisterViewModel.h"
#import "IPhoneSizeTool.h"

@interface RegisterViewController ()

@property (nonatomic,strong)UIImageView * backgroundView;
@property (nonatomic,strong)RegisterView * mainView;
@property (nonatomic,strong)RegisterViewModel * viewModel;
@property (nonatomic,strong)UIButton * backBtn;
@property (nonatomic,assign)Type type;

@end

@implementation RegisterViewController



- (instancetype)initWithType:(Type)type {
	if (self = [super init]) {
		_type = type;
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)updateViewConstraints {
	WS(weakSelf)
	[self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(weakSelf.view);
	}];
	
	CGFloat top = [IPhoneSizeTool FloatWithiPhone6p:160 iPhone6:180 iPhone5:130 iPhone4:100];
	[self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(weakSelf.view).offset(top);
		make.left.equalTo(weakSelf.view).offset(10);
		make.right.equalTo(weakSelf.view).offset(-10);
		make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-10);
	}];
	
	[self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(weakSelf.view).offset(50);
		make.left.equalTo(weakSelf.view).offset(20);
		make.height.equalTo(@(30));
	}];
	
	[super updateViewConstraints];
}

- (void)wzx_addSubviews {
	[self.view addSubview:self.backgroundView];
	[self.view addSubview:self.mainView];
	[self.view addSubview:self.backBtn];
	[self.view setNeedsUpdateConstraints];
	[self.view updateConstraintsIfNeeded];
}

- (void)wzx_bindViewModel {
	[self recoverKeyboard];
//	[[self.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//		[self dismissViewControllerAnimated:YES completion:^{
//		}];
//	}];
	
	
}


- (void)recoverKeyboard {
	UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
	tap.numberOfTapsRequired = 1;
	tap.numberOfTouchesRequired = 1;
//	[tap.rac_gestureSignal subscribeNext:^(id x) {
//		
//		[[UIApplication sharedApplication].keyWindow endEditing:YES];
//	}];
	[self.view addGestureRecognizer:tap];
}

- (void)wzx_getNewData {
	
}

- (void)wzx_layoutNavigation {
	
}

- (UIImageView *)backgroundView {
	if (!_backgroundView) {
		_backgroundView = [UIImageView new];
		_backgroundView.image = [UIImage imageWithContentsOfFile:FilePATH(@"base_map", @"jpg")];
	}
	return _backgroundView;
}


- (RegisterView *)mainView {
	if (!_mainView) {
//		_mainView = [[RegisterView alloc]initWithViewModel:self.viewModel andType:_type];
	}
	return _mainView;
}

- (RegisterViewModel *)viewModel {
	if (!_viewModel) {
		_viewModel = [[RegisterViewModel alloc]init];
	}
	return _viewModel;
}

- (UIButton *)backBtn {
	if (!_backBtn) {
		_backBtn = [UIButton new];
//		[_backBtn setTitle:[Statics localizable:@"返回"] forState:UIControlStateNormal];
	}
	return _backBtn;
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
