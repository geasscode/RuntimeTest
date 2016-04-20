//
//  ViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/3/17.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Person.h"
#import "NSObject+PropertyAdd.h"
#import "NSMutableArray+Extension.h"

@interface ViewController ()<PersonDelegate>

@property (readwrite, nonatomic, strong) NSMutableArray *arrayM;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
//	[self.arrayM addObject:nil];
//	Person * person = [Person new];
//	
//	[person performSelector:@selector(eat)];
//	
	//死锁代码：
	
//	viewDidLoad 在主线程中， 及在dispatch_get_main_queue() 中，执行到sync 时 向
//	dispatch_get_main_queue()插入 同步 threed。sync 会等到 后面block 执行完成才返回， sync 又在 dispatch_get_main_queue() 队列中，它是串行队列，sync 是后加入的，前一个是主线程，所以 sync 想执行 block 必须等待主线程执行完成，主线程等待 sync 返回，去执行后续内容。造成成死锁

//	NSLog(@"=================4");
//	dispatch_sync(dispatch_get_main_queue(),
//				  ^{ NSLog(@"=================5"); });
//	NSLog(@"=================6");
	
	
	//非死锁代码
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		NSLog(@"=================1");
		dispatch_sync(dispatch_get_main_queue(), ^{
			NSLog(@"=================2"); }
					  );
		NSLog(@"=================3"); }
				   );

//	首先： async 在主线程中 创建了一个异步线程加入全局并发队列，async 不会等待block 执行完成，立即返回，
//	1，async 立即返回， viewDidLoad 执行完毕，及主线程执行完毕。
//	2，同时，全局并发队列立即执行异步 block ， 打印 1， 当执行到 sync 它会等待 block 执行完成才返回， 及等待dispatch_get_main_queue() 队列中的 mianThread 执行完成， 然后才开始调用block 。因为1 和 2 几乎同时执行，因为2 在全局并发队列上， 2 中执行到sync 时 1 可能已经执行完成或 等了一会，mainThread 很快退出， 2 等已执行后继续内容。如果阻塞了主线程，2 中的sync 就无法执行啦，mainThread 永远不会退出， sync 就永远等待着。
	

	
	// 给系统NSObject类动态添加属性name
	
//	NSObject *objc = [[NSObject alloc] init];
	
//	objc.name = @"噢mygade";
//	NSLog(@"%@",objc.name);
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	NSLog(@"viewWillAppear");
	
//	请分析下SDWebImage的原理
//http://www.jianshu.com/p/8f16613861fa
}

