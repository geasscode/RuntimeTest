//
//  UILabel+Utils.h
//  RuntimeTest
//
//  Created by desmond on 16/5/18.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Utils)
//常用Label
+ (UILabel *)primaryLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment;

+ (UILabel *)secondaryBoldLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment;

+ (UILabel *)secondaryRegularLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment;

+ (UILabel *)tertiaryLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment;


//可以自定义大小的默认字体的Label
+ (UILabel *)labelWithDefaultBoldFontSize:(CGFloat)size Color:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment;

+ (UILabel *)labelWithDefaultRegularFontSize:(CGFloat)size Color:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment;

+ (UILabel *)longLabelWithRegularFontSize:(CGFloat)size Color:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment  linespacing:(CGFloat)linespacing string:(NSString *)string;

@end
