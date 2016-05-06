//
//  UIControl+Blocks.h
//  RuntimeTest
//
//  Created by desmond on 16/5/6.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void (^ActionBlock)(id sender);

@interface UIControl (Blocks)
- (void)addEventHandler:(ActionBlock)handler forControlEvents:(UIControlEvents)controlEvents;

@end