- (void)injected
{
	NSLog(@"I've been injecteds: %@", self);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

//GCD是apple提出的为提高多核效率的多线程实现方案，它在系统层级帮助开发者维护线程的生命周期，包括线程的创建、休眠、销毁等，开发者只需要关心需要实现的功能，将需要做的操作放到调度队列（dispatch queue）中，系统会根据线程的情况自动分配资源。
- (IBAction)runTimeTest:(id)sender {
	
//	常见作用
//	
//	动态的添加对象的成员变量和方法
//	动态交换两个方法的实现
//	拦截并替换方法
//	在方法上增加额外功能
//	实现NSCoding的自动归档和解档
//	实现字典转模型的自动转换
//	
//	RunTime简称运行时。就是系统在运行的时候的一些机制，其中最主要的是消息机制。OC的函数调用成为消息发送。属于动态调用过程。在编译的时候并不能决定真正调用哪个函数（事实证明，在编 译阶段，OC可以调用任何函数，即使这个函数并未实现，只要申明过就不会报错。而C语言在编译阶段就会报错）。只有在真正运行的时候才会根据函数的名称找 到对应的函数来调用。
	
//	[obj makeText];
//	编译器转化后
//	objc_msgSend(obj,@selector(makeText));
//
//	[tableView cellForRowAtIndexPath:indexPath];
//	在编译时RunTime会将上述代码转化成[发送消息]
//	objc_msgSend(tableView, @selector(cellForRowAtIndexPath:),indexPath);
	
//	在objc_msgSend函数中。首先通过obj的isa指针找到obj对应的class。在Class中先去cache中
// 通过SEL查找对应函数method（猜测cache中method列表是以SEL为key通过hash表来存储的，这样能提高函数查找速度），
//	若 cache中未找到。再去methodList中查找，若methodlist中未找到，则取superClass中查找。
//	若能找到，则将method加 入到cache中，以方便下次查找，并通过method中的函数指针跳转到对应的函数中去执行。
	
	
//	现在有一个Person类，和person创建的xiaoming对象,有test1和test2两个方法
//	获得类方法
//
//	Class PersonClass = object_getClass([Person class]);
//	SEL oriSEL = @selector(test1);
//	Method oriMethod = class_getInstanceMethod(xiaomingClass, oriSEL);
//	获得实例方法
//	
//
//	Class PersonClass = object_getClass([xiaoming class]);
//	SEL oriSEL = @selector(test2);
//	Method cusMethod = class_getInstanceMethod(xiaomingClass, oriSEL);
//	添加方法
//	
//
//	BOOL addSucc = class_addMethod(xiaomingClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
//	替换原方法实现
//	
//
//	class_replaceMethod(toolClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
//	交换两个方法
//	
//
//	method_exchangeImplementations(oriMethod, cusMethod);
	

	
	
	[self getIvarList];
	[self getPropertyList];
	[self getMethodList];
	[self getProtocolList];
	[self archiverTest];
	[ self dismissViewControllerAnimated: YES completion: nil ];
}

//
//GCD Queue 分为三种：
//1，The main queue ：主队列，主线程就是在个队列中。
//2，Global queues ： 全局并发队列。
//3，用户队列:是用函数 dispatch_queue_create创建的自定义队列


//dispatch_sync 和 dispatch_async 区别：
//dispatch_async(queue,block) async 异步队列，dispatch_async
//函数会立即返回, block会在后台异步执行。
//
//dispatch_sync(queue,block) sync 同步队列，dispatch_sync
//函数不会立即返回，及阻塞当前线程,等待 block同步执行完成。

//
//GCD引入了任务（task）和调度队列（dispatch queue）的概念。
//所谓的任务，其实就是你要实现的功能和操作，即你要做什么；
//调度队列，是实现功能的方式，简单说就是你想怎么做。


//队列中的所有任务都按照FIFO的顺序执行，GCD提供了三种队列：
//
//串行队列
//并行队列
//主队列
- (IBAction)GCDTest:(id)sender {
	
}

//
///// 描述类中的一个方法
//typedef struct objc_method *Method;
//
///// 实例变量
//typedef struct objc_ivar *Ivar;
//
///// 类别Category
//typedef struct objc_category *Category;
//
///// 类中声明的属性
//typedef struct objc_property *objc_property_t;

/**
 *  获取一个类的全部成员变量名
 */
- (void)getIvarList {
	NSLog(@"使用class_copyIvarList获取一个类的全部成员变量名");

	unsigned int count;
	
	//返回一个指向类的成员变量数组的指针
	Ivar *ivars = class_copyIvarList([Person class], &count);

	for (unsigned int i=0; i < count; i++) {
		Ivar ivar = ivars[i];
		//根据ivar获得其成员变量的名称
		const char *name = ivar_getName(ivar);
		//C的字符串转OC的字符串
		NSString *key = [NSString stringWithUTF8String:name];

		NSLog(@"%d == %@",i,key);
		
		//set up value
//		object_setIvar(Person, ivar, @"20");
		

	}
	//根据Apple官方runtime.h文档所示，上面两个方法返回的指针，在使用完毕之后必须free()。
	free(ivars);
}

/**
 *  获取一个类的全部属性名
 */
- (void)getPropertyList {
	
	NSLog(@"使用class_copyPropertyList获取一个类的全部属性名");
	unsigned int count;
	
	//获得指向该类所有属性的指针
	objc_property_t *properties = class_copyPropertyList([Person class], &count);
	
	for (unsigned int i=0 ; i < count; i++) {
		//获得该类的一个属性的指针
		objc_property_t property = properties[i];
		//获取属性的名称
		const char *name = property_getName(property);
		//将C的字符串转为OC的
		NSString *key = [NSString stringWithUTF8String:name];
		
		NSLog(@"%d == %@",i,key);
	}
	//记得释放
	free(properties);
}

/**
 *  获取一个类的全部方法
 */
- (void)getMethodList {
	
	NSLog(@"使用class_copyMethodList获取一个类的全部方法");

	
	unsigned int count;
	//获取指向该类所有方法的指针
	Method *methods = class_copyMethodList([Person class], &count);
	
	for (unsigned int i=0 ; i < count; i++) {
		//获取该类的一个方法的指针
		Method method = methods[i];
		//获取方法
		SEL methodSEL = method_getName(method);
		//将方法转换为C字符串
		const char *name = sel_getName(methodSEL);
		//将C字符串转为OC字符串
		NSString *methodName = [NSString stringWithUTF8String:name];
		
		//获取方法参数个数
		int arguments = method_getNumberOfArguments(method);
		
		NSLog(@"%d == %@ %d",i,methodName,arguments);
	}
	//记得释放
	free(methods);
}

/**
 *  获取一个类遵循的全部协议
 */
- (void)getProtocolList {
	
	NSLog(@"使用class_copyProtocolList获取一个类遵循的全部协议");

	unsigned int count;
	
	//获取指向该类遵循的所有协议的指针
	__unsafe_unretained Protocol **protocols = class_copyProtocolList([self class], &count);
	
	for (unsigned int i=0; i < count; i++) {
		//获取该类遵循的一个协议指针
		Protocol *protocol = protocols[i];
		//获取C字符串协议名
		const char *name = protocol_getName(protocol);
		//C字符串转OC字符串
		NSString *protocolName = [NSString stringWithUTF8String:name];
		NSLog(@"%d == %@",i,protocolName);
	}
	//记得释放
	free(protocols);
}

/**
 *  归档/解档
 */
- (void)archiverTest {
	
	NSLog(@"归档/解档");
	Person *person = [[Person alloc] init];
	person.name = @"黄轩";
	person.sex = @"男";
	person.age = 29;
	person.height = 175.1;
	person.education = @"本科";
	person.job = @"iOS工程师";
	person.native = @"湖北";
	
	NSString *path = [NSString stringWithFormat:@"%@/archive",NSHomeDirectory()];
	[NSKeyedArchiver archiveRootObject:person toFile:path];
	
	Person *unarchiverPerson = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
	
	NSLog(@"unarchiverPerson == %@ %@",path,unarchiverPerson);
}


-(void)dynamicAddMethod{
	
}

- (void)personDelegateToWork
{
	NSLog(@"使用class_copyProtocolList获取一个类遵循的全部协议");

}


- (void) methodone{
	dispatch_group_t group = dispatch_group_create();
	
	dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		NSLog(@"%d",1);
	});
	
	dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		NSLog(@"%d",2);
	});
	
	
//	主队列：每一个应用开发程序对应唯一一个主队列，在多线程开发中，使用主队列更新UI。
//	
//	dispatch_queue_t q = dispatch_get_main_queue();
//	主队列是GCD自带的串行队列，会在主线程中执行。异步全局并发队列 开启新线程，并发执行。
//	
//	并行队列里开启同步任务是有执行顺序的，只有异步才没有顺序。

//	串行队列开启异步任务，是有顺序的。
//	串行队列开启异步任务后嵌套同步任务造成死锁。
	

	dispatch_group_notify(group, dispatch_get_main_queue(), ^{
		NSLog(@"3");
		
		dispatch_group_t group1 = dispatch_group_create();
		
		dispatch_group_async(group1, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			NSLog(@"%d",4);
		});
		
		dispatch_group_async(group1, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			NSLog(@"%d",5);
		});
		
	});
	
}

@end
