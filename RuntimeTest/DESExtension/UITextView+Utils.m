//
//  UITextView+Utils.m
//  RuntimeTest
//
//  Created by desmond on 16/5/18.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "UITextView+Utils.h"

@implementation UITextView (Utils)

//调用方法
//[textView setText:text lineSpacing:2.0f];


- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
	if (lineSpacing < 0.01 || !text) {
		self.text = text;
		return;
	}
	
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
	[attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
	
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	[paragraphStyle setLineSpacing:lineSpacing];
	[attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.attributedText length])];
	
	self.attributedText = attributedString;
}


//设置行高
+ (CGFloat)text:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing {
	UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, MAXFLOAT)];
	textView.font = [UIFont systemFontOfSize:fontSize];
	[textView setText:text lineSpacing:lineSpacing];
	[textView sizeToFit];
	return textView.height;
}
@end
