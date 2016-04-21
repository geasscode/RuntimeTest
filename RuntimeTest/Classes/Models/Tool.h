//
//  Tool.h
//  RuntimeTest
//
//  Created by desmond on 16/4/20.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

+ (instancetype)sharedManager;
- (NSString *)changeMethod;
- (void)addCount;
@end
