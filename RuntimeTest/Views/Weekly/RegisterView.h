//
//  RegisterView.h
//  RuntimeTest
//
//  Created by desmond on 16/6/13.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTextField.h"
#import "RegisterViewModel.h"


@interface RegisterView : UIView
typedef NS_ENUM(NSInteger,Type) {
	Register,
	Forget
};

//- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel andType:(Type)type;
@property (nonatomic,assign)Type type;
@property(nonatomic,strong)RegisterViewModel * viewModel;
@property(nonatomic,strong)BaseTextField * usernameTextField;
@property(nonatomic,strong)BaseTextField * passwordTextField;
@property(nonatomic,strong)BaseTextField * codeTextField;
@property(nonatomic,strong)UIButton * sendCodeBtn;
@property(nonatomic,strong)UIButton * registerBtn;


@property(nonatomic,assign)BOOL isSend;
@end
