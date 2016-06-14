//
//  RegisterView.m
//  RuntimeTest
//
//  Created by desmond on 16/6/13.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "RegisterView.h"
#define TIME 60

@implementation RegisterView

//- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel andType:(Type)type {
//	self.viewModel = (RegisterViewModel *)viewModel;
//	self.type = type;
//	self.isSend = NO;
//	return [super initWithViewModel:viewModel];
//}

- (void)updateConstraints {
	WS(weakSelf)
	[_usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(weakSelf.mas_top).with.offset(0);
		make.left.equalTo(weakSelf.mas_left).with.offset(10);
		make.right.equalTo(weakSelf.mas_right).with.offset(-10);
		make.height.equalTo(@(50));
	}];
	
	[_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_usernameTextField.mas_bottom).offset(15);
		make.left.equalTo(weakSelf.mas_left).offset(10);
		make.right.equalTo(_sendCodeBtn.mas_left).offset(-10);
		make.height.equalTo(_usernameTextField);
	}];
	
	[_sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_usernameTextField.mas_bottom).offset(15);
		make.right.equalTo(weakSelf).offset(-10);
		make.height.equalTo(_codeTextField);
		make.width.equalTo(_codeTextField).offset(-80);
	}];
	
	[_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_codeTextField.mas_bottom).offset(15);
		make.left.equalTo(weakSelf.mas_left).offset(10);
		make.right.equalTo(weakSelf.mas_right).offset(-10);
		make.height.equalTo(_usernameTextField);
	}];
	
	[_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(_passwordTextField.mas_bottom).offset(100);
		make.left.equalTo(weakSelf).offset(50);
		make.right.equalTo(weakSelf).offset(-50);
		make.height.equalTo(@(50));
	}];
	[super updateConstraints];
}

- (void)wzx_bindViewModel {
	@weakify(self)
	RACSignal * validNameSignal = [self.usernameTextField.rac_textSignal map:^id(NSString * text) {
		return @((text.length >= 11));
	}];
	
	RACSignal * validCodeSignal = [self.codeTextField.rac_textSignal map:^id(NSString * text) {
		return @((text.length > 0));
	}];
	
	RACSignal * validPassSignal = [self.passwordTextField.rac_textSignal map:^id(NSString * text) {
		return @(text.length > 0);
	}];
	
	[validNameSignal subscribeNext:^(NSNumber * valid) {
		@strongify(self)
		self.sendCodeBtn.enabled = [valid boolValue]&&(!_isSend);
		self.sendCodeBtn.alpha = ([valid boolValue]&&(!_isSend))?1:0.8;
	}];
	
	RAC(self.registerBtn,enabled) = [RACSignal combineLatest:@[validNameSignal,validCodeSignal,validPassSignal] reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid,NSNumber * codeValid){
		BOOL valid = [usernameValid boolValue]&&[passwordValid boolValue]&&[codeValid boolValue];
		_registerBtn.alpha = valid ? 1: 0.8;
		return @(valid);
	}];
	
	[[self.sendCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
		@strongify(self)
		[self changeBtnTitle];
		
		//        switch (_type) {
		//            case Register: {
		//                [self.viewModel requestSmsCodeWithmobilePhoneNumber:self.usernameTextField.text success:^(id response) {
		//                     [self changeBtnTitle];
		//                    NSLog(@"注册验证码发送成功");
		//                } failure:^{
		//                    NSLog(@"注册验证码发送失败");
		//                } error:^(NSError *error) {
		//                    NSLog(@"注册验证码发送错误");
		//                }];
		//            }
		//                break;
		//            case Forget: {
		//                [self.viewModel requestPasswordResetBySmsCodeWithmobilePhoneNumber:self.usernameTextField.text success:^(id response) {
		//                     [self changeBtnTitle];
		//                    NSLog(@"重置验证码发送错误");
		//                } failure:^{
		//                    NSLog(@"重置验证码发送错误");
		//                } error:^(NSError *error) {
		//                    NSLog(@"重置验证码发送错误");
		//                }];
		//            }
		//                break;
		//            default:
		//                break;
		//        }
		
	}];
	
	[[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
		@strongify(self)
		//[[[LoginViewModel alloc]init]toMain];
		[self.viewModel registerWithNum:@"123" password:@"123" success:^(id response) {
			
		} failure:^{
			
		} error:^(NSError *error) {
			
		}];
		//        switch (_type) {
		//            case Register: {
		//                [self.viewModel registerWithNum:_usernameTextField.text smscode:_codeTextField.text password:_passwordTextField.text success:^(id response) {
		//        [self.viewModel toMain];
		//                    NSLog(@"注册成功");
		//                } failure:^{
		//                    NSLog(@"注册失败");
		//                } error:^(NSError *error) {
		//                    NSLog(@"注册错误");
		//                }];
		//            }
		//                break;
		//            case Forget: {
		//                [self.viewModel resetPasswordWithPhoneNumber:_usernameTextField.text smsCode:_codeTextField.text password:_passwordTextField.text success:^(id response) {
		//        [self.viewModel toMain];
		//                    NSLog(@"重置成功");
		//                } failure:^{
		//                    NSLog(@"重置失败");
		//                } error:^(NSError *error) {
		//                    NSLog(@"重置错误");
		//                }];
		//            }
		//                break;
		//            default:
		//                break;
		//        }
		
	}];
	
}

