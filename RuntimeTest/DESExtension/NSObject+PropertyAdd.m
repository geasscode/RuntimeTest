//
//  NSObject+PropertyAdd.m
//  RuntimeTest
//
//  Created by desmond on 16/4/7.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "NSObject+PropertyAdd.h"
#import <objc/runtime.h>


static const char *key = "name";

@implementation NSObject (Property)


//runtime 源码地址
//http://www.opensource.apple.com/tarballs/

//我们知道在category里面是无法为category添加实例变量的。
//但是我们很多时候需要在category中添加和对象关联的值，这个时候可以求助关联对象来实现。


//但是关联对象又是存在什么地方呢？ 如何存储？ 对象销毁时候如何处理关联对象呢？
//在objc-references.mm文件中有个方法_object_set_associative_reference：
//所有的关联对象都由AssociationsManager管理
//AssociationsManager里面是由一个静态AssociationsHashMap来存储所有的关联对象的。
//这相当于把所有对象的关联对象都存在一个全局map里面。而map的的key是这个对象的指针地址
//（任意两个不同对象的指针地址一定是不同的），而这个map的value又是另外一个AssociationsHashMap，里面保存了关联对象的kv对。

//
//runtime的销毁对象函数objc_destructInstance里面会判断这个对象有没有关联对象，
//如果有，会调用_object_remove_assocations做关联对象的清理工作。



+ (void)load
{
	NSLog(@"%@",@"load PropertyAdd");
}

- (NSString *)name
{
	// 根据关联的key，获取关联的值。
	return objc_getAssociatedObject(self, key);
}

- (void)setName:(NSString *)name
{
	// 第一个参数：给哪个对象添加关联
	// 第二个参数：关联的key，通过这个key获取
	// 第三个参数：关联的value
	// 第四个参数:关联的策略
	objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//WebView 保存图片要用到的。遍历Dom树获取src属性
- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects
{
	// 方法签名(对方法的描述)
	NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
	
	if (signature == nil) {
		[NSException raise:@"严重错误" format:@"(%@)方法找不到", NSStringFromSelector(selector)];
	}
	
	/*NSInvocation : 利用一个NSInvocation对象通过调用方法签名来实现对方法的调用（方法调用者、方法名、方法参数、方法返回值）
	 如果仅仅完成这步，和普通的函数调用没有区别，但是关键在于NSInvocation可以对传递进来的selector进行包装，实现可以传递无限多个参数
	 普通的方法调用比如:[self performSelector:<#(SEL)#> withObject:<#(id)#> withObject:<#(id)#>]顶多只能传递两个参数给selector*/
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
	invocation.target = self; //调用者是自己
	invocation.selector = selector; //调用的方法是selector
	
	// 设置参数，可以传递无限个参数
	NSInteger paramsCount = signature.numberOfArguments - 2; // 除self、_cmd以外的参数个数
	paramsCount = MIN(paramsCount, objects.count); //防止函数有参数但是不传递参数时，导致崩溃
	for (NSInteger i = 0; i < paramsCount; i++) {
		id object = objects[i];
		if ([object isKindOfClass:[NSNull class]]) continue; //如果传递的参数为null，就不处理了
		[invocation setArgument:&object atIndex:i + 2]; // +2是因为第一个和第二个参数默认是self和_cmd
	}
	
	// 调用方法
	[invocation invoke];
	
	// 获取返回值
	id returnValue = nil;
	if (signature.methodReturnLength) { // 有返回值类型，才去获得返回值
		[invocation getReturnValue:&returnValue];
	}
	
	return returnValue;
}
@end
