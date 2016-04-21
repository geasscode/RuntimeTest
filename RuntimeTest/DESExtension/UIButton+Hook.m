//
//  UIButton+Hook.m
//  RuntimeTest
//
//  Created by desmond on 16/4/20.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "UIButton+Hook.h"
#import <objc/runtime.h>
#import "Tool.h"

@implementation UIButton (Hook)

+ (void)load {
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		Class selfClass = [self class];
		
		SEL oriSEL = @selector(sendAction:to:forEvent:);
		Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
		
		SEL cusSEL = @selector(mySendAction:to:forEvent:);
		Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);
		
		BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
		if (addSucc) {
			class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
		}else {
			method_exchangeImplementations(oriMethod, cusMethod);
		}
		
	});
}

- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
	[[Tool sharedManager] addCount];
	[self mySendAction:action to:target forEvent:event];
}

@end
