//
//  LoginViewController.h
//  RuntimeTest
//
//  Created by desmond on 16/6/7.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JxbLoginShowType) {
	JxbLoginShowType_NONE,
	JxbLoginShowType_USER,
	JxbLoginShowType_PASS
};

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *loginUserNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordTextfield;
@property (strong, nonatomic) UIImageView *iconUserView, *bgBlurredView;

@end
