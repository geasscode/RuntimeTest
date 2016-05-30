//
//  UIBarButtonItem+Extension.h
//  RuntimeTest
//
//  Created by desmond on 16/5/9.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)



/**
 *  通过一张图片返回一个UIBarButtonItem
 *
 */
+ (instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;


/**
 *  通过一张图片与文字返回一个UIBarButtonItem
 *
 */

+ (instancetype)itemWithImageName:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action;



/** 提供一个快速创建带有高亮图像的类方法*/
+ (instancetype)barButtonItemWithTarget:(id)target action:(SEL)action icon:(NSString *)icon hightlightIcon:(NSString *)hightlightIcon;


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
