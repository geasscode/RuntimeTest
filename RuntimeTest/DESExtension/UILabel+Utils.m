//
//  UILabel+Utils.m
//  RuntimeTest
//
//  Created by desmond on 16/5/18.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)

//设置行距
//调用[label setText:text lineSpacing:2.0f];

- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
	if (lineSpacing < 0.01 || !text) {
		self.text = text;
		return;
	}
	
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
	[attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
	
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	[paragraphStyle setLineSpacing:lineSpacing];
	[paragraphStyle setLineBreakMode:self.lineBreakMode];
	[paragraphStyle setAlignment:self.textAlignment];
	[attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
	
	self.attributedText = attributedString;
}


//设置行高
+ (CGFloat)text:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing {
	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, MAXFLOAT)];
	label.font = [UIFont systemFontOfSize:fontSize];
	label.numberOfLines = 0;
	[label setText:text lineSpacing:lineSpacing];
	[label sizeToFit];
	return label.height;
}



+ (UILabel *)primaryLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.font = kDefaultPrimaryFont;
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;
    
    return label;
}

+ (UILabel *)secondaryBoldLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.font = kDefaultSecondaryBoldFont;
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;
    
    return label;
}

+ (UILabel *)secondaryRegularLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.font = kDefaultSecondaryRegularFont;
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;
    
    return label;
}


+ (UILabel *)tertiaryLabelWithColor:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.font = kDefaultTertiaryFont;
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;
    
    return label;
}


+ (UILabel *)labelWithDefaultBoldFontSize:(CGFloat)size Color:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.font = kDefaultFontBoldWith(size);
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;
    
    return label;
}

+ (UILabel *)labelWithDefaultRegularFontSize:(CGFloat)size Color:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment{
    
    UILabel *label = [[UILabel alloc] init];
    label.font = kDefaultFontRegularWith(size);
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;
    
    return label;
}

+ (UILabel *)longLabelWithRegularFontSize:(CGFloat)size Color:(UIColor *)color textAlignment:(NSTextAlignment )textAlignment  linespacing:(CGFloat)linespacing string:(NSString *)string{
    
    UILabel *label = [[UILabel alloc] init];
    label.font = kDefaultFontRegularWith(size);
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;
    
    //根据String对象创建NSMutableAttributedString
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    //设置段落间距的大小
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:linespacing];
    [paragraphStyle setAlignment:textAlignment];
    //对attributedString对象设置间距属性
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
    
    //为label设置text
    [label setAttributedText:attributedString];
    
    return label;
}






@end
