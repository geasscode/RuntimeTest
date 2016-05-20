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

@end
