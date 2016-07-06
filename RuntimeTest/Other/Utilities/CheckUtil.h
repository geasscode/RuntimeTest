//
//  CheckUtil.h
//  RuntimeTest
//
//  Created by desmond on 16/7/5.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckUtil : NSObject

+ (BOOL) isStrEmpty:(NSString*)string;

+ (void) showAlertWithMessage:(NSString*)message delegate:(id)delegate;

@end
