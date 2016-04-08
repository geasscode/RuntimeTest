//
//  NSMutableArray+Extension.m
//  RuntimeTest
//
//  Created by desmond on 16/4/7.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>


@implementation NSMutableArray (Extension)

//可以调用，因为附加category到类的工作会先于+load方法的执行
//+load的执行顺序是先类，后category，而category的+load执行顺序是根据编译顺序决定的。
// 编译顺序可以再 build Phases栏中的 Compile Source 中调顺序。

//初入宝地-category简介
//连类比事-category和extension
//挑灯细览-category真面目
//追本溯源-category如何加载
//旁枝末叶-category和+load方法
//触类旁通-category和方法覆盖
//更上一层-category和关联对象

+(void)load{
	
	//方法交换应该被保证，在程序中只会执行一次
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		//获得viewController的生命周期方法的selector
		SEL systemSel = @selector(addObject:);
		//自己实现的将要被交换的方法的selector
		SEL swizzSel = @selector(gp_addObject:);
		//两个方法的Method
		Method systemMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), systemSel);
		Method swizzMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), swizzSel);
		
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

//怎么调用到原来类中被category覆盖掉的方法？
//对于这个问题，我们已经知道category其实并不是完全替换掉原来类的同名方法，只是category在方法列表的前面而已，所以我们只要顺着方法列表找到最后一个对应名字的方法，就可以调用原来类的方法：
-(void)gp_addObject:(id)object{
	if(object!=nil){
		[self gp_addObject:object];
	}
}


//-(void)callOriginMethod{
//	Class currentClass = [MyClass class];
//	MyClass *my = [[MyClass alloc] init];
// 
//	if (currentClass) {
//		unsigned int methodCount;
//		Method *methodList = class_copyMethodList(currentClass, &methodCount);
//		IMP lastImp = NULL;
//		SEL lastSel = NULL;
//		for (NSInteger i = 0; i NSString *methodName = [NSString stringWithCString:sel_getName(method_getName(method))
//																		  encoding:NSUTF8StringEncoding];
//			 if ([@"printName" isEqualToString:methodName]) {
//				 lastImp = method_getImplementation(method);
//				 lastSel = method_getName(method);
//			 }
//    }
//    typedef void (*fn)(id,SEL);
//			 
//    if (lastImp != NULL) {
//		fn f = (fn)lastImp;
//		f(my,lastSel);
//	}
//    free(methodList);
//			 }
//}

@end
