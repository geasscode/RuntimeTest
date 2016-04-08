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

@end
