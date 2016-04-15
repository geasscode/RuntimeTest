//
//  SocketTest.m
//  RuntimeTest
//
//  Created by desmond on 16/4/13.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "SocketTest.h"

@implementation SocketTest


//Socket是对TCP/IP协议的封装，Socket本身并不是协议，而是一个调用接口（API），通过Socket，我们才能使用TCP/IP协议。
//
//http协议 对应于应用层
//tcp协议 对应于传输层
//ip协议 对应于网络层
//三者本质上没有可比性。 何况HTTP协议是基于TCP连接的。
//TCP/IP是传输层协议，主要解决数据如何在网络中传输；而HTTP是应用层协议，主要解决如何包装数据。


//我 们在传输数据时，可以只使用传输层（TCP/IP），但是那样的话，由于没有应用层，
//便无法识别数据内容，如果想要使传输的数据有意义，则必须使用应用层 协议，应用层协议很多，
//有HTTP、FTP、TELNET等等，也可以自己定义应用层协议。
//WEB使用HTTP作传输层协议，以封装HTTP文本信息，然后使用TCP/IP做传输层协议将它发送到网络上。


//套接字之间的连接过程分为三个步骤：服务器监听，客户端请求，连接确认。



@end
