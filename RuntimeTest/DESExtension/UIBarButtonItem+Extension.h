//
//  UIBarButtonItem+Extension.h
//  RuntimeTest
//
//  Created by desmond on 16/5/9.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)barButtonLeftItemWithImageName:(NSString *)imageName
										target:(id)target
										action:(SEL)action;
+ (instancetype)barButtonRightItemWithImageName:(NSString *)imageName
										 target:(id)target
										 action:(SEL)action;
+ (instancetype)barButtonItemWithImageName:(NSString *)imageName
						   imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
									target:(id)target
									action:(SEL)action;


+ (instancetype)barButtonItemWithTitle:(NSString *)title
								target:(id)target
								action:(SEL)action;
+ (instancetype)barButtonItemWithTitle:(NSString *)title
						 selectedTitle:(NSString *)selTitle
								target:(id)target
								action:(SEL)action;


+ (instancetype)shoppingCartIconWithTarget:(id)target
									action:(SEL)action;
@end
