//
//  IPhoneSizeTool.h
//  Randomer
//
//  Created by 王子轩 on 16/4/9.
//  Copyright © 2016年 com.wzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPhoneSizeTool : NSObject
typedef NS_ENUM(NSInteger,Version) {
    VersioniPhone4 = 0,
    VersioniPhone5,
    VersioniPhone6,
    VersioniPhone6p
};
+ (CGRect)RectWithiPhone6p:(CGRect)iphone6p iPhone6:(CGRect)iphone6 iPhone5:(CGRect)iphone5 iPhone4:(CGRect)iphone4;

+ (CGFloat)FloatWithiPhone6p:(CGFloat)iphone6p iPhone6:(CGFloat)iphone6 iPhone5:(CGFloat)iphone5 iPhone4:(CGFloat)iphone4;

+ (CGSize)SizeWithiPhone6p:(CGSize)iphone6p iPhone6:(CGSize)iphone6 iPhone5:(CGSize)iphone5 iPhone4:(CGSize)iphone4;

+ (CGPoint)PointWithiPhone6p:(CGPoint)iphone6p iPhone6:(CGPoint)iphone6 iPhone5:(CGPoint)iphone5 iPhone4:(CGPoint)iphone4;

+ (BOOL)greaterThan:(Version)version;
+ (BOOL)lessThan:(Version)version;
+ (BOOL)equel:(Version)version;
@end
