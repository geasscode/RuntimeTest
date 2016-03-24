// Post.m
//
// Copyright (c) 2011–2016 Alamofire Software Foundation ( http://alamofire.org/ )
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "Post.h"
#import "User.h"
#import <objc/runtime.h>

#import "AFAppDotNetAPIClient.h"

@implementation Post

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
//  https://api.app.net/stream/0/posts/stream/global 拼接之后显示的jason，不需要参数。
    self.postID = (NSUInteger)[[attributes valueForKeyPath:@"id"] integerValue];
    self.text = [attributes valueForKeyPath:@"text"];
    //user是个集合。
    self.user = [[User alloc] initWithAttributes:[attributes valueForKeyPath:@"user"]];
    
    return self;
}

#pragma mark -

//[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:parameters error:nil];


//一般都是继承自AFHTTPSessionManager 用单例的形式返回，下面是不使用继承的原始代码。

//AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
//sessionManager.requestSerializer     = [AFHTTPRequestSerializer serializer];
//sessionManager.responseSerializer    = [AFHTTPResponseSerializer serializer];
//[sessionManager GET:urlString
//		 parameters:parameters
//		   progress:progressBlock
//			success:successHandler
//			failure:failureHandler];

+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block {
    return [[AFAppDotNetAPIClient sharedClient] GET:@"stream/0/posts/stream/global" parameters:nil progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSArray *postsFromResponse = [JSON valueForKeyPath:@"data"];
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary *attributes in postsFromResponse) {
            Post *post = [[Post alloc] initWithAttributes:attributes];
            [mutablePosts addObject:post];
        }

        if (block) {
            block([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

@end

@implementation Post (NSCoding)




//原理描述：用runtime提供的函数遍历Model自身所有属性，并对属性进行encode和decode操作。
//核心方法：在Model的基类中重写方法：

//- (id)initWithCoder:(NSCoder *)aDecoder {
//	if (self = [super init]) {
//		unsigned int outCount;
//		Ivar * ivars = class_copyIvarList([self class], &outCount);
//		for (int i = 0; i < outCount; i ++) {
//			Ivar ivar = ivars[i];
//			NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
//			[self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
//		}
//	}
//	return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//	unsigned int outCount;
//	Ivar * ivars = class_copyIvarList([self class], &outCount);
//	for (int i = 0; i < outCount; i ++) {
//		Ivar ivar = ivars[i];
//		NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
//		[aCoder encodeObject:[self valueForKey:key] forKey:key];
//	}
//}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:(NSInteger)self.postID forKey:@"AF.postID"];
    [aCoder encodeObject:self.text forKey:@"AF.text"];
    [aCoder encodeObject:self.user forKey:@"AF.user"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.postID = (NSUInteger)[aDecoder decodeIntegerForKey:@"AF.postID"];
    self.text = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"AF.text"];
    self.user = [aDecoder decodeObjectOfClass:[User class] forKey:@"AF.user"];
    
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

//在开发中相信最常用的就是接口数据需要转化成Model了（当然如果你是直接从Dict取值的话。。。）
//很多开发者也都使用著名的第三方库如JsonModel、Mantle或MJExtension等，
//如果只用而不知其所以然，那真和“搬砖”没啥区别了

//读者可以进一步思考：
//1、如何识别基本数据类型的属性并处理
//2、空（nil，null）值的处理
//3、json中嵌套json（Dict或Array）的处理


//显示属性相关信息
-(void)showAttributeInfo{
	unsigned int outCount = 0;
	objc_property_t * properties = class_copyPropertyList([self class], &outCount);
	for (unsigned int i = 0; i < outCount; i ++) {
		objc_property_t property = properties[i];
		//属性名
		const char * name = property_getName(property);
		//属性描述
		const char * propertyAttr = property_getAttributes(property);
		NSLog(@"属性描述为 %s 的 %s ", propertyAttr, name);
		
		//属性的特性
		unsigned int attrCount = 0;
		objc_property_attribute_t * attrs = property_copyAttributeList(property, &attrCount);
		for (unsigned int j = 0; j < attrCount; j ++) {
			objc_property_attribute_t attr = attrs[j];
			const char * name = attr.name;
			const char * value = attr.value;
			NSLog(@"属性的描述：%s 值：%s", name, value);
		}
		free(attrs);
		NSLog(@"\n");
	}
	free(properties);
}

//获取成员变量
-(void)showIvarInfo{
	
	unsigned int outCount = 0;
	Ivar * ivars = class_copyIvarList([self class], &outCount);
	for (unsigned int i = 0; i < outCount; i ++) {
		Ivar ivar = ivars[i];
		const char * name = ivar_getName(ivar);
		const char * type = ivar_getTypeEncoding(ivar);
		NSLog(@"类型为 %s 的 %s ",type, name);
	}
	free(ivars);
}


//访问私有变量
//Ivar ivar = class_getInstanceVariable([Model class], "_str1");
//NSString * str1 = object_getIvar(model, ivar);

//使用runtime去解析json来给Model赋值。
//原理描述：用runtime提供的函数遍历Model自身所有属性，如果属性在json中有对应的值，则将其赋值。
//核心方法：在NSObject的分类中添加方法：

- (instancetype)initWithDict:(NSDictionary *)dict {
	
	if (self = [self init]) {
		//(1)获取类的属性及属性对应的类型
		NSMutableArray * keys = [NSMutableArray array];
		NSMutableArray * attributes = [NSMutableArray array];
		/*
		 * 例子
		 * name = value3 attribute = T@"NSString",C,N,V_value3
		 * name = value4 attribute = T^i,N,V_value4
		 */
		unsigned int outCount;
		objc_property_t * properties = class_copyPropertyList([self class], &outCount);
		for (int i = 0; i < outCount; i ++) {
			objc_property_t property = properties[i];
			//通过property_getName函数获得属性的名字
			NSString * propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
			[keys addObject:propertyName];
			//通过property_getAttributes函数可以获得属性的名字和@encode编码
			NSString * propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
			[attributes addObject:propertyAttribute];
		}
		//立即释放properties指向的内存
		free(properties);
		
		//根据类型给属性赋值
		for (NSString * key in keys) {
			if ([dict valueForKey:key] == nil) continue;
			[self setValue:[dict valueForKey:key] forKey:key];
		}
	}
	return self;
	
}



//如何給NSArray添加一个属性（不能使用继承）

//通常我们会在类声明里面添加属性，但是出于某些需求（如前言描述的情况），
//我们需要在分类里添加一个或多个属性的话，编译器就会报错，
//这个问题的解决方案就是使用runtime的关联对象。


//- (void)setCustomTabbar:(UIView *)customTabbar {
//	//这里使用方法的指针地址作为唯一的key
//	objc_setAssociatedObject(self, @selector(customTabbar), customTabbar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (UIView *)customTabbar {
//	return objc_getAssociatedObject(self, @selector(customTabbar));
//}
//
//
//[self.tabBarController.customTabbar doSomgthig];



@end