- (void)changeBtnTitle {
	_isSend = YES;
	_sendCodeBtn.enabled = NO;
	_sendCodeBtn.alpha = 0.8;
	[_sendCodeBtn setTitle:[NSString stringWithFormat:@"%ds后可重新发送",TIME] forState:UIControlStateNormal];
	[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange:) userInfo:nil repeats:YES];
}

- (void)timeChange:(NSTimer *)timer {
	NSInteger num = [_sendCodeBtn.titleLabel.text integerValue];
	num --;
	if (num < 1) {
		[_sendCodeBtn setTitle:[Statics localizable:@"发送验证码"] forState:UIControlStateNormal];
		_isSend = NO;
		_sendCodeBtn.alpha = 1;
		_sendCodeBtn.enabled = YES;
		[timer invalidate];
	}else {
		[_sendCodeBtn setTitle:[NSString stringWithFormat:@"%lds后可重新发送",(long)num] forState:UIControlStateNormal];
	}
}

- (void)wzx_setupViews {
	[self addSubview:self.usernameTextField];
	[self addSubview:self.passwordTextField];
	[self addSubview:self.codeTextField];
	[self addSubview:self.sendCodeBtn];
	[self addSubview:self.registerBtn];
	[self setNeedsUpdateConstraints];
	[self updateConstraintsIfNeeded];
}

- (BaseTextField *)usernameTextField {
	if (!_usernameTextField) {
		_usernameTextField = [BaseTextField new];
		_usernameTextField.placeholder = [Statics localizable:@"手机号"];
		_usernameTextField.tintColor = COLOR_BASE;
		_usernameTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
	}
	return _usernameTextField;
}

- (BaseTextField *)passwordTextField {
	if (!_passwordTextField) {
		_passwordTextField = [BaseTextField new];
		_passwordTextField.placeholder = [Statics localizable:@"密码"];
		_passwordTextField.tintColor = COLOR_BASE;
		_passwordTextField.secureTextEntry = YES;
		_passwordTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
	}
	return _passwordTextField;
}

- (BaseTextField *)codeTextField {
	if (!_codeTextField) {
		_codeTextField = [BaseTextField new];
		_codeTextField.placeholder = [Statics localizable:@"验证码"];
		_codeTextField.tintColor = COLOR_BASE;
		_codeTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
	}
	return _codeTextField;
}

- (UIButton *)registerBtn {
	if (!_registerBtn) {
		_registerBtn = [UIButton new];
		[_registerBtn setTitle:_type == Register ? [Statics localizable:@"注册"]:[Statics localizable:@"找回密码"] forState:UIControlStateNormal];
		_registerBtn.backgroundColor = COLOR_BASE;
	}
	return _registerBtn;
}

- (UIButton *)sendCodeBtn {
	if (!_sendCodeBtn) {
		_sendCodeBtn = [UIButton new];
		[_sendCodeBtn setTitle:[Statics localizable:@"发送验证码"] forState:UIControlStateNormal];
		_sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
		_sendCodeBtn.backgroundColor = COLOR_BASE;
	}
	return _sendCodeBtn;
}
- (void)d {
	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
