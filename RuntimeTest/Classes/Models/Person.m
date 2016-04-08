//
//  Person.m
//  RuntimeDemo
//
//  Created by 黄轩 on 16/3/18.
//  Copyright © 2016年 黄轩 blog.libuqing.com. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@interface Person () <NSCoding>

@end

@implementation Person 

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count;
    //获得指向当前类的所有属性的指针
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        //获取指向当前类的一个属性的指针
        objc_property_t property = properties[i];
        //获取C字符串属性名
        const char *name = property_getName(property);
        //C字符串转OC字符串
        NSString *propertyName = [NSString stringWithUTF8String:name];
        //通过关键词取值
        NSString *propertyValue = [self valueForKey:propertyName];
        //编码属性
        [aCoder encodeObject:propertyValue forKey:propertyName];
    }
    //记得释放
    free(properties);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    unsigned int count;
    //获得指向当前类的所有属性的指针
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        //获取指向当前类的一个属性的指针
        objc_property_t property = properties[i];
        //获取C字符串属性名
        const char *name = property_getName(property);
        //C字符串转OC字符串
        NSString *propertyName = [NSString stringWithUTF8String:name];
        //解码属性值
        NSString *propertyValue = [aDecoder decodeObjectForKey:propertyName];
        [self setValue:propertyValue forKey:propertyName];
    }
    //记得释放
    free(properties);
    return self;
}

//吃饭
// 默认方法都有两个隐式参数，
void eat(id self,SEL sel)
{
	NSLog(@"%@ %@",self,NSStringFromSelector(sel));
}

//睡觉
- (void)sleep {
    
}

//工作
- (void)work {
    
}

// 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.
// 刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
	
	if (sel == @selector(eat)) {
		// 动态添加eat方法
		
		// 第一个参数：给哪个类添加方法
		// 第二个参数：添加方法的方法编号
		// 第三个参数：添加方法的函数实现（函数地址）
		// 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
		class_addMethod(self, @selector(eat), eat, "v@:");
		
	}
	
	return [super resolveInstanceMethod:sel];
}

@end
