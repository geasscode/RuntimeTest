//
//  UIViewController+swizzling.m
//  RuntimeTest
//
//  Created by desmond on 16/4/7.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "UIViewController+swizzling.h"
#import <objc/runtime.h>

@implementation UIViewController (swizzling)


//Method Swizzling 也叫做“方法调配”、“方法混合”、“方法调和”，是用来互换两个方法的实现的技巧。

//比如我们用方法 A 实现了 a 这件事，方法 B 实现了 b 这件事，现在你非要用 A 实现 b，B 实现 a，即便技术上是可行的，
//load方法会在类第一次加载的时候被调用
//调用的时间比较靠前，适合在这个方法里做方法交换
+ (void)load{
	//方法交换应该被保证，在程序中只会执行一次
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		//获得viewController的生命周期方法的selector
		SEL systemSel = @selector(viewWillAppear:);
		//自己实现的将要被交换的方法的selector
		SEL swizzSel = @selector(swiz_viewWillAppear:);
		//两个方法的Method
		Method systemMethod = class_getInstanceMethod([self class], systemSel);
		Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
		
		//首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
		BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
		if (isAdd) {
			//如果成功，说明类中不存在这个方法的实现
			//将被交换方法的实现替换到这个并不存在的实现
			class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
		}else{
			//否则，交换两个方法的实现
			method_exchangeImplementations(systemMethod, swizzMethod);
		}
		
	});
}

- (void)swiz_viewWillAppear:(BOOL)animated{
	//这时候调用自己，看起来像是死循环
	//但是其实自己的实现已经被替换了
	[self swiz_viewWillAppear:animated];
	NSLog(@"swizzle");
}

@end
