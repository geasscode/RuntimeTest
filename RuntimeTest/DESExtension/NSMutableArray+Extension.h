//
//  NSMutableArray+Extension.h
//  RuntimeTest
//
//  Created by desmond on 16/4/7.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>



//extension一般用来隐藏类的私有信息，你必须有一个类的源码才能为一个类添加extension，
//所以你无法为系统的类比如NSString添加extension。
//但是category则完全不一样，它是在运行期决议的。
//就category和extension的区别来看，我们可以推导出一个明显的事实，extension可以添加实例变量，而category是无法添加实例变量的（因为在运行期，对象的内存布局已经确定，如果添加实例变量就会破坏类的内部布局，这对编译型语言来说是灾难性的）。


//所有的OC类和对象，在runtime层都是用struct表示的




//从category的定义也可以看出category的可为（可以添加实例方法，类方法，甚至可以实现协议，添加属性）和不可为（无法添加实例变量）。
/*
 typedef struct category_t {
	const char *name;  //类的名字（name）
	classref_t cls;//类（cls）
	struct method_list_t *instanceMethods;        //category中所有给类添加的实例方法的列表（instanceMethods）
	struct method_list_t *classMethods;          //category中所有添加的类方法的列表（classMethods）
	struct protocol_list_t *protocols;           //category实现的所有协议的列表（protocols）
	struct property_list_t *instanceProperties; //category中添加的所有属性（instanceProperties）
 } category_t;
 
 */

@interface NSMutableArray (Extension)

@end
