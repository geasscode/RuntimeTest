//
//  RunLoopTest.m
//  RuntimeTest
//
//  Created by desmond on 16/4/8.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "RunLoopTest.h"

@implementation RunLoopTest


//Run Loop是一让线程能随时处理事件但不退出的机制。RunLoop 实际上是一个对象，这个对象管理了其需要处理的事件和消息，并提供了一个入口函数来执行Event Loop 的逻辑。
//Run Loop的四个作用:
//
//使程序一直运行接受用户输入
//决定程序在何时应该处理哪些Event
//调用解耦
//节省CPU时间

//使用run loop可以使你的线程在有工作的时候工作，没有工作的时候休眠，这可以大大节省系统资源。

//进程至少有 5 种基本状态，它们是：初始态，执行态，等待状态，就绪状态，终止状态。

@end
