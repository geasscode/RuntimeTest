//
//  main.m
//  RuntimeTest
//
//  Created by desmond on 16/3/17.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
	
	
//	这个方法会为main thread 设置一个NSRunLoop 对象，这就解释了本文开始说的为什么我们的应用可以在无人操作的时候休息，需要让它干活的时候又能立马响应。
	@autoreleasepool {
	    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
	}
}

// From here to end of file added by Injection Plugin //

//#ifdef DEBUG
//static char _inMainFilePath[] = __FILE__;
//static const char *_inIPAddresses[] = {"10.0.0.81", "192.168.2.1", "169.254.161.67", "127.0.0.1", 0};
//
//#define INJECTION_ENABLED
//#import "/tmp/injectionforxcode/BundleInjection.h"
//#endif
