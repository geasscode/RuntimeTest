//
//  UIBarButtonItem+Extension.m
//  RuntimeTest
//
//  Created by desmond on 16/5/9.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)




+ (instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action{
	UIButton *button = [[UIButton alloc] init];
	//设置不同状态的image
	[button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	[button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
	//根据图片大小设置当前button的大小
	button.size = button.currentImage.size;
	
	//添加点击事件
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	
	return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (instancetype)itemWithImageName:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action{
	
	UIButton *button = [[UIButton alloc] init];
	//设置不同状态的image
	[button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	[button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
	
	//设置title
	[button setTitle:title forState:UIControlStateNormal];
	
	//设置title不同状态的颜色
	
	[button setTitleColor:globalColor forState:UIControlStateNormal];
	
	//根据内容调整大小
	[button sizeToFit];
	
	//添加点击事件
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	
	return [[UIBarButtonItem alloc] initWithCustomView:button];
	
	
}


/** 提供一个快速创建带有高亮图像的类方法*/
+ (instancetype)barButtonItemWithTarget:(id)target action:(SEL)action icon:(NSString *)icon hightlightIcon:(NSString *)hightlightIcon
{
	//创建按钮
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
	[button setImage:[UIImage imageNamed:hightlightIcon] forState:UIControlStateHighlighted];
	
	//按钮的大小可以跟图像大小一致
	button.size = button.currentImage.size;
	
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	return [[UIBarButtonItem alloc] initWithCustomView:button];
}



+ (instancetype)barButtonLeftItemWithImageName:(NSString *)imageName
										target:(id)target
										action:(SEL)action {
	UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 22)];
	[button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
	return barButtonItem;
}

+ (instancetype)barButtonRightItemWithImageName:(NSString *)imageName
										 target:(id)target
										 action:(SEL)action {
	UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 22)];
	[button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	button.imageEdgeInsets = UIEdgeInsetsMake(0, 28, 0, 0);
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
	return barButtonItem;
	
}

+ (instancetype)barButtonItemWithImageName:(NSString *)imageName
						   imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
									target:(id)target
									action:(SEL)action {
	UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 22)];
	[button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	button.imageEdgeInsets = imageEdgeInsets;
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
	return barButtonItem;
}

+ (instancetype)barButtonItemWithTitle:(NSString *)title
								target:(id)target
								action:(SEL)action {
	UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
	button.titleLabel.textAlignment = NSTextAlignmentRight;
	[button setTitleColor:kThemeColor forState:UIControlStateNormal];
	button.titleLabel.font = [UIFont systemFontOfSize:16];
	[button setTitle:title forState:UIControlStateNormal];
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
	return barButtonItem;
}

+ (instancetype)barButtonItemWithTitle:(NSString *)title
						 selectedTitle:(NSString *)selTitle
								target:(id)target
								action:(SEL)action {
	UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
	[button setTitleColor:kThemeColor forState:UIControlStateNormal];
	button.titleLabel.font = [UIFont systemFontOfSize:16];
	[button setTitle:title forState:UIControlStateNormal];
	[button setTitle:selTitle forState:UIControlStateSelected];
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
	return barButtonItem;
}

//+ (instancetype)shoppingCartIconWithTarget:(id)target action:(SEL)action {
//	XCFCartIcon *icon = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFCartIcon class])
//													   owner:nil options:nil] lastObject];
//	icon.frame = CGRectMake(0, 0, 30, 44);
//	[icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
//	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:icon];
//	return barButtonItem;
//}

@end
